//
//  PieChartView.swift
//  SwiftUI-Custom-View
//
//  Created by zijie vv on 18/12/2020.
//  Copyright © 2020 zijie vv. All rights reserved.
//
//  ================================================================================================
//

import SwiftUI

struct PieChartView: View {
    @State private var selectedID: UUID = UUID()
    @State private var selected = false

    let pieChartVM: PieChartViewModel
    let onTap: (SectorShapeModel?) -> Void

    init(pieChartVM: PieChartViewModel, onTap: @escaping (SectorShapeModel?) -> Void = { _ in }) {
        self.pieChartVM = pieChartVM
        self.onTap = onTap
    }

    var body: some View {
        ZStack {
            ForEach(pieChartVM.sectors, id: \.id) { sector in
                SectorShape(startAngle: sector.startAngle, endAngle: sector.endAngle)
                    .foregroundColor(sector.color
                        .reduceOpaque(selected ? (selectedID == sector.id ? 0 : 0.3) : 0))
                    .onTapGesture {
                        withAnimation {
                            if selectedID == sector.id {
                                onTap(nil)
                                selectedID = UUID()
                                selected = false
                            } else {
                                selectedID = sector.id
                                selected = true
                                onTap(sector)
                            }
                        }
                    }
                    .scaleEffect(selectedID == sector.id ? 1.05 : 1)
                    .shadow(color: .black, radius: selectedID == sector.id ? 5 : 0, x: 0, y: 0)
            }
        }
    }
}

struct PieChartView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PieChartView(pieChartVM: testDataPieChart, onTap: { _ in })
                .squareFrame(300)
        }
//        .environment(\.colorScheme, .dark)
    }
}
