//
//  Pointers.swift
//  ColorWheel
//
//  Created by Austin Evans on 5/7/20.
//  Copyright © 2020 ajevans. All rights reserved.
//

import SwiftUI

class Pointers: ObservableObject {
    @Published var primaryPointer = Location()
    @Published var secondaryPointers = [RelativeLocation]()

    @Published var selectedColor: UIColor?

    var colorCombination: ColorCombinations = .single {
        didSet {
            updateSecondaryPointers()
        }
    }

    var circleRadius: CGFloat = 0

    var colors: [UIColor] {
        var colors = [polarToColor(radius: primaryPointer.radius,
                                   angle: primaryPointer.angle,
                                   circleRadius: circleRadius,
                                   brightnessAngle: primaryPointer.brightnessAngle)]

        colors += secondaryPointers.map { location in
            polarToColor(radius: primaryPointer.radius,
                         angle: location.angle,
                         circleRadius: circleRadius,
                         brightnessAngle: primaryPointer.brightnessAngle)
        }
        return colors
    }

    init() {
        updateSecondaryPointers()
    }

    func updateSecondaryPointers() {
        switch colorCombination {
        case .single:
            secondaryPointers = [RelativeLocation]()
        case .splitComplementary, .analogous:
            secondaryPointers = [
                RelativeLocation(referenceLocation: primaryPointer,
                                 relativeAngle: colorCombination.angle),

                RelativeLocation(referenceLocation: primaryPointer,
                                 relativeAngle: -colorCombination.angle)
            ]
        case .tetradic:
            secondaryPointers = [
                RelativeLocation(referenceLocation: primaryPointer,
                                 relativeAngle: colorCombination.angle),
                RelativeLocation(referenceLocation: primaryPointer,
                                 relativeAngle: colorCombination.angle * 3),
                RelativeLocation(referenceLocation: primaryPointer,
                                 relativeAngle: -(colorCombination.angle * 2)),
            ]
        default:
            let count = colorCombination.count
            secondaryPointers = (1..<count).map { number in
                return RelativeLocation(referenceLocation: primaryPointer,
                                        relativeAngle: colorCombination.angle * Double(number))
            }
        }
    }
}
