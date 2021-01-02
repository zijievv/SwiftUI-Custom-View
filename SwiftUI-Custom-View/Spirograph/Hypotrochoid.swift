//
//  Hypotrochoid.swift
//  SwiftUI-Custom-View
//
//  Created by zijie vv on 02/01/2021.
//  Copyright © 2021 zijie vv. All rights reserved.
//
//  ================================================================================================
//

import SwiftUI

struct Hypotrochoid: Shape {
    let outerRadius: Double
    let innerRadius: Double
    let distance: Double

    // x(theta) = (R - r) cos(theta) + d cos((R - r) / r * theta)
    // y(theta) = (R - r) sin(theta) - d sin((R - r) / r * theta)
    func path(in rect: CGRect) -> Path {
        var path = Path()

        let size = Double(rect.minimum)
        let ratio = size / 2 / (outerRadius + distance - innerRadius)
        let outerR = outerRadius * ratio
        let innerR = innerRadius * ratio
        let length = distance * ratio

        var angleDegree: Int = 1
        let maxT: Int = 36000
        var curveClosed = false

        let x0: Double = Double(rect.width)
        let y0: Double = Double(rect.height / 2)
        path.move(to: .init(x: x0, y: y0))

        while angleDegree < maxT, !curveClosed {
            let theta: Double = angleDegree.degrees.radians
            let component = ((outerR - innerR) / innerR) * theta
            let x = (outerR - innerR) * cos(theta) + length * cos(component) + Double(rect.midX)
            let y = (outerR - innerR) * sin(theta) - length * sin(component) + Double(rect.midY)

            path.addLine(to: .init(x: x, y: y))

            if abs(x - x0) < 0.01, abs(y - y0) < 0.01 {
                curveClosed = true
            }

            angleDegree += 1
        }

        return path
    }
}

struct Hypotrochoid_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Circle()
                .foregroundColor(.white)
                .shadow(radius: 5)
            Hypotrochoid(outerRadius: 5, innerRadius: 2, distance: 1.3)
                .stroke(lineWidth: 1)
                .rotation(-90.degrees)
                .padding(10)
        }
        .padding(10)
        .squareFrame(320)
        .background(Color.yellow)
    }
}
