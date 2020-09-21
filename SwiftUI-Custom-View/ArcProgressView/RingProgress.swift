//
//  RingProgress.swift
//  ArcProgressView
//
//  Created by zijie vv on 22/08/2020.
//  Copyright © 2020 zijie vv. All rights reserved.
//
//  ============================================================================
//

import SwiftUI

struct RingProgress: View {
    let progress: Double
    let colors: [Color]
    let backColor: Color
    let lineWidth: CGFloat
    let startAngle: Angle
    let clockwise: Bool

    init(
        progress: Double,
        gradientColors: [Color],
        backgroundCircleColor: Color,
        lineWidth: CGFloat,
        startAngle: Angle = 0.degrees,
        clockwise: Bool = false
    ) {
        self.progress = progress
        self.colors = gradientColors
        self.backColor = backgroundCircleColor
        self.lineWidth = lineWidth
        self.startAngle = startAngle
        self.clockwise = clockwise
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Circle()
                    .stroke(self.backColor, style: self.strokeStyle)
                    .opacity(0.15)

                self.startCover(with: geometry)
                    .opacity(self.progress == 0 ? 1 : 0)

                Circle()
                    .trim(to: CGFloat(self.progress))
                    .stroke(self.strokeGradient, style: self.strokeStyle)

                self.endCover(with: geometry)
                    .opacity(self.progress > 0.5 ? 1 : 0)
            }
            .padding(self.lineWidth / 2)
        }
        .rotation3DEffect(self.clockwise ? 180.degrees : 0.degrees, axis: (1, 0, 0))
        .rotationEffect(self.startAngle)
    }

    private var strokeStyle: StrokeStyle {
        StrokeStyle(lineWidth: lineWidth, lineCap: .round)
    }

    private var strokeGradient: AngularGradient {
        return AngularGradient(gradient: Gradient(colors: colors),
                               center: .center,
                               startAngle: 0.degrees,
                               endAngle: (progress * 360).degrees)
    }

    private func startCover(with geometry: GeometryProxy) -> some View {
        Circle()
            .fill(colors[0])
            .frame(width: lineWidth, height: lineWidth)
            .offset(
                x: (min(geometry.size.width, geometry.size.height) - lineWidth) / 2,
                y: 0
            )
    }

    private func endCover(with geometry: GeometryProxy) -> some View {
        let radius = (
            min(geometry.size.width, geometry.size.height) - lineWidth
        ) / 2
        let shadowCircleSide = lineWidth * 0.75
        let shadowRatio: CGFloat = 0.1
        let offsetRatio: CGFloat = 0.5
        let rotation: Angle = (progress * 360).degrees - 180.degrees

        return Group {
            Circle()
                .trim(from: 0.5, to: 1)
                .fill(colors[1])
                .frame(width: shadowCircleSide, height: shadowCircleSide)
                .opacity(0.6)
                .shadow(color: .black,
                        radius: shadowCircleSide * shadowRatio,
                        x: 0,
                        y: -shadowCircleSide / 2 * offsetRatio)

            Circle()
                .trim(from: 0.2, to: 0.8)
                .fill(colors[1])
                .frame(width: lineWidth, height: lineWidth)
                .rotationEffect(90.degrees)
        }
        .offset(x: -radius, y: 0)
        .rotationEffect(rotation)
    }
}

struct RingProgress_Previews: PreviewProvider {
    static let colorTheme: ProgressColor = .green
    static var previews: some View {
        VStack {
            RingProgress(progress: 0.75,
                         gradientColors: colorTheme.colors,
                         backgroundCircleColor: colorTheme.backColor,
                         lineWidth: 50,
                         startAngle: 0.degrees,
                         clockwise: false)
                .frame(width: 200, alignment: .center)
        }
        .background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all))
        .environment(\.colorScheme, .dark)
    }
}
