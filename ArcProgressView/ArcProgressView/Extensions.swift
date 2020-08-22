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
}

extension CGFloat {
  var degrees: Angle { Angle.degrees(Double(self)) }
  var radians: Angle { Angle.radians(Double(self)) }
}

extension Int {
  var degrees: Angle { Angle.degrees(Double(self)) }
  var radians: Angle { Angle.radians(Double(self)) }
}
