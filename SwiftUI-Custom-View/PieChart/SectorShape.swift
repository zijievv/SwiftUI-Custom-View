//
//  SectorShape.swift
//  SwiftUI-Custom-View
//
//  Created by zijie vv on 18/12/2020.
//  Copyright © 2020 zijie vv. All rights reserved.
//
//  ================================================================================================
//

import SwiftUI

struct SectorShape: Shape {
    let startAngle: Angle
    let endAngle: Angle

    func path(in rect: CGRect) -> Path {
        let radius = rect.minimum / 2
        let center = rect.center
        let start = CGPoint(x: center.x, y: center.y)

        let path = Path { path in
            path.move(to: center)
            path.addLine(to: start)
            path.addArc(center: center, radius: radius,
                        startAngle: startAngle, endAngle: endAngle, clockwise: false)
            path.closeSubpath()
        }

        return path
    }
}

struct SectorShape_Previews: PreviewProvider {
    static var previews: some View {
        List {
            SectorShape(startAngle: Angle(degrees: 20), endAngle: Angle(degrees: 330))
                .frame(width: 300, height: 300, alignment: .center)
                .background(Color.blue.shadow(radius: 5))
        }
    }
}
