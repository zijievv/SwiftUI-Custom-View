//
//  Color+Extension.swift
//  ArcProgressView
//
//  Created by zijie vv on 22/08/2020.
//  Copyright © 2020 zijie vv. All rights reserved.
//
//  ============================================================================
//

import SwiftUI
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

extension Color {
    public init(decimalRGB: (r: Int, g: Int, b: Int)) {
        self.init(red: Double(decimalRGB.r)/255,
                  green: Double(decimalRGB.g)/255,
                  blue: Double(decimalRGB.b)/255)
    }

    public var components: (
        red: CGFloat, green: CGFloat, blue: CGFloat, opacity: CGFloat
    ) {
#if canImport(UIKit)
        typealias NativeColor = UIColor
#elseif canImport(AppKit)
        typealias NativeColor = NSColor
#endif

        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var o: CGFloat = 0

        guard NativeColor(self)
            .getRed(&r, green: &g, blue: &b, alpha: &o) else {
            // You can handle the failure here as you want
            return (0, 0, 0, 0)
        }

        return (r, g, b, o)
    }

    public func reduceOpaque(_ v: Double = 0.5) -> Color {
        let rgbo = components
        return Color(red: rgbo.red.double,
                     green: rgbo.green.double,
                     blue: rgbo.blue.double,
                     opacity: rgbo.opacity.double - v)
    }
}
