//
//  ArcProgress.swift
//  ArcProgressView
//
//  Created by zijie vv on 23/08/2020.
//  Copyright © 2020 zijie vv. All rights reserved.
//
//  ============================================================================
//

import SwiftUI

struct ArcProgress: View {
    @Binding var progress: Double
    let colors: [Color]

    let arcSize: CGFloat = 0.7
    let backOpacity: Double = 0.3
    let strokeWidthRatio: CGFloat = 0.1

    private let percentageFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        return formatter
    }()

    init(progress: Binding<Double>, gradientColors: [Color]) {
        self._progress = progress
        self.colors = gradientColors
    }

    private var end: CGFloat { CGFloat(progress) * arcSize }
    private var rotation: Angle { ((1-arcSize) * 360 / 2 + 90).degrees }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Group {
                    Circle()
                        .trim(from: 0, to: self.arcSize)
                        .stroke(self.gradient, style: self.strokeStyle(with: geometry))
                        .opacity(self.backOpacity)

                    Circle()
                        .trim(from: 0, to: self.end)
                        .stroke(self.gradient, style: self.strokeStyle(with: geometry))
                }
                .rotationEffect(self.rotation)

                Text(self.percentageFormatter.string(from: self.progress as NSNumber)!)
                    .font(.system(
                        size: 0.2 * min(geometry.size.width, geometry.size.height),
                        weight: .bold,
                        design: .rounded
                    ))
            }
            .padding(min(geometry.size.width,
                         geometry.size.height) * self.strokeWidthRatio / 2)
        }
    }

    private var gradient: AngularGradient {
        AngularGradient(gradient: Gradient(colors: colors),
                        center: .center,
                        startAngle: 0.degrees,
                        endAngle: (360 * arcSize).degrees)
    }

    private func strokeStyle(with geometry: GeometryProxy) -> StrokeStyle {
        let sideLength = min(geometry.size.width, geometry.size.height)
        return StrokeStyle(
            lineWidth: strokeWidthRatio * sideLength,
            lineCap: .round,
            lineJoin: .round, miterLimit: 0, dash: [], dashPhase: 0
        )
    }
}

struct ArcProgress_Previews: PreviewProvider {
    static var previews: some View {
        ArcProgressPreview()
    }
}

struct ArcProgressPreview: View {
    @State var progress: Double = 0

    var body: some View {
        VStack(spacing: 50) {
            ArcProgress(progress: $progress, gradientColors: [.blue, .green])
                .padding()
                .background(Color(UIColor.systemBackground))
                .cornerRadius(30)
                .shadow(radius: 10)

            ArcProgress(progress: $progress, gradientColors: [.blue, .green])
                .padding()
                .background(Color(UIColor.systemBackground))
                .cornerRadius(30)
                .shadow(radius: 10)
                .environment(\.colorScheme, .dark)

            Button(action: {
                withAnimation { self.progress += 0.1 }
            }) {
                Image(systemName: "chevron.up.circle.fill")
                    .font(.largeTitle)
            }
        }
        .padding()
    }
}
