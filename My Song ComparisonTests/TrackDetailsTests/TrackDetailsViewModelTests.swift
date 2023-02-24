//
//  TrackDetailsViewModelTests.swift
//  My Song ComparisonTests
//
//  Created by Jarred Davis on 2/24/23.
//

import XCTest
@testable import My_Song_Comparison


final class TrackDetailsViewModelTests: XCTestCase {

    var trackDetailsVM:TrackDetailsCollectionViewModel!
    var trackCellViewModel:ItemOverviewCellViewModelProtocol {
        return TrackCellViewModel(tracksObject: trackObject)
    }
    
    let trackObject:TracksObject = TracksObject(id: "",
                                                name: "Test Name",
                                                popularity: 77,
                                                album: TrackAlbumObject(images: [], name: "Test Album"),
                                                artists: [TrackArtistObject(name: "Test Artist")])
    
    let trackFetauresObject = TrackFeaturesObject(id: "",
                                                  danceability: 15.2,
                                                  energy: 89.8,
                                                  key: 3,
                                                  loudness: -8,
                                                  mode: 1,
                                                  speechiness: 5.25,
                                                  acousticness: 25,
                                                  instrumentalness: 7.07,
                                                  liveness: 52.2,
                                                  valence: 78.9,
                                                  tempo: 98.158,
                                                  timeSignature: 3)
    
    
    func testPreloadedTracksDetailsSuccess() async throws {
        trackDetailsVM = TrackDetailsCollectionViewModel(track: trackCellViewModel, trackDetail:trackFetauresObject)
        try await trackDetailsVM.getTrack()
        let collectionVM = trackDetailsVM.trackSectionViewModel
        XCTAssertEqual(collectionVM.count, 3)
        let danceablility = collectionVM[0].attributes[0]
       
        XCTAssertEqual(danceablility.name, "Danceability")
        XCTAssertEqual(danceablility.value, "15")
        
        let valence = collectionVM[0].attributes[1]
        XCTAssertEqual(valence.name, "Musical Vibe")
        XCTAssertEqual(valence.value, "Upbeat")
        
        let keyMode = collectionVM[1].attributes[0]
        XCTAssertEqual(keyMode.name, "Key")
        XCTAssertEqual(keyMode.value, "Eb Major")
    }
    
    func testTracksDetailsSuccess() async throws {
        
        trackDetailsVM = TrackDetailsCollectionViewModel(track: trackCellViewModel, trackDetailFetcher: MockTrackDetailFetcher())
        try await trackDetailsVM.getTrack()
        let collectionVM = trackDetailsVM.trackSectionViewModel
        XCTAssertEqual(collectionVM.count, 3)
        let danceablility = collectionVM[0].attributes[0]
        XCTAssertEqual(danceablility.name, "Danceability")
        XCTAssertEqual(danceablility.value, "41")
        
        let valence = collectionVM[0].attributes[1]
        XCTAssertEqual(valence.name, "Musical Vibe")
        XCTAssertEqual(valence.value, "Sad")
        
        let keyMode = collectionVM[1].attributes[0]
        XCTAssertEqual(keyMode.name, "Key")
        XCTAssertEqual(keyMode.value, "D Minor")
    }

}
