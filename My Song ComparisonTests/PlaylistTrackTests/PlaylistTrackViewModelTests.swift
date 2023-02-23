//
//  PlaylistTrackViewModelTests.swift
//  My Song ComparisonTests
//
//  Created by Jarred Davis on 2/20/23.
//

import XCTest
@testable import My_Song_Comparison


final class PlaylistTrackViewModelTests: XCTestCase {

    var playlistTrackVM:PlaylistTracksViewModel!
    var playlistObject:PlaylistObject {
        return PlaylistObject(id: "",
                              name: "Test 90s Dance",
                              owner: PlaylistOwnerObject(name: "Test Owner"),
                              images: [])
    }
    
    
    
    override func setUp() {
        super.setUp()
        let playListCellViewModel:PlaylistCellViewModel = PlaylistCellViewModel(playlistObject: playlistObject)
        playlistTrackVM = PlaylistTracksViewModel(playlist: playListCellViewModel, playlistTracksFetcher: MockPlaylistTracksFetcher())
    }
    
    override func tearDown() {
        super.tearDown()
        playlistTrackVM = nil
    }
    
    func testPlaylistTracksSuccess() async throws {
        try await playlistTrackVM.getTracks()
        let trackAndDetailsData = self.playlistTrackVM.getTrackAndDetailsVM(at: 1)
        XCTAssertEqual(trackAndDetailsData.track?.id, trackAndDetailsData.trackDetail?.id)
        XCTAssertEqual(trackAndDetailsData.trackDetail?.energy, 87.7)
        XCTAssertEqual(playlistTrackVM.trackCount, 93)
    }

}
