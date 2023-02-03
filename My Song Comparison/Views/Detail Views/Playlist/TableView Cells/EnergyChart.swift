//
//  KeyChart.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 2/3/23.
//

import SwiftUI
import Charts

struct EnergyChart: View {
    var energyArr:[EnergyChartViewModel]
    var body: some View {
        GroupBox ("Energy") {
            Chart {
                ForEach(energyArr) {
                    LineMark(
                        x: .value("", $0.track),
                        y: .value("Energy", $0.energy)
                    )
                    .lineStyle(.init(lineWidth: 10, lineCap: .round, lineJoin: .round))
                }
                .foregroundStyle(Gradient(colors: [.green, .blue, .gray]))
                .interpolationMethod(.monotone)
            }
            .chartXAxis(.hidden)
           // .frame(height:300)
            .chartYAxis {
                AxisMarks(position: .leading)
            }
            .chartYAxisLabel(position: .leading, alignment: .center) {
                Text("Energy")
            }
        }
    }
}

//struct KeyChart_Previews: PreviewProvider {
//    static var previews: some View {
//        KeyChart()
//    }
//}
