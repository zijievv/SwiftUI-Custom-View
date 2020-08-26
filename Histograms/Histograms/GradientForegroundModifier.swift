//
//  GradientForegroundModifier.swift
//  Histograms
//
//  Created by zijie vv on 27/08/2020.
//  Copyright © 2020 zijie vv. All rights reserved.
//
//  ============================================================================
//

import SwiftUI

struct GradientForegroundModifier: ViewModifier {
  let gradient: Gradient
  let startPoint: UnitPoint
  let endPoint: UnitPoint

  func body(content: Content) -> some View {
    LinearGradient(gradient: gradient,
                   startPoint: startPoint, endPoint: endPoint)
      .mask(content)
  }
}

struct GradientForegroundModifier_Previews: PreviewProvider {
  static var previews: some View {
    Text("Hello, world!")
      .font(.system(size: 50, weight: .bold, design: .rounded))
      .frame(width: 400, height: 60, alignment: .center)
      .gradientForeground(gradient: Gradient(colors: [.blue, .red, .orange]),
                          startPoint: .leading, endPoint: .trailing)
  }
}

extension View {
  func gradientForeground(
    gradient: Gradient,
    startPoint: UnitPoint,
    endPoint: UnitPoint
  ) -> some View {
    self.modifier(GradientForegroundModifier(gradient: gradient,
                                             startPoint: startPoint,
                                             endPoint: endPoint))
  }
}
