//
//  RelativeLocation.swift
//  ColorWheel
//
//  Created by Austin Evans on 5/10/20.
//  Copyright © 2020 ajevans. All rights reserved.
//

import SwiftUI

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
