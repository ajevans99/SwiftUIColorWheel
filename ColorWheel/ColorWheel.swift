//
//  ColorWheel.swift
//  ColorWheel
//
//  Created by Austin Evans on 5/5/20.
//  Copyright © 2020 ajevans. All rights reserved.
//

import SwiftUI

struct ColorWheel: View {

    @Binding var selectedColor: Color

    @State var pointerLocation: CGPoint = .zero

    @State var radius: CGFloat = .zero

    init(selectedColor: Binding<Color>) {
        self._selectedColor = selectedColor
    }

    var body: some View {
        VStack {
            GeometryReader { geometry in
                ZStack {
                    Circle()
                        .fill(self.angularGradient)
                        .overlay(
                            Circle()
                                .fill(self.radialGradient)
                    )

                    Circle()
                        .foregroundColor(.white)
                        .frame(width: 20, height: 20, alignment: .center)
                        .shadow(radius: 8)
                        .offset(x: self.pointerLocation.x, y: self.pointerLocation.y)
                        .animation(Animation.interactiveSpring())
                        .gesture(DragGesture()
                            .onChanged { value in
                                self.setPointerPosition(usingDragValue: value, radius: geometry.size.height / 2)
                            })
                }
                .onAppear {
                    self.radius = geometry.size.height / 2
                }
            }
        }
    }

    func setPointerPosition(usingDragValue value: DragGesture.Value, radius: CGFloat) {
        let offsetX = value.startLocation.x + value.translation.width - 10
        let offsetY = value.startLocation.y + value.translation.height - 10

        // Make sure you are inside circle using pythagorean theorem
        guard pow(abs(offsetX), 2) + pow(abs(offsetY), 2) <= pow(abs(radius), 2) else {
            return
        }

        self.pointerLocation.x = offsetX
        self.pointerLocation.y = offsetY
    }
}

// MARK: - Colors
private extension ColorWheel {
    var hues: [Color] {
        let hueValues = Array(0...359)
        return hueValues.map {
            Color(UIColor(hue: CGFloat($0) / 359.0,
                          saturation: 1,
                          brightness: 1,
                          alpha: 1))
        }
    }

    var saturation: [Color] {
        let saturationValues = stride(from: 0, through: 1, by: 0.0001)
        return saturationValues.map {
            Color(UIColor(hue: 0,
                          saturation: CGFloat($0),
                          brightness: 1,
                alpha: CGFloat(1-$0)))
        }
    }

    var gradient: Gradient {
        Gradient(colors: hues)
    }

    var angularGradient: AngularGradient {
        AngularGradient(gradient: gradient, center: .center)
    }

    var radialGradient: RadialGradient {
        RadialGradient(gradient: Gradient(colors: saturation), center: .center, startRadius: 0, endRadius: radius)
    }
}
