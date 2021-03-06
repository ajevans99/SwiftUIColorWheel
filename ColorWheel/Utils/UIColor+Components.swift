//
//  UIColor+Components.swift
//  ColorWheel
//
//  Created by Austin Evans on 5/8/20.
//  Copyright © 2020 ajevans. All rights reserved.
//

import SwiftUI

extension UIColor {
    var rgbaPrime: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
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

    var cmyk: (cyan: Int, yellow: Int, magenta: Int, black: Int) {
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

    var hex: String {
        let components = rgba
        let red = String(format: "%02X", components.red)
        let green = String(format: "%02X", components.green)
        let blue = String(format: "%02X", components.blue)
        return "\(red)\(green)\(blue)"
    }
}

extension UIColor {
    convenience init(hex: String) {
        var rgbValue: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&rgbValue)
        let components = (
            red: CGFloat((rgbValue >> 16) & 0xff) / 255.0,
            green: CGFloat((rgbValue >> 8) & 0xff) / 255.0,
            blue: CGFloat((rgbValue >> 0) & 0xff) / 255.0
        )

        self.init(red: components.red,
                  green: components.green,
                  blue: components.blue,
                  alpha: 1.0)
    }
}
