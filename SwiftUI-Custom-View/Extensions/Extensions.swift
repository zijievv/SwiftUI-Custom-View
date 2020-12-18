//
//  Extensions.swift
//  ArcProgressView
//
//  Created by zijie vv on 22/08/2020.
//  Copyright © 2020 zijie vv. All rights reserved.
//
//  ============================================================================
//

import SwiftUI

extension Double {
    var degrees: Angle { Angle.degrees(self) }
    var radians: Angle { Angle.radians(self) }
    var cgFloat: CGFloat { CGFloat(self) }
}

extension CGFloat {
    var degrees: Angle { Angle.degrees(Double(self)) }
    var radians: Angle { Angle.radians(Double(self)) }
}

extension Int {
    var degrees: Angle { Angle.degrees(Double(self)) }
    var radians: Angle { Angle.radians(Double(self)) }
    var cgFloat: CGFloat { CGFloat(self) }
}

extension Color {
    public init(decimalRGB: (r: Int, g: Int, b: Int)) {
        self.init(red: Double(decimalRGB.r)/255,
                  green: Double(decimalRGB.g)/255,
                  blue: Double(decimalRGB.b)/255)
    }
}
