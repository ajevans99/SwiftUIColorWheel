//
//  UIColor+RGB.swift
//  ColorWheel
//
//  Created by Austin Evans on 5/8/20.
//  Copyright © 2020 ajevans. All rights reserved.
//

import SwiftUI

extension UIColor {
    private var rgbaPrime: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return (red, green, blue, alpha)
    }

    var rgba: (red: Int, green: Int, blue: Int, alpha: CGFloat) {
        let prime = rgbaPrime

        return (Int(prime.red * 255),
                Int(prime.green * 255),
                Int(prime.blue * 255),
                prime.alpha)
    }

    var cymk: (cyan: Int, yellow: Int, magenta: Int, black: Int) {
        let prime = rgbaPrime
        let black = 1 - max(prime.red, prime.green, prime.blue)
        let cyan = (1 - prime.red - black) / (1 - black)
        let magenta = (1 - prime.green - black) / (1 - black)
        let yellow = (1 - prime.blue - black) / (1 - black)
        return (Int(cyan * 100), Int(magenta * 100), Int(yellow * 100), Int(black * 100))
    }

    var hsba: (hue: Double, saturation: Double, brightness: Double, alpha: Double) {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        return (Double(hue * 360), Double(saturation * 100), Double(brightness * 100), Double(alpha))
    }
}
