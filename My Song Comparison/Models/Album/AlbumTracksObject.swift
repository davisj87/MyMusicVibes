//
//  AlbumTracksObject.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/22/23.
//

import Foundation

struct AlbumTracksObject: Decodable {
    var id: String
    var artists:[AlbumArtistObject]
    var name:String
    var trackNumber:Int
    
    private enum CodingKeys: String, CodingKey {
        case id, artists, name
        case trackNumber = "track_number"
    }
    
}
/*
 
 "items": [
     {
       "artists": [
         {
           "external_urls": {
             "spotify": "https://open.spotify.com/artist/480xKab3lUPhBBnCzlzqIu"
           },
           "href": "https://api.spotify.com/v1/artists/480xKab3lUPhBBnCzlzqIu",
           "id": "480xKab3lUPhBBnCzlzqIu",
           "name": "Taylor Davis",
           "type": "artist",
           "uri": "spotify:artist:480xKab3lUPhBBnCzlzqIu"
         }
       ],
       "disc_number": 1,
       "duration_ms": 197880,
       "explicit": false,
       "external_urls": {
         "spotify": "https://open.spotify.com/track/1bIJTvGgkoNrDJSvkowFWC"
       },
       "href": "https://api.spotify.com/v1/tracks/1bIJTvGgkoNrDJSvkowFWC",
       "id": "1bIJTvGgkoNrDJSvkowFWC",
       "is_local": false,
       "name": "Gateway",
       "preview_url": "https://p.scdn.co/mp3-preview/5a769b549d1c64ec0d842b529d337e79c04e87db?cid=774b29d4f13844c495f206cafdad9c86",
       "track_number": 1,
       "type": "track",
       "uri": "spotify:track:1bIJTvGgkoNrDJSvkowFWC"
     },
 
 */
