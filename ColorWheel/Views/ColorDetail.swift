//
//  ColorDetail.swift
//  ColorWheel
//
//  Created by Austin Evans on 5/9/20.
//  Copyright © 2020 ajevans. All rights reserved.
//

import SwiftUI

struct ColorDetail: View {
    @EnvironmentObject var pointers: Pointers

    var color: UIColor {
        self.pointers.selectedColor ?? .white
    }

    @State var opacity = 0.0
    @State var showShareSheet = false

    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .onTapGesture(perform: self.dismiss)
            NavigationView {
                ScrollView {
                VStack(alignment: .center, spacing: 16) {
                    ColorSwab(color: color)
                        .scaleEffect(1.5)
                        .padding(.all, 16)
                    HStack {
                        rgbText
                        Divider()
                        hsvText
                        Divider()
                        cmykText
                    }
                    .fixedSize()
                    .scaledToFit()
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
            .cornerRadius(8)
            .padding(.horizontal, 16)
            .padding(.vertical, 64)
        }
        .opacity(self.opacity)
        .onAppear {
            withAnimation(.easeInOut, { self.opacity = 1.0 })
        }
        .sheet(isPresented: $showShareSheet) {
            ActivityView(activityItems: [ColorActivityItemSource(color: self.color)],
                         applicationActivities: nil)
        }
    }

    var rgbText: some View {
        let rgb = color.rgba
        return VStack(alignment: .leading, spacing: 4) {
            Text("R: \(rgb.red)")
            Text("G: \(rgb.green)")
            Text("B: \(rgb.blue)")
        }
    }

    var cmykText: some View {
        let cmyk = color.cymk
        return VStack(alignment: .leading, spacing: 4) {
            Text("C: \(cmyk.cyan)")
            Text("Y: \(cmyk.yellow)")
            Text("M: \(cmyk.magenta)")
            Text("K: \(cmyk.black)")
        }
    }

    var hsvText: some View {
        let hsba = color.hsba
        return VStack(alignment: .leading, spacing: 4) {
            Text("H: \(String(format: "%.1f", hsba.hue))°")
                .font(.system(.body, design: .monospaced))
            Text("S: \(String(format: "%.1f", hsba.saturation))")
                .font(.system(.body, design: .monospaced))
            Text("B: \(String(format: "%.1f", hsba.brightness))")
                .font(.system(.body, design: .monospaced))
        }
    }

    var additionalDetails: some View {
        var helper = ColorDetailHelper(color: color)
        return VStack(alignment: .leading) {
            Section(header: Text("RGB Details").fontWeight(.bold)) {
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
    }

    func dismiss() {
        pointers.selectedColor = nil
    }

    func share() {
        showShareSheet = true
    }
}

struct ColorDetail_Previews: PreviewProvider {
    static var previews: some View {
        ColorDetail()
    }
}
