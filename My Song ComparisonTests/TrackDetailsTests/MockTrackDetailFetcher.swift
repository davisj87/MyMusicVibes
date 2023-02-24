//
//  MockTrackDetailFetcher.swift
//  My Song ComparisonTests
//
//  Created by Jarred Davis on 2/24/23.
//

import Foundation
@testable import My_Song_Comparison


class MockTrackDetailFetcher:TrackDetailFetcherProtcol, MockableAPI {
    func getTrackDetails(trackId: String) async throws -> TrackFeaturesObject? {
        guard let tracksDetails = loadJSON(filename: "MockTrackDetailResponse", type: TrackFeaturesObject.self) else {
            return nil
        }
        return tracksDetails
    }
}
