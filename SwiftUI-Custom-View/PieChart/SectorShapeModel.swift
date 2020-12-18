//
//  SectorShapeModel.swift
//  SwiftUI-Custom-View
//
//  Created by zijie vv on 18/12/2020.
//  Copyright © 2020 zijie vv. All rights reserved.
//
//  ================================================================================================
//

import SwiftUI

struct SectorShapeModel: Identifiable {
    let id = UUID()

    let label: String
    let value: Double
    let rawColor: Color

    var startAngle: Angle = .zero
    var endAngle: Angle = .zero
    var color: Color

    init(label: String, value: Double, color: Color) {
        self.label = label
        self.value = value
        self.rawColor = color
        self.color = color
    }
}
