//
//  ArcProgressContentView.swift
//  ArcProgressView
//
//  Created by zijie vv on 22/08/2020.
//  Copyright © 2020 zijie vv. All rights reserved.
//
//  ============================================================================
//

import SwiftUI

struct ArcProgressContentView: View {
    @State var progress: Double = 0

    let colorTheme = ProgressColor.green

    var body: some View {
        Group {
            VStack(spacing: 30) {
                Spacer()
                Text(self.percentageFormatter.string(from: self.progress as NSNumber)!)
                    .font(.system(size: 60, weight: .bold, design: .rounded))

                RingProgress(progress: progress,
                             gradientColors: colorTheme.colors,
                             backgroundCircleColor: colorTheme.backColor,
                             lineWidth: 50,
                             startAngle: 0.degrees,
                             clockwise: false)
                    .frame(height: 350, alignment: .center)

                HStack(spacing: 30) {
                    Button(action: increment) {
                        Image(systemName: "chevron.up.circle.fill")
                            .font(.system(size: 60, weight: .bold, design: .rounded))
                    }

                    Button(action: decrement) {
                        Image(systemName: "chevron.down.circle.fill")
                            .font(.system(size: 60, weight: .bold, design: .rounded))
                    }
                }

                Spacer()
            }
            .padding()
        }
        .background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all))
    }

    private let percentageFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        return formatter
    }()

    private func increment() {
        withAnimation { progress += 0.1 }
    }

    private func decrement() {
        withAnimation { progress -= 0.1 }
    }
}

struct ArcProgressContentView_Previews: PreviewProvider {
    static var previews: some View {
        ArcProgressContentView()
            .environment(\.colorScheme, .dark)
    }
}
