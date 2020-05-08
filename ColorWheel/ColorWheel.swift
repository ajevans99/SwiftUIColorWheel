//
//  ColorWheel.swift
//  ColorWheel
//
//  Created by Austin Evans on 5/5/20.
//  Copyright © 2020 ajevans. All rights reserved.
//

import SwiftUI

struct ColorWheel: View {
    @State var radius: CGFloat = .zero
    @EnvironmentObject var pointers: Pointers

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Circle()
                    .fill(self.angularGradient)
                    .overlay(
                        Circle()
                            .fill(self.radialGradient)
                            .overlay(Circle()
                                .stroke(Color.black, lineWidth: 2)
                                .foregroundColor(.clear))
                )

                ForEach(0..<(self.pointers.colorCombination.count - 1), id: \.self) { index in
                    SecondaryPointerView(index: index)
                }

                Circle()
                    .stroke(Color.white, lineWidth: 6)
                    .foregroundColor(.clear)
                    .frame(width: 10, height: 10, alignment: .center)
                    .shadow(radius: 8)
                    .offset(self.pointers.primaryPointer.offset)
                    .animation(Animation.interactiveSpring())
                    .gesture(DragGesture()
                        .onChanged { value in
                            self.pointers.primaryPointer.isDragging = true
                            self.setPointerPosition(usingDragValue: value)
                        }
                        .onEnded{ _ in
                            self.pointers.primaryPointer.isDragging = false
                        })

            }
            .onAppear {
                self.radius = geometry.size.height / 2
                self.pointers.circleRadius = geometry.size.height / 2
            }
        }
    }

    func setPointerPosition(usingDragValue value: DragGesture.Value) {
        let offsetX = value.startLocation.x + value.translation.width - 5
        let offsetY = value.startLocation.y + value.translation.height - 5

        // Make sure you are inside circle using pythagorean theorem
        let pointerRadius = sqrt(offsetX * offsetX + offsetY * offsetY)
        guard pointerRadius <= radius else {
            return
        }
        pointers.primaryPointer.radius = pointerRadius
        pointers.primaryPointer.angle.radians = Double(atan2(offsetY/radius, offsetX/radius))
        pointers.objectWillChange.send()
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
        RadialGradient(gradient: Gradient(colors: saturation),
                       center: .center,
                       startRadius: 0,
                       endRadius: radius)
    }
}
