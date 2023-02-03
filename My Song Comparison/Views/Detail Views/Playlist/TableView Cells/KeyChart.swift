//
//  KeyChart.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 2/3/23.
//

import SwiftUI
import Charts

struct KeyChart: View {
    var musicalPositivityArr:[MusicalPositivity]
    var body: some View {
        GroupBox ("Key") {
            Chart {
                ForEach(musicalPositivityArr) {
                    BarMark(
                        x: .value("Key", $0.positivity),
                        y: .value("# of Tracks", $0.numTracks)
                    )
                }
            }
           // .frame(height:300)
            .chartYAxis {
                AxisMarks(position: .leading)
            }
            .chartYAxisLabel(position: .leading, alignment: .center) {
                Text("# of Tracks")
            }
        }
    }
}

//struct KeyChart_Previews: PreviewProvider {
//    static var previews: some View {
//        KeyChart()
//    }
//}
