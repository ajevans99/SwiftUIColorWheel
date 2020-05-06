//
//  CGFloat+Radians.swift
//  ColorWheel
//
//  Created by Austin Evans on 5/6/20.
//  Copyright © 2020 ajevans. All rights reserved.
//

import Foundation
import SwiftUI

extension CGFloat {
    func radianToDegrees() -> CGFloat {
        return self * 180 / CGFloat.pi
    }
}
