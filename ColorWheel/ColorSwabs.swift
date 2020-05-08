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

    var transition: AnyTransition {
        if pointers.primaryPointer.isDragging {
            return .identity
        }
        return .asymmetric(insertion: .move(edge: .trailing),
                           removal: .opacity)
    }

    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            ForEach(pointers.colors, id: \.self) { color in
                ColorSwab(color: color)
                    .transition(self.transition)
            }.animation(.easeInOut(duration: 1))
        }.padding(20)
    }
}
