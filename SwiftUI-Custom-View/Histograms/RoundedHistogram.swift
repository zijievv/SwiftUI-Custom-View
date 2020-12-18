//
//  RoundedHistogram.swift
//  Histograms
//
//  Created by zijie vv on 27/08/2020.
//  Copyright © 2020 zijie vv. All rights reserved.
//
//  ============================================================================
//

import SwiftUI

protocol LabelValuePair: Identifiable {
    var label: String { get }
    var value: Double { get }
}

struct RoundedHistogram<T: LabelValuePair>: View {
    private let data: [T]
    private let gradient: Gradient

    private let largest: Double
    private let longestStringLength: Int

    private let fontSizeRatio: CGFloat = 0.34
    private let labelWidthRatio: CGFloat = 0.7
    private let barHeightRatio: CGFloat = 0.9

    init(data: [T], gradient: Gradient) {
        self.data = data
        self.gradient = gradient

        (largest, longestStringLength) = data.reduce((0.0, 0)) {
            lengths, item in
            (max(lengths.0, item.value), max(lengths.1, item.label.count))
        }
    }

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                ForEach(self.data, id: \.id) { item in
                    HStack(spacing: 0) {
                        Text(item.label)
                            .font(.system(size: self.fontSize(with: geometry),
                                          weight: .bold, design: .rounded))
                            .frame(width: self.labelWidth(with: geometry),
                                   alignment: .leading)

                        HBar(item: item, largest: self.largest)
                            .gradientForeground(gradient: self.gradient,
                                                startPoint: .leading,
                                                endPoint: .trailing)
                            .frame(
                                height: self.rowHeight(with: geometry) * self.barHeightRatio,
                                alignment: .center
                            )
                    }
                    .frame(height: self.rowHeight(with: geometry),
                           alignment: .center)
                }
            }
        }
    }

    private func fontSize(with geometry: GeometryProxy) -> CGFloat {
        min(geometry.size.width / CGFloat(self.data.count) * fontSizeRatio,
            rowHeight(with: geometry))
    }

    private func labelWidth(with geometry: GeometryProxy) -> CGFloat {
        fontSize(with: geometry) * CGFloat(longestStringLength) * labelWidthRatio
    }

    private func rowHeight(with geometry: GeometryProxy) -> CGFloat {
        geometry.size.height / CGFloat(data.count)
    }
}

struct HBar<T: LabelValuePair>: View {
    let item: T
    let largest: Double

    private let opacity: Double = 0.2

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .cornerRadius(geometry.size.height)
                    .opacity(self.opacity)

                Rectangle()
                    .frame(width: self.barLength(of: self.item, with: geometry))
                    .cornerRadius(geometry.size.height)
            }
        }
    }

    private func barLength(
        of item: T,
        with geometry: GeometryProxy
    ) -> CGFloat {
        CGFloat(item.value / self.largest) * geometry.frame(in: .local).width
    }
}

struct RoundedHistogram_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { _ in
            VStack(spacing: 20) {
                RoundedHistogram(data: testData, gradient: Gradient(colors: colors))
                    .frame(height: 200, alignment: .center)

                RoundedHistogram(data: testData, gradient: Gradient(colors: reds))
                    .frame(height: 170, alignment: .center)

                RoundedHistogram(data: testData, gradient: Gradient(colors: greens))
                    .frame(height: 130, alignment: .center)

                RoundedHistogram(data: testData, gradient: Gradient(colors: blues))
                    .frame(height: 100, alignment: .center)
            }
            .padding()
        }
        .background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all))
        .environment(\.colorScheme, .dark)
    }
}

#if DEBUG
struct Company {
    var name: String
    var marketValue: Double
    let id = UUID()

    init(_ name: String, _ marketValue: Double) {
        self.name = name
        self.marketValue = marketValue
    }
}

extension Company: LabelValuePair {
    var label: String { name }
    var value: Double { marketValue }
}

let testData: [Company] = [
    Company("Apple", 19000),
    Company("MicroSoft", 16100),
    Company("Amazon", 15900),
    Company("Alphabet", 10200),
    Company("Facebook", 7647),
    Company("Alibaba", 6807),
    Company("Tencent", 6360),
]

let colors: [Color] = [.purple, .blue, .green, .yellow]
let reds = [Color(red: 224/255, green: 0, blue: 21/255),
            Color(red: 1, green: 50/255, blue: 137/255)]
let greens = [Color(red: 53/255, green: 220/255, blue: 0/255),
              Color(red: 184/255, green: 255/255, blue: 0/255)]
let blues = [Color(red: 0/255, green: 186/255, blue: 255/255),
             Color(red: 5/255, green: 251/255, blue: 207/255)]
#endif
