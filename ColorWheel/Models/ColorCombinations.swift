//
//  ColorCombinations.swift
//  ColorWheel
//
//  Created by Austin Evans on 5/10/20.
//  Copyright © 2020 ajevans. All rights reserved.
//

import SwiftUI

enum ColorCombinations: String, CaseIterable {
    case single
    case complementary
    case splitComplementary = "split complementary"
    case analogous
    case triadic
    case tetradic
    case square

    var count: Int {
        switch self {
        case .single:
            return 1
        case .complementary:
            return 2
        case .splitComplementary, .analogous, .triadic:
            return 3
        case .tetradic, .square:
            return 4
        }
    }

    var angle: Angle {
        switch self {
        case .single:
            return Angle(radians: 0)
        case .complementary:
            return Angle(radians: .pi)
        case .splitComplementary:
            return Angle(radians: 4 * .pi / 5)
        case .analogous:
            return Angle(radians: .pi / 6)
        case .triadic:
            return Angle(radians: 2 * .pi / 3)
        case .tetradic:
            return Angle(radians: .pi / 3)
        case .square:
            return Angle(radians: .pi / 2)
        }
    }
}

