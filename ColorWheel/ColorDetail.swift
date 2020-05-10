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

    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
            NavigationView {
                VStack(alignment: .center, spacing: 48) {
                    ColorSwab(color: color)
                        .scaleEffect(1.5)
                        .padding(.all, 16)
                    HStack {
                        rgbText
                        Divider()
                        hsvText
                        Divider()
                        cmykText
                    }.scaledToFit()
//                    Divider()
//                    Text("Similar Colors")
//                    HStack {
//                        ColorSwab(color: self.color)
//                        ColorSwab(color: self.color)
//                        ColorSwab(color: self.color)
//                    }
                }
                .padding(.all, 32)
                .navigationBarTitle("Details", displayMode: .inline)
                .navigationBarItems(trailing: Button(action: {
                    self.pointers.selectedColor = nil
                }, label: {
                    Text("Done")
                }))
            }
            .scaledToFit()
            .cornerRadius(8)
            .padding(.horizontal, 16)
        }
        .opacity(self.opacity)
        .onAppear {
            withAnimation(.easeIn, { self.opacity = 1.0 })
        }
    }

    var rgbText: some View {
        let rgb = color.rgba
        return VStack(alignment: .leading, spacing: 4) {
            Text("R: \(rgb.red)").font(.system(.body, design: .monospaced))
            Text("G: \(rgb.green)").font(.system(.body, design: .monospaced))
            Text("B: \(rgb.blue)").font(.system(.body, design: .monospaced))
        }
    }

    var cmykText: some View {
        let cmyk = color.cymk
        return VStack(alignment: .leading, spacing: 4) {
            Text("C: \(cmyk.cyan)").font(.system(.body, design: .monospaced))
            Text("Y: \(cmyk.yellow)").font(.system(.body, design: .monospaced))
            Text("M: \(cmyk.magenta)").font(.system(.body, design: .monospaced))
            Text("K: \(cmyk.black)").font(.system(.body, design: .monospaced))
        }
    }

    var hsvText: some View {
        let hsba = color.hsba
        return VStack(alignment: .leading, spacing: 4) {
            Text("H: \(String(format: "%.1f", hsba.hue))°")
                .font(.system(.body, design: .monospaced))
            Text("S: \(String(format: "%.1f", hsba.saturation))")
                .font(.system(.body, design: .monospaced))
            Text("B: \(hsba.brightness)")
                .font(.system(.body, design: .monospaced))
        }
    }
}

struct ColorDetail_Previews: PreviewProvider {
    static var previews: some View {
        ColorDetail()
    }
}
