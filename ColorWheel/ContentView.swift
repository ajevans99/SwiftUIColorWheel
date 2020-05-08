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
    @EnvironmentObject var pointers: Pointers

    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                Text("Color Wheel")
                    .font(.title)
                ColorWheel(selectedColor: $selectedColor)
                    .aspectRatio(contentMode: .fit)
                    .padding(8)
                Picker(selection: $pointers.colorCombination,
                       label: Text("Combination")) {
                        ForEach(ColorCombinations.allCases, id: \.self) { combo in
                            Text(combo.rawValue)
                        }
                }.labelsHidden()
                ColorSwabs()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
