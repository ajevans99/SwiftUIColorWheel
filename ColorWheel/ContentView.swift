//
//  ContentView.swift
//  ColorWheel
//
//  Created by Austin Evans on 5/5/20.
//  Copyright © 2020 ajevans. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var pointers: Pointers

    var body: some View {
        ZStack {
            Color(.init(red: 0.9, green: 0.9, blue: 0.9, alpha: 1))
            VStack(alignment: .center) {
                Text("Color Wheel")
                    .font(.title)
                    .padding(.top, 32)
                ColorWheel()
                    .aspectRatio(contentMode: .fit)
                    .padding(8)
                Spacer()
                Picker(selection: $pointers.colorCombination,
                       label: Text("Combination")) {
                        ForEach(ColorCombinations.allCases, id: \.self) { combo in
                            Text(combo.rawValue)
                        }
                }
                .labelsHidden()
                ColorSwabs()
            }
        }.edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
