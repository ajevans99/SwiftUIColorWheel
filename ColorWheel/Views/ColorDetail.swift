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

    @Binding var isPresenting: Bool
    @State var showShareSheet = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .center, spacing: 16) {
                    ColorSwab(color: color)
                        .scaleEffect(1.5)
                        .padding(.all, 16)
                    additionalDetails
                }
                .font(.system(.body, design: .monospaced))
                .padding(.all, 32)
                .navigationBarTitle("Details", displayMode: .inline)
                .navigationBarItems(leading: Button(action: self.share) {
                    Image(systemName: "square.and.arrow.up")
                }, trailing: Button(action: self.dismiss) {
                    Text("Done")
                })
            }
        }
        .sheet(isPresented: $showShareSheet) {
            ActivityView(activityItems: [ColorActivityItemSource(color: self.color), UIImage(color: self.color) as Any],
                         applicationActivities: nil)
        }
    }

    var additionalDetails: some View {
        return VStack(alignment: .leading) {
            classificationSection
            rgbSection
            cymkSection
            hsbSection
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

    var cymkSection: some View {
        let cymk = color.cymk
        return Section(header: Text("CYMK Color System").fontWeight(.bold).font(.headline)) {
            ColorDetailRow(text: "Cyan",
                           subtext: "\(cymk.cyan)/100",
                           image: Image(uiImage: UIImage(color: .cyan)!))
            ColorDetailRow(text: "Yellow",
                           subtext: "\(cymk.yellow)/100",
                           image: Image(uiImage: UIImage(color: .yellow)!))
            ColorDetailRow(text: "Magenta",
                           subtext: "\(cymk.magenta)/100",
                           image: Image(uiImage: UIImage(color: .magenta)!))
            ColorDetailRow(text: "Black",
                           subtext: "\(cymk.black)/100",
                           image: Image(uiImage: UIImage(color: .black)!))
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
                           animation: ColorCombinationAnimation(
                            color1: helper.tertiaryHue.pureHues[0].color,
                            color2: helper.tertiaryHue.pureHues[1].color))
        }
    }

    func dismiss() {
        isPresenting = false
    }

    func share() {
        showShareSheet = true
    }
}
