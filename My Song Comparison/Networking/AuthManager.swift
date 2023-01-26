//
//  AuthManager.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/13/23.
//

import Foundation

struct TokenStorageObject:Codable {
    let authToken: String
    let refreshToken:String
    let expiresIn: Date
}

actor AuthManager {
    
    // All Keychain for the auth token access flows through here
    
    private var currentToken: TokenStorageObject? {
        get {
            let service = KeychainHelper.tokenSeviceStr
            guard let result = KeychainHelper.standard.read(service: service,
                                                            type: TokenStorageObject.self)
            else {
                return nil
            }
            return result
        }
    }// This should fetch the current token from the keychain
    private var refreshTask: Task<TokenStorageObject?, Error>?

    func validToken() async throws -> TokenStorageObject? {
        if let handle = refreshTask {
            return try await handle.value
        }

        guard let token = currentToken else {
            throw RequestError.missingToken
        }

        if Date() < token.expiresIn {
            return token
        }
        
        return try await refreshToken()
    }

    func refreshToken() async throws -> TokenStorageObject? {
        //This is where we can set our new token values in the keychain
        if let refreshTask = refreshTask {
                return try await refreshTask.value
            }

            let task = Task { () throws -> TokenStorageObject? in
                defer { refreshTask = nil }
                let refreshEndpoint = RefreshTokenEndpoint()
                let authRequest = AuthRequest(endpoint: refreshEndpoint)
                guard let tokenObject = try await authRequest.executeRequestWithPayload(refreshEndpoint.payloadData) else {
                    throw RequestError.tokenRefreshError
                }
                let calendar = Calendar.current
                guard let expirationDate = calendar.date(byAdding: .second, value: tokenObject.expiresIn - 120 , to: Date()) else {
                    throw RequestError.tokenRefreshError
                }
                
                let auth = TokenStorageObject(authToken: tokenObject.authToken, refreshToken: tokenObject.refreshToken, expiresIn: expirationDate)
                let service = KeychainHelper.tokenSeviceStr
                
                // Save `auth` to keychain
                KeychainHelper.standard.save(auth, service: service)
                
                return auth
            }

            self.refreshTask = task

            return try await task.value
    }
}
