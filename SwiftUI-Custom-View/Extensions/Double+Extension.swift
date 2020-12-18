//
//  Double+Extension.swift
//  SwiftUI-Custom-View
//
//  Created by zijie vv on 18/12/2020.
//  Copyright © 2020 zijie vv. All rights reserved.
//
//  ================================================================================================
//

import SwiftUI

extension Double {
    var degrees: Angle { Angle(degrees: self) }
    var radians: Angle { Angle(radians: self) }
    var cgFloat: CGFloat { CGFloat(self) }
}
