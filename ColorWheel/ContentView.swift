//
//  ContentView.swift
//  ColorWheel
//
//  Created by Austin Evans on 5/5/20.
//  Copyright © 2020 ajevans. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var selectedColor: Color = .white
    @State var colors: [Color] = [.red, .green, .blue]

    var body: some View {
        ZStack {
            selectedColor
            VStack {
                Text("Color Wheel")
                ColorWheel(selectedColor: $selectedColor)
                    .aspectRatio(contentMode: .fit)
                    .padding(8)
                Spacer()
                ColorSwabs(colors: $colors)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
