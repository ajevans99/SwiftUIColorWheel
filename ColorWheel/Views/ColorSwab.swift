//
//  ColorSwab.swift
//  ColorWheel
//
//  Created by Austin Evans on 5/8/20.
//  Copyright © 2020 ajevans. All rights reserved.
//

import SwiftUI

struct ColorSwab: View {
    @EnvironmentObject var favorites: Favorites

    let color: UIColor

    let brightness: Double

    init(color: UIColor) {
        self.color = color

        brightness = color.hsba.brightness
    }

    var body: some View {
        Rectangle()
            .foregroundColor(Color(color))
            .frame(width: 80, height: 80, alignment: .center)
            .fixedSize()
            .cornerRadius(8)
            .overlay(
                VStack {
                    Spacer()
                    colorText
                }
            )
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(brightness < 50 ? Color.white : Color.black, lineWidth: 2)
            )
            .shadow(radius: 8)
            .contextMenu {
                if favorites.contains(color: self.color) {
                    Button(action: {
                        self.favorites.remove(color: self.color)
                    }, label: {
                        HStack {
                            Text("Remove from Favorites")
                            Spacer()
                            Image(systemName: "star")
                        }
                    })
                } else {
                    Button(action: {
                        self.favorites.add(color: self.color)
                    }, label: {
                        HStack {
                            Text("Add to Favorites")
                            Spacer()
                            Image(systemName: "star.fill")
                        }
                    })
                }
            }
    }

    var colorText: some View {
        Text("#\(color.hex)")
            .font(.system(.caption, design: .monospaced))
            .foregroundColor(brightness < 50 ? .white : .black)
            .padding(.bottom, 4)
    }
}
