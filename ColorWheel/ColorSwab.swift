//
//  ColorSwab.swift
//  ColorWheel
//
//  Created by Austin Evans on 5/8/20.
//  Copyright © 2020 ajevans. All rights reserved.
//

import SwiftUI

struct ColorSwab: View {

    let color: UIColor

    @State var selected: Bool = false

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
            .onTapGesture {
                self.selected = !self.selected
        }
    }

    var colorText: some View {
        let components = color.rgba
        let red = String(format: "%02X", components.red)
        let green = String(format: "%02X", components.green)
        let blue = String(format: "%02X", components.blue)
        return Text("#\(red)\(green)\(blue)")
            .font(.system(.caption, design: .monospaced))
            .padding(.bottom, 4)
    }
}
