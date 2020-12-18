//
//  Int+Extension.swift
//  SwiftUI-Custom-View
//
//  Created by zijie vv on 18/12/2020.
//  Copyright © 2020 zijie vv. All rights reserved.
//
//  ================================================================================================
//

import SwiftUI

extension Int {
    var degrees: Angle { Angle.degrees(Double(self)) }
    var radians: Angle { Angle.radians(Double(self)) }
    var cgFloat: CGFloat { CGFloat(self) }
}
