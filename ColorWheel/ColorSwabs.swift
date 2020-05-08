//
//  ColorSwabs.swift
//  ColorWheel
//
//  Created by Austin Evans on 5/7/20.
//  Copyright © 2020 ajevans. All rights reserved.
//

import SwiftUI

struct ColorSwabs: View {
    @Binding var colors: [Color]

    init(colors: Binding<[Color]>) {
        self._colors = colors
    }

    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            ForEach(colors, id: \.self) { color in
                Rectangle().foregroundColor(color)
            }
        }
    }
}
