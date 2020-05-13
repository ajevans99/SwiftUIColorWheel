//
//  PolarToColor.swift
//  ColorWheel
//
//  Created by Austin Evans on 5/10/20.
//  Copyright © 2020 ajevans. All rights reserved.
//

import SwiftUI

func polarToColor(radius: CGFloat, angle: Angle, circleRadius: CGFloat, brightnessAngle: Angle?) -> UIColor {
    let saturation = circleRadius == 0 ? 0 : radius / circleRadius
    let hue = CGFloat((360 + angle.degrees)
        .truncatingRemainder(dividingBy: 360) / 360)

    let brightness: CGFloat

    if let brightnessAngle = brightnessAngle {
        brightness = CGFloat((360 + brightnessAngle.degrees)
            .truncatingRemainder(dividingBy: 360) / 360)
    } else {
        brightness = 1.0
    }

    return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
}
