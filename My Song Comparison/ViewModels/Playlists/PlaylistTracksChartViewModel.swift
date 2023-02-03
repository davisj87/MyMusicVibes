//
//  PlaylistTracksChartViewModel.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 2/2/23.
//

import SwiftUI

class PlaylistTracksChartViewModel: ObservableObject, TrackDetailViewFormatter {
    
    private let tracksDetailArr: [TrackFeaturesObject]
    @Published var musicalPositivityArr:[MusicalPositivity] = []
    @Published var energyArr:[EnergyChartViewModel] = []
    
    init(tracksDetailArr:[TrackFeaturesObject]) {
        self.tracksDetailArr = tracksDetailArr
    }
    
    func getMusicalPositivityData() {
        
        var tempEnergyArr:[EnergyChartViewModel] = []
        
        var lowValCount = 0
        var midLowValCount = 0
        var neutralValCount = 0
        var midHighValCount = 0
        var highValCount = 0
        
        for(i, eachTrack) in self.tracksDetailArr.enumerated() {
            tempEnergyArr.append(EnergyChartViewModel(track: i + 1, energy: Int(eachTrack.energy)))
            switch intValencetoString(valence: eachTrack.valence) {
            case "Sad":
                lowValCount += 1
            case "Gloomy":
                midLowValCount += 1
            case "Neutral":
                neutralValCount += 1
            case "Upbeat":
                midHighValCount += 1
            case "Happy":
                highValCount += 1
            default:
                continue
            }
        }
        
        self.energyArr = tempEnergyArr
        
        self.musicalPositivityArr = [
            MusicalPositivity(positivity: "Sad", numTracks: lowValCount),
            MusicalPositivity(positivity: "Gloomy", numTracks: midLowValCount),
            MusicalPositivity(positivity: "Neutral", numTracks: neutralValCount),
            MusicalPositivity(positivity: "Upbeat", numTracks: midHighValCount),
            MusicalPositivity(positivity: "Happy", numTracks: highValCount)
        ]
        
        
    }
    
}

struct EnergyChartViewModel:Identifiable {
    let id = UUID()
    let track:Int
    let energy:Int
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
