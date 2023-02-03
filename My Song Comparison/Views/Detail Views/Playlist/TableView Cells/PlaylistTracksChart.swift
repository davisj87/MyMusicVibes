//
//  PlaylistTracksChart.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 2/2/23.
//

import SwiftUI
import Charts

struct PlaylistTracksChart: View {
    @StateObject var vm:PlaylistTracksChartViewModel
    var body: some View {
        VStack {
            MusicalPositivityChart(musicalPositivityArr: self.vm.musicalPositivityArr)
            EnergyChart(energyArr: self.vm.energyArr)
        }
        .onAppear{self.vm.getMusicalPositivityData()}
    }
}

//struct PlaylistTracksChart_Previews: PreviewProvider {
//    static var previews: some View {
//        //let vm = PlaylistTracksChartViewModel
//        PlaylistTracksChart()
//    }
//}
