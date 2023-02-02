//
//  PlaylistTracksChart.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 2/2/23.
//

import SwiftUI
import Charts

struct PlaylistTracksChart: View {
    var vm:PlaylistTracksChartViewModel
    var body: some View {
        if #available(iOS 16.0, *) {
            VStack {
                GroupBox ( "Musicial Positivity") {
                    Chart {
                        ForEach(self.vm.musicalPositivityArr) {
                            LineMark(
                                x: .value("Positivity", $0.positivity),//.value("Positivity", $0.score)
                                y: .value("# of Tracks", $0.numTracks)
                            )
                        }
                    }
                }
                
//                GroupBox ( "Line Chart - Step Count") {
//                    Chart(currentWeek) {
//                        LineMark(
//                            x: .value("Week Day", $0.weekday, unit: .day),
//                            y: .value("Step Count", $0.steps)
//                        )
//
//                    }
//                }
            }
        } else {
            // Fallback on earlier versions
        }
    }
}

//struct PlaylistTracksChart_Previews: PreviewProvider {
//    static var previews: some View {
//        //let vm = PlaylistTracksChartViewModel
//        PlaylistTracksChart()
//    }
//}
