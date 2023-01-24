//
//  AuthViewModel.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/2/23.
//

import Foundation

struct AuthViewModel {
    private let authEndpoint = AuthEndpoint()
    var authEndpointURL:URL {
        return authEndpoint.url
    }
    
    func getAndSaveAuthToken(authCode:String) async throws {
        var tokenEndpoint = TokenEndpoint()
        tokenEndpoint.authCode = authCode
        tokenEndpoint.codeVerifier = self.authEndpoint.codeVerifier!
        
        let tokenRequest = AuthRequest(endpoint: tokenEndpoint)
        
        guard let tokenObject = try await tokenRequest.executeRequestWithPayload(tokenEndpoint.payloadData) else {
            throw AuthError.missingToken
        }
        let calendar = Calendar.current
        guard let expirationDate = calendar.date(byAdding: .second, value: tokenObject.expiresIn - 120 , to: Date()) else {
            throw AuthError.missingToken
        }
        
        let auth = TokenStorageObject(authToken: tokenObject.authToken, refreshToken: tokenObject.refreshToken, expiresIn: expirationDate)
        let service = KeychainHelper.tokenSeviceStr
        
        // Save `auth` to keychain
        KeychainHelper.standard.save(auth, service: service)
        
    }
    
//    func getAlbumSearch() async throws {
//        let searchAlbumEndpoint = SearchAlbumEndpoint(searchString: "Taylor Davis Odyssey")
//
//        let searchAlbumRequest = APIRequest(endpoint: searchAlbumEndpoint)
//
//        guard let searchAlbumObject = try await searchAlbumRequest.executeRequest() else {
//            return
//        }
//        print(searchAlbumObject)
//    }
    
}
