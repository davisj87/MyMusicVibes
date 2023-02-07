//
//  AlbumTracksChart.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 2/7/23.
//

import SwiftUI
import Charts

struct AlbumTracksChart: View {
    @StateObject var vm:AlbumTracksChartViewModel
    var body: some View {
        VStack {
            MusicalPositivityChart(musicalPositivityArr: self.vm.musicalPositivityArr)
            EnergyChart(energyArr: self.vm.energyArr)
        }
        .onAppear{self.vm.getChartData()}
    }
}
//struct AlbumTracksChart_Previews: PreviewProvider {
//    static var previews: some View {
//        AlbumTracksChart()
//    }
//}
