//
//  GradientRingSpinner.swift
//  Spinners
//
//  Created by zijie vv on 24/08/2020.
//  Copyright © 2020 zijie vv. All rights reserved.
//
//  ============================================================================
//

import SwiftUI

struct GradientRingSpinner: View {
  @State var spin = false

  var colors: [Color] = [
    Color(.sRGB, red: 0, green: 186/255, blue: 1, opacity: 0),
    Color(.sRGB, red: 5/255, green: 251/255, blue: 207/255, opacity: 1),
  ]
  let lineWidthRatio: CGFloat = 0.15

  var body: some View {
    GeometryReader { geometry in
      ZStack {
        Circle()
          .stroke(self.strokeGradient, style: self.strokeStyle(with: geometry))

        self.coverCircle(with: geometry)
      }
      .padding(self.lineWidth(with: geometry) / 2)
      .frame(width: self.side(with: geometry),
             height: self.side(with: geometry),
             alignment: .center)
      .rotationEffect(Angle(degrees: -90))
      .rotationEffect(Angle(degrees: self.spin ? 360 : 0))
      .animation(Animation
        .linear(duration: 1).repeatForever(autoreverses: false))
      .onAppear {
        self.spin.toggle()
      }
    }
  }

  private var strokeGradient: AngularGradient {
    AngularGradient(gradient: Gradient(colors: self.colors),
                    center: .center,
                    startAngle: Angle(degrees: 0),
                    endAngle: Angle(degrees: 360))
  }

  private func side(with geometry: GeometryProxy) -> CGFloat {
    min(geometry.size.width, geometry.size.height)
  }

  private func strokeStyle(with geometry: GeometryProxy) -> StrokeStyle {
    StrokeStyle(lineWidth: lineWidth(with: geometry), lineCap: .round)
  }

  private func lineWidth(with geometry: GeometryProxy) -> CGFloat {
    side(with: geometry) * lineWidthRatio
  }

  private func coverCircle(with geometry: GeometryProxy) -> some View {
    Circle()
      .trim(from: 0.24, to: 0.76)
      .rotation(Angle(degrees: -90))
      .foregroundColor(colors.last!)
      .frame(width: lineWidth(with: geometry) * 0.99,
             height: lineWidth(with: geometry),
             alignment: .center)
      .offset(x: (side(with: geometry) - lineWidth(with: geometry)) / 2, y: 0)
  }
}

struct GradientRingSpinner_Previews: PreviewProvider {
  static var previews: some View {
    GradientRingSpinnerPreview()
  }
}

struct GradientRingSpinnerPreview: View {
  @State var appear = false

  var body: some View {
    ZStack {
      Color.white.opacity(0)

      VStack {
        Spacer()

        if appear {
          ZStack {
            Text("Loading")
              .font(.system(size: 30, weight: .bold, design: .rounded))
              .foregroundColor(.gray)
            GradientRingSpinner()
              .frame(width: 300, height: 300, alignment: .center)
          }
        }

        Spacer()
        Button(action: {
          withAnimation {
            self.appear.toggle()
          }
        }) {
          Text("Send")
            .font(.system(size: 50, weight: .bold, design: .rounded))
        }
      }
    }
    .padding()
    .background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all))
    .environment(\.colorScheme, .dark)
  }
}
