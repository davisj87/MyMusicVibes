//
//  AlbumTracksViewModelTests.swift
//  My Song ComparisonTests
//
//  Created by Jarred Davis on 2/24/23.
//

import XCTest
@testable import My_Song_Comparison


final class AlbumTracksViewModelTests: XCTestCase {

    var albumTracksVM:AlbumTracksViewModel!
    var albumObject:AlbumObject {
        return AlbumObject(id: "",
                           artists: [AlbumArtistObject(id: "", name: "Test Artist")],
                           images: [],
                           name: "Test Album Name",
                           releaseDate: "11-11-11")
    }
    
    
    
    override func setUp() {
        super.setUp()
        let albumCellViewModel:ItemOverviewCellViewModelProtocol = AlbumCellViewModel(albumObject: albumObject)
        albumTracksVM = AlbumTracksViewModel(album: albumCellViewModel, albumTracksFetcher: MockAlbumTracksFetcher())
    }
    
    override func tearDown() {
        super.tearDown()
        albumTracksVM = nil
    }
    
    func testAlbumTracksSuccess() async throws {
        try await albumTracksVM.getTracksData()
        let albumTrackAndDetailsData = self.albumTracksVM.getTrackAndDetailsVM(at: 11)
        XCTAssertEqual(albumTrackAndDetailsData.track?.id, albumTrackAndDetailsData.trackDetail?.id)
        XCTAssertEqual(albumTracksVM.trackCount, 12)
        XCTAssertEqual(albumTracksVM.tracks.count, albumTracksVM.trackDetails.count)
        XCTAssertEqual(albumTrackAndDetailsData.track?.primaryText, "Starfire")
        XCTAssertEqual(albumTrackAndDetailsData.trackDetail?.energy, 76.8)
    }

}
