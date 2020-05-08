//
//  ColorSwabs.swift
//  ColorWheel
//
//  Created by Austin Evans on 5/7/20.
//  Copyright © 2020 ajevans. All rights reserved.
//

import SwiftUI

struct ColorSwabs: View {
    @EnvironmentObject var pointers: Pointers

    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            ForEach(pointers.colors, id: \.self) { color in
                Rectangle()
                    .foregroundColor(color)
                    .frame(width: 100, height: 100, alignment: .center)
                    .fixedSize()
                    .transition(AnyTransition.scale)
            }.animation(Animation.easeIn)
        }.padding(20)
    }
}
