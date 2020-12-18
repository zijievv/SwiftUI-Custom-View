//
//  View+Extension.swift
//  SwiftUI-Custom-View
//
//  Created by zijie vv on 18/12/2020.
//  Copyright © 2020 zijie vv. All rights reserved.
//
//  ================================================================================================
//

import SwiftUI

extension View {
    public func squareFrame(_ size: CGFloat, alignment: Alignment = .center) -> some View {
        self.frame(width: size, height: size, alignment: alignment)
    }

    func foreground<S: View>(_ content: S) -> some View {
        self.foregroundColor(.clear)
            .overlay(content.mask(self))
    }
}
