//
//  ColorCombinationAnimation.swift
//  ColorWheel
//
//  Created by Austin Evans on 5/12/20.
//  Copyright © 2020 ajevans. All rights reserved.
//

import SwiftUI

struct ColorCombinationAnimation: View {
    let color1: UIColor
    let color2: UIColor

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Rectangle()
                    .foregroundColor(Color(self.color1))
                    .opacity(0.5)
//                    .frame(width: geometry.size.width / 2,
//                           height: geometry.size.height)

                Rectangle()
                    .foregroundColor(Color(self.color2))
                    .opacity(0.5)
//                    .offset(CGSize(width: geometry.size.width / 2, height: .zero))
//                    .frame(width: geometry.size.width / 2,
//                           height: geometry.size.height)
            }
        }
    }
}

struct ColorCombinationAnimation_Previews: PreviewProvider {
    static var previews: some View {
        ColorCombinationAnimation(color1: .red, color2: .blue)
            .previewLayout(.fixed(width: 50, height: 50))
    }
}
