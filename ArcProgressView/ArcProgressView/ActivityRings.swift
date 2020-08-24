//
//  ActivityRings.swift
//  ArcProgressView
//
//  Created by zijie vv on 24/08/2020.
//  Copyright © 2020 zijie vv. All rights reserved.
//
//  ============================================================================
//

import SwiftUI

struct ActivityRings: View {
  let progresses: [Double]
  let lineWidthRatio: CGFloat = 0.12
  let spaceRatio: CGFloat = 0.05

  private static let red = ProgressColor.red
  private static let green = ProgressColor.green
  private static let blue = ProgressColor.blue
  let colors = [red, green, blue]

  var body: some View {
    GeometryReader { geometry in
      ZStack {
        ForEach(0..<3) { i in
          RingProgress(progress: self.progresses[i],
                       gradientColors: self.colors[i].colors,
                       backgroundCircleColor: self.colors[i].backColor,
                       lineWidth: self.lineWidth(with: geometry),
                       startAngle: -90.degrees)
            .frame(width: self.side(of: i, with: geometry),
                   height: self.side(of: i, with: geometry),
                   alignment: .center)
        }
      }
    }
  }

  private func getMinLength(with geometry: GeometryProxy) -> CGFloat {
    return min(geometry.size.width, geometry.size.height)
  }

  private func lineWidth(with geometry: GeometryProxy) -> CGFloat {
    return getMinLength(with: geometry) * lineWidthRatio
  }

  private func side(of index: Int, with geometry: GeometryProxy) -> CGFloat {
    return getMinLength(with: geometry) -
      CGFloat(index) * 2 * lineWidth(with: geometry) * (1 + spaceRatio)
  }
}

struct ActivityRings_Previews: PreviewProvider {
  static var previews: some View {
    ActivityRingsPreview()
  }
}

struct ActivityRingsPreview: View {
  @State var progresses: [Double] = [1,1,1]

  private let percentageFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .percent
    return formatter
  }()

  let colors: [Color] = [.red, .green, .blue]

  var body: some View {
    VStack {
      Spacer()

      ActivityRings(progresses: progresses)
        .frame(height: 400, alignment: .center)

      Spacer()

      ForEach(0..<3) { i in
        HStack {
          Text(
            self.percentageFormatter
              .string(from: self.progresses[i] as NSNumber)!
          )

          Spacer()

          Button(action: { self.increment(of: i) }) {
            Image(systemName: "chevron.up.circle.fill")
          }
        }
        .foregroundColor(self.colors[i])
        .font(.system(size: 40, weight: .bold, design: .rounded))
      }
    }
    .padding()
    .background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all))
    .environment(\.colorScheme, .dark)
  }

  private func increment(of index: Int) {
    withAnimation {
      progresses[index] += 0.1
    }
  }
}
