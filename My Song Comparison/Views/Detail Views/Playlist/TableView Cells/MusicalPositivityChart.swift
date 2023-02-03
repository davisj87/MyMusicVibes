//
//  MusicalPositivityChart.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 2/3/23.
//

import SwiftUI
import Charts

struct MusicalPositivityChart: View {
    var musicalPositivityArr:[MusicalPositivity]
    var body: some View {
        GroupBox ("Musicial Positivity") {
            Chart {
                ForEach(musicalPositivityArr) {
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
    }
}

//struct MusicalPositivityChart_Previews: PreviewProvider {
//    static var previews: some View {
//        MusicalPositivityChart()
//    }
//}
