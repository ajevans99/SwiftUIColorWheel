//
//  Pointers.swift
//  ColorWheel
//
//  Created by Austin Evans on 5/7/20.
//  Copyright © 2020 ajevans. All rights reserved.
//

import SwiftUI
import Combine

enum ColorCombinations {
    case single
    case complementary
    case analogous
    case triadic
    case tetradic

    var count: Int {
        switch self {
        case .single:
            return 1
        case .complementary:
            return 2
        case .analogous, .triadic:
            return 3
        case .tetradic:
            return 4
        }
    }

    var angle: Angle {
        switch self {
        case .single:
            return Angle(radians: 0)
        case .complementary:
            return Angle(radians: .pi)
        case .analogous:
            return Angle(radians: .pi / 6)
        case .triadic:
            return Angle(radians: 2 * .pi / 3)
        case .tetradic:
            return Angle(radians: .pi / 2)
        }
    }
}

class Pointers: ObservableObject {
    @Published var primaryPointer = Location()
    @Published var secondaryPointers = [RelativeLocation]()

    var colorCombination: ColorCombinations = .triadic {
        didSet {
            updateSecondaryPointers()
        }
    }

    init() {
        updateSecondaryPointers()
    }

    func updateSecondaryPointers() {
        switch colorCombination {
        case .single:
            secondaryPointers = [RelativeLocation]()
        case .analogous:
            secondaryPointers = [RelativeLocation(referenceLocation: primaryPointer,
                                                  relativeAngle: colorCombination.angle),
                                 RelativeLocation(referenceLocation: primaryPointer,
                                                  relativeAngle: -colorCombination.angle)]
        default:
            let count = colorCombination.count
            secondaryPointers = (1..<count).map { number in
                return RelativeLocation(referenceLocation: primaryPointer,
                                        relativeAngle: colorCombination.angle * Double(number))
            }
        }
    }
}

class Location: ObservableObject {
    @Published var angle: Angle
    @Published var radius: CGFloat

    var offset: CGSize {
        CGSize(width: radius * CGFloat(cos(angle.radians)),
               height: radius * CGFloat(sin(angle.radians)))
    }

    init() {
        angle = .zero
        radius = .zero
    }
}

class RelativeLocation: ObservableObject {
    @ObservedObject var referenceLocation: Location

    let relativeAngle: Angle

    var offset: CGSize {
        CGSize(width: referenceLocation.radius * CGFloat(cos(angle.radians)),
               height: referenceLocation.radius * CGFloat(sin(angle.radians)))
    }

    var angle: Angle {
        referenceLocation.angle + relativeAngle
    }

    init(referenceLocation: Location, relativeAngle: Angle) {
        self.referenceLocation = referenceLocation
        self.relativeAngle = relativeAngle
    }
}
