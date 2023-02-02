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
                GroupBox ("Musicial Positivity") {
                    Chart {
                        ForEach(self.vm.musicalPositivityArr) {
                            LineMark(
                                x: .value("Positivity", $0.positivity),
                                y: .value("# of Tracks", $0.numTracks)
                            )
                            .lineStyle(.init(lineWidth: 10, lineCap: .round, lineJoin: .round))
                        }
                        .foregroundStyle(Gradient(colors: [.pink, .orange, .yellow]))
                        .interpolationMethod(.monotone)
                    }
                    //.frame(height:300)
                    .chartYAxis {
                        AxisMarks(position: .leading)
                    }
                    .chartYAxisLabel(position: .leading, alignment: .center) {
                        Text("# of Tracks")
                    }
                }
                
                GroupBox ("Key") {
                    Chart {
                        ForEach(self.vm.musicalPositivityArr) {
                            LineMark(
                                x: .value("Positivity", $0.positivity),
                                y: .value("# of Tracks", $0.numTracks)
                            )
                            .lineStyle(.init(lineWidth: 10, lineCap: .round, lineJoin: .round))
                        }
                        .foregroundStyle(Gradient(colors: [.pink, .orange, .yellow]))
                        .interpolationMethod(.monotone)
                    }
                   // .frame(height:300)
                    .chartYAxis {
                        AxisMarks(position: .leading)
                    }
                }
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
