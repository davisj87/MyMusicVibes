//
//  TrackViewModel.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/17/23.
//

import Foundation
class TrackDetailsCollectionViewModel: TrackDetailViewFormatter {
    
    private let authManager = AuthManager()
    
    private (set) var trackCollectionViewModel:TrackCollectionViewModel
    
    private var track:TracksObject
    private var trackDetail:TrackFeaturesObject?
    
    init(track:TracksObject, trackDetail:TrackFeaturesObject? = nil) {
        self.track = track
        self.trackDetail = trackDetail
        self.trackCollectionViewModel = TrackCollectionViewModel(header:track, sections: [])
    }
    
    
    func getTrack() async throws {
        if let trackDetail = self.trackDetail {
            print("used preloaded track details")
            self.trackCollectionViewModel = await self.setupCollectionViewModel(trackDetails: trackDetail)
        } else {
            let singleTracksEndpoint = SingleTrackDetailEndpoint(id:self.track.id)
            let singleTracksRequest = APIRequest(endpoint: singleTracksEndpoint, authManager: authManager)
            print("get tracks details")
            guard let trackDetails = try await singleTracksRequest.executeRequest() else { return }
            print("got tracks details")
            self.trackCollectionViewModel = await self.setupCollectionViewModel(trackDetails: trackDetails)
        }
    }
    
    private func setupCollectionViewModel(trackDetails:TrackFeaturesObject) async -> TrackCollectionViewModel {
        print("setup detail view model")
        //Mood Section: Danceability, Valence, Energy, Tempo
        let danceability = TrackCollectionViewSectionsAttribute(name: "Danceability", value: String(Int(trackDetails.danceability)))
        
        let valenceString = self.intValencetoString(valence: trackDetails.valence)
        let valence = TrackCollectionViewSectionsAttribute(name: "Musical Vibe", value: valenceString)
        let energy = TrackCollectionViewSectionsAttribute(name: "Energy", value: String(Int(trackDetails.energy)))
        let tempo = TrackCollectionViewSectionsAttribute(name: "Tempo", value: String(Int(trackDetails.tempo)))
        let moodArray = [danceability, valence, energy, tempo]
        let moodSection = TrackCollectionViewSection(title: "Mood", attributes: moodArray)
        
        //Properties: Loudness, Speechiness, Instrumentalness, Key, Mode
        let keyString = self.intKeytoString(key: trackDetails.key)
        let modeString = self.intModetoString(mode: trackDetails.mode)
        let keyMode = TrackCollectionViewSectionsAttribute(name: "Key", value: keyString + " " + modeString)
        let loudness = TrackCollectionViewSectionsAttribute(name: "Loudness", value: String(trackDetails.loudness))
        let speechiness = TrackCollectionViewSectionsAttribute(name: "Speechiness", value: String(Int(trackDetails.speechiness)))
        let instrumentalness = TrackCollectionViewSectionsAttribute(name: "Instrumentalness", value: String(Int(trackDetails.instrumentalness)))
        let propArray = [keyMode, loudness, speechiness, instrumentalness]
        let propSection = TrackCollectionViewSection(title: "Properties", attributes: propArray)
        
        //Context: Liveness, Acousticness
        let liveness = TrackCollectionViewSectionsAttribute(name: "Liveness", value: String(Int(trackDetails.liveness)))
        let acousticness = TrackCollectionViewSectionsAttribute(name: "Acousticness", value: String(Int(trackDetails.acousticness)))
        let contextArray = [liveness, acousticness]
        let contextSection = TrackCollectionViewSection(title: "Context", attributes: contextArray)
        
        let sections = [moodSection, propSection, contextSection]
        return TrackCollectionViewModel(header:self.track, sections: sections)
    }
    
}

struct TrackCollectionViewModel {
    var header: TracksObject
    var sections: [TrackCollectionViewSection]
}

struct TrackCollectionViewSection {
    var title: String
    var attributes: [TrackCollectionViewSectionsAttribute]
}

struct TrackCollectionViewSectionsAttribute {
    var name: String
    var value: String
}




