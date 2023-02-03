//
//  PlaylistTracksChartViewModel.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 2/2/23.
//

import SwiftUI

class PlaylistTracksChartViewModel: ObservableObject, TrackDetailViewFormatter {
    
    private let tracksDetailArr: Set<TrackFeaturesObject?>
    @Published var musicalPositivityArr:[MusicalPositivity] = []
    
    init(tracksDetailArr:Set<TrackFeaturesObject?>) {
        self.tracksDetailArr = tracksDetailArr
    }
    
    func getMusicalPositivityData() {
        var lowCount = 0
        var midLowCount = 0
        var neutralCount = 0
        var midHighCount = 0
        var highCount = 0
        for eachTrack in self.tracksDetailArr {
            if let trackDetails = eachTrack {
                switch intValencetoString(valence: trackDetails.valence){
                case "Sad":
                    lowCount += 1
                case "Gloomy":
                    midLowCount += 1
                case "Neutral":
                    neutralCount += 1
                case "Upbeat":
                    midHighCount += 1
                case "Happy":
                    highCount += 1
                default:
                    continue
                }
            }
        }
        self.musicalPositivityArr = [
            MusicalPositivity(positivity: "Sad", numTracks: lowCount),
            MusicalPositivity(positivity: "Gloomy", numTracks: midLowCount),
            MusicalPositivity(positivity: "Neutral", numTracks: neutralCount),
            MusicalPositivity(positivity: "Upbeat", numTracks: midHighCount),
            MusicalPositivity(positivity: "Happy", numTracks: highCount)
        ]
    }
    
}

struct MusicalPositivity:Identifiable {
    let id = UUID()
    let positivity:String
    let numTracks:Int
    
}

struct MusicalPositivityDisplayData {
    static let musicalPosArr:[MusicalPositivity] = [
        MusicalPositivity(positivity: "Sad", numTracks: 1),
        MusicalPositivity(positivity: "Gloomy", numTracks: 2),
        MusicalPositivity(positivity: "Neutral", numTracks: 3),
        MusicalPositivity(positivity: "Upbeat", numTracks: 2),
        MusicalPositivity(positivity: "Happy", numTracks: 1)
    ]
}
/**
 
 func intValencetoString(valence:Float) -> String {
     /* A measure from 0.0 to 1.0 describing the musical positiveness conveyed by a track.
     Tracks with high valence sound more positive (e.g. happy, cheerful, euphoric),
     while tracks with low valence sound more negative (e.g. sad, depressed, angry). */
     switch Int(valence) {
     case 0...20:
         return "Sad"
     case 21...45:
         return "Gloomy"
     case 46...55:
         return "Neutral"
     case 56...79:
         return "Upbeat"
     case 80...100:
         return "Happy"
     default:
         return "Undefined"
     }
 }
 
 */
