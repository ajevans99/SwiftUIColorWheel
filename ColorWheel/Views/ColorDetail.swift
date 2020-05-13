//
//  ColorDetail.swift
//  ColorWheel
//
//  Created by Austin Evans on 5/9/20.
//  Copyright © 2020 ajevans. All rights reserved.
//

import SwiftUI

struct ColorDetail: View {
    let color: UIColor

    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 16) {
                ColorSwab(color: color)
                    .scaleEffect(1.5)
                    .padding(.all, 16)
                VStack(alignment: .leading) {
                    classificationSection
                    rgbSection
                    cmykSection
                    hsbSection
                }
            }
            .font(.system(.body, design: .monospaced))
            .padding(.all, 32)
        }
    }

    var rgbSection: some View {
        let rgba = color.rgba
        return Section(header: Text("RGB Color System").fontWeight(.bold).font(.headline)) {
            ColorDetailRow(text: "Red",
                           subtext: "\(rgba.red)/256",
                           color: Color.red)
            ColorDetailRow(text: "Green",
                           subtext: "\(rgba.green)/256",
                           color: Color.green)
            ColorDetailRow(text: "Blue",
                           subtext: "\(rgba.blue)/256",
                           color: Color.blue)
        }
    }

    var cmykSection: some View {
        let cmyk = color.cmyk
        return Section(header: Text("CMYK Color System").fontWeight(.bold).font(.headline)) {
            ColorDetailRow(text: "Cyan",
                           subtext: "\(cmyk.cyan)/100",
                           color: Color(UIColor.cyan))
            ColorDetailRow(text: "Magenta",
                           subtext: "\(cmyk.magenta)/100",
                           color: Color(UIColor.magenta))
            ColorDetailRow(text: "Yellow",
                           subtext: "\(cmyk.yellow)/100",
                           color: Color(UIColor.yellow))
            ColorDetailRow(text: "Black",
                           subtext: "\(cmyk.black)/100",
                           color: Color.black)
        }
    }

    var hsbSection: some View {
        let hsba = color.hsba
        return Section(header: Text("HSB Color System").fontWeight(.bold).font(.headline)) {
            ColorDetailRow(text: "Hue",
                           subtext: "\(String(format: "%.1f", hsba.hue))°",
                           image: Image(systemName: "pencil.and.outline"))
            ColorDetailRow(text: "Saturation",
                           subtext: "\(String(format: "%.1f", hsba.saturation))/100",
                           image: Image(systemName: "eyedropper.halffull"))
            ColorDetailRow(text: "Brightness",
                           subtext: "\(String(format: "%.1f", hsba.brightness))/100",
                           image: Image(systemName: "sun.min.fill"))
        }
    }

    var classificationSection: some View {
        var helper = ColorDetailHelper(color: color)
        return Section(header: Text("Classification").fontWeight(.bold).font(.headline)) {
            ColorDetailRow(text: "Pure Hue",
                           subtext: helper.pureHue.rawValue,
                           image: Image(uiImage: UIImage(color: helper.pureHue.color)!))
            ColorDetailRow(text: "Hue Type",
                           subtext: helper.pureHue.category.rawValue,
                           image: Image(systemName: helper.pureHue.category == .additive ? "plus" : "minus"))
            ColorDetailRow(text: "Tertiary Hue",
                           subtext: helper.tertiaryHue.rawValue,
                           colors: CombineColors(
                            color1: helper.tertiaryHue.pureHues[0].color,
                            color2: helper.tertiaryHue.pureHues[1].color))
        }
    }
}
