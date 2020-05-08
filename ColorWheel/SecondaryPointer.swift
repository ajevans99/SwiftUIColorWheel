//
//  SecondayPointerView.swift
//  ColorWheel
//
//  Created by Austin Evans on 5/7/20.
//  Copyright © 2020 ajevans. All rights reserved.
//

import SwiftUI

struct SecondaryPointerView: View {
    @EnvironmentObject var pointers: Pointers

    let index: Int

    init(index: Int) {
        self.index = index
    }

    var body: some View {
        Circle()
            .stroke(Color.white, lineWidth: 3)
            .foregroundColor(.clear)
            .frame(width: 10, height: 10, alignment: .center)
            .shadow(radius: 8)
            .offset(pointers.secondaryPointers[index].offset)
            .animation(Animation.interactiveSpring())
    }
}
