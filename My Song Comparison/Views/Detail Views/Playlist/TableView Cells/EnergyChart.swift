//
//  KeyChart.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 2/3/23.
//

import SwiftUI
import Charts

struct EnergyChart: View {
    var energyArr:(energyData:[EnergyChartViewModel], energyColorArr:[Color])
    var body: some View {
        GroupBox ("Energy") {
            Chart {
                ForEach(energyArr.energyData) {
                    LineMark(
                        x: .value("", $0.track),
                        y: .value("Energy", $0.energy)
                    )
                    .lineStyle(.init(lineWidth: 10, lineCap: .round, lineJoin: .round))
                   // .foregroundStyle(Color($0.color))
                }
                .foregroundStyle(Gradient(colors: energyArr.energyColorArr))
                .interpolationMethod(.monotone)
            }
            .chartXAxis(.hidden)
           // .frame(height:300)
            .chartYAxis {
                AxisMarks(position: .leading)
            }
            .chartYScale(domain: 0...100)
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
