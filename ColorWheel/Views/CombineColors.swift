//
//  CombineColors.swift
//  ColorWheel
//
//  Created by Austin Evans on 5/12/20.
//  Copyright © 2020 ajevans. All rights reserved.
//

import SwiftUI

struct CombineColors: View {
    let color1: UIColor
    let color2: UIColor

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Rectangle()
                    .foregroundColor(Color(self.color1))
                    .opacity(0.5)

                Rectangle()
                    .foregroundColor(Color(self.color2))
                    .opacity(0.5)
            }
        }
    }
}
