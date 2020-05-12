//
//  ColorSwab.swift
//  ColorWheel
//
//  Created by Austin Evans on 5/8/20.
//  Copyright © 2020 ajevans. All rights reserved.
//

import SwiftUI

struct ColorSwab: View {
    @EnvironmentObject var pointers: Pointers

    let color: UIColor

    init(color: UIColor) {
        self.color = color
    }

    var body: some View {
        Rectangle()
            .foregroundColor(Color(color))
            .frame(width: 80, height: 80, alignment: .center)
            .fixedSize()
            .cornerRadius(8)
            .overlay(
                VStack {
                    Spacer()
                    colorText
                }
            )
            .shadow(radius: 8)
    }

    var colorText: some View {
        let brightness = color.hsba.brightness
        return Text("#\(color.hex)")
            .font(.system(.caption, design: .monospaced))
            .foregroundColor(brightness < 50 ? .white : .black)
            .padding(.bottom, 4)
    }
}
