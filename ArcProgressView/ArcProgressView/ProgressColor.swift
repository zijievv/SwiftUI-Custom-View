//
//  ProgressColor.swift
//  ArcProgressView
//
//  Created by zijie vv on 23/08/2020.
//  Copyright © 2020 zijie vv. All rights reserved.
//
//  ============================================================================
//

import SwiftUI

enum ProgressColor {
  case red
  case green
  case blue
}

extension ProgressColor {
  /// Gradient colors
  var colors: [Color] {
    switch self {
    case .red: return [ProgressColor.darkRed, ProgressColor.lightRed]
    case .green: return [ProgressColor.darkGreen, ProgressColor.lightGreen]
    case .blue: return [ProgressColor.darkBlue, ProgressColor.lightBlue]
    }
  }

  var backColor: Color {
    switch self {
    case .red: return ProgressColor.backRed
    case .green: return ProgressColor.backGreen
    case .blue: return ProgressColor.backBlue
    }
  }

  // Red
  static let darkRed = Color(decimalRGB: (224, 0, 21))
  static let lightRed = Color(decimalRGB: (255, 50, 137))
  static let backRed = Color(decimalRGB: (34, 0, 3))
  // Green
  static let darkGreen = Color(decimalRGB: (53, 220, 0))
  static let lightGreen = Color(decimalRGB: (184, 255, 0))
  static let backGreen = Color(decimalRGB: (8, 33, 0))
  //Blue
  static let darkBlue = Color(decimalRGB: (0, 186, 225))
  static let lightBlue = Color(decimalRGB: (5, 251, 207))
  static let backBlue = Color(decimalRGB: (0, 28, 34))
}

struct ProgressColor_Previews: PreviewProvider {
  static var previews: some View {
    let contents: [ProgressColor] = [.red, .green, .blue]

    return List {
      ForEach(contents, id: \.self) { content in
        HStack(spacing: 1) {
          Circle()
            .foregroundColor(content.colors[0])
          Circle()
            .foregroundColor(content.colors[1])
        }
        .background(content.backColor)
      }
    }
    .environment(\.colorScheme, .dark)
  }
}
