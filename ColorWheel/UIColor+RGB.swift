//
//  UIColor+RGB.swift
//  ColorWheel
//
//  Created by Austin Evans on 5/8/20.
//  Copyright © 2020 ajevans. All rights reserved.
//

import SwiftUI

extension UIColor {
    var rgba: (red: Int, green: Int, blue: Int, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return (Int(red * 255), Int(green * 255), Int(blue * 255), alpha)
    }
}
