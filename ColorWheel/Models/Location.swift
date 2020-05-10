//
//  Location.swift
//  ColorWheel
//
//  Created by Austin Evans on 5/10/20.
//  Copyright © 2020 ajevans. All rights reserved.
//

import SwiftUI

class Location: ObservableObject, Identifiable {
    @Published var angle: Angle
    @Published var radius: CGFloat

    @Published var brightnessAngle = Angle(radians: -(.pi / 2))

    var isDragging = false

    var offset: CGSize {
        CGSize(width: radius * CGFloat(cos(angle.radians)),
               height: radius * CGFloat(sin(angle.radians)))
    }

    func brightnessOffset(circleRadius: CGFloat) -> CGSize {
        CGSize(width: circleRadius * CGFloat(cos(brightnessAngle.radians)),
               height: circleRadius * CGFloat(sin(brightnessAngle.radians)))
    }

    init() {
        angle = Angle(degrees: 0)
        radius = 0
    }
}
