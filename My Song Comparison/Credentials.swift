//
//  Constants.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/24/23.
//

import Foundation

struct Credentials {
    static var token:String = ""
    static var refreshToken:String = ""
    
    static let clientID:String = "f014c68e0d0e4947943c58230465fd98"
    static let redirectURI: String = "https://taylordavisviolin.com/"
    static let scope: String = "user-top-read playlist-read-private user-follow-read user-read-recently-played user-library-read playlist-read-private"
    
    private init(){}
}
