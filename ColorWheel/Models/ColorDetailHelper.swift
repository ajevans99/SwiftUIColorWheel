//
//  ColorDetailHelper.swift
//  ColorWheel
//
//  Created by Austin Evans on 5/12/20.
//  Copyright © 2020 ajevans. All rights reserved.
//

import SwiftUI

struct MunsellColor {
    let name: String
    let pricipleHues: String

}

struct ColorDetailHelper {
    let color: UIColor

    lazy var pureHue: PureHue = {
        let hue = color.hsba.hue
        switch hue {
        case 330...360, 0...30:
            return .red
        case 30...90:
            return .yellow
        case 90...150:
            return .green
        case 150...210:
            return .cyan
        case 210...270:
            return .blue
        case 270...330:
            return .magenta
        default:
            fatalError("Invalid color.")
        }
    }()

    lazy var tertiaryHue: TertiaryHue = {
        let hue = color.hsba.hue
        switch hue {
        case 0...60:
            return .orange
        case 60...120:
            return .chartreuse
        case 120...180:
            return .springGreen
        case 180...240:
            return .azure
        case 240...300:
            return .violet
        case 300...360:
            return .rose
        default:
            fatalError("Invalid color.")
        }
    }()

    enum PureHue: String {
        case red
        case yellow
        case green
        case cyan
        case blue
        case magenta

        enum Category: String {
            case additive
            case subtractive
        }

        var category: Category {
            let primaryPureHues: Set<PureHue> = [.red, .green, .blue]
            return primaryPureHues.contains(self) ? .additive : .subtractive
        }

        var color: UIColor {
            switch self {
            case .blue:
                return .blue
            case .yellow:
                return .yellow
            case .green:
                return .green
            case .cyan:
                return .cyan
            case .red:
                return .red
            case .magenta:
                return .magenta
            }
        }
    }

    enum TertiaryHue: String {
        case azure
        case violet
        case rose
        case orange
        case chartreuse
        case springGreen = "spring green"

        var pureHues: [PureHue] {
            switch self {
            case .azure:
                return [.cyan, .blue]
            case .violet:
                return [.blue, .magenta]
            case .rose:
                return [.magenta, .red]
            case .orange:
                return [.red, .yellow]
            case .chartreuse:
                return [.yellow, .green]
            case .springGreen:
                return [.green, .cyan]
            }
        }
    }
}
