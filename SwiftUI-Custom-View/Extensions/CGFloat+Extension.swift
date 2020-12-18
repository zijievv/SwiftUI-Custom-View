//
//  CGFloat+Extension.swift
//  SwiftUI-Custom-View
//
//  Created by zijie vv on 18/12/2020.
//  Copyright © 2020 zijie vv. All rights reserved.
//
//  ================================================================================================
//

import SwiftUI

extension CGFloat {
    public var degrees: Angle { Angle.degrees(Double(self)) }
    public var radians: Angle { Angle.radians(Double(self)) }
    public var double: Double { Double(self) }
}
