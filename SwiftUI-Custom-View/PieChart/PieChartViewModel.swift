//
//  PieChartViewModel.swift
//  SwiftUI-Custom-View
//
//  Created by zijie vv on 18/12/2020.
//  Copyright © 2020 zijie vv. All rights reserved.
//
//  ================================================================================================
//

import SwiftUI

final class PieChartViewModel: ObservableObject {
    @Published var sectors: [SectorShapeModel]

    init(sectors: [SectorShapeModel]) {
        self.sectors = sectors

        let values: [Double] = sectors.map { $0.value }
        var accumulations: [Double] = [0] + values

        for i in 1..<accumulations.count {
            accumulations[i] += accumulations[i-1]
        }

        let sum: Double = accumulations.last!
        let percents = values.map { $0 / sum }

        let angles: [Angle] = accumulations.map { ($0 / sum * 360).degrees }

        for i in 0..<self.sectors.count {
            self.sectors[i].startAngle = angles[i]
            self.sectors[i].endAngle = angles[i+1]
            self.sectors[i].percent = percents[i]
        }
    }
}

#if DEBUG
let testDataPieChart = PieChartViewModel(
    sectors: [
        ("Water", 730, .blue),
        ("Coffee", 300, Color(.systemIndigo)),
        ("Liquor", 50, .yellow),
        ("Tea", 500, .green),
        ("Juice", 200, .orange),
        ("Sports Drink", 170, Color(.systemTeal)),
        ("Wine", 200, .red),
    ].map { SectorShapeModel(label: $0.0, value: $0.1, color: $0.2) }
)
#endif
