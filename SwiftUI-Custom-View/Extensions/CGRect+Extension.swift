//
//  CGRect+Extension.swift
//  SwiftUI-Custom-View
//
//  Created by zijie vv on 18/12/2020.
//  Copyright © 2020 zijie vv. All rights reserved.
//
//  ================================================================================================
//

import SwiftUI

extension CGRect {
    /// The minimum length of sides.
    public var minimum: CGFloat { min(width, height) }

    public var center: CGPoint { CGPoint(x: midX, y: midY) }
}
