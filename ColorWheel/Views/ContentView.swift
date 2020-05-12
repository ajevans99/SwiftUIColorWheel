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
            Color.white
            VStack(alignment: .center) {
                Text("Color Wheel")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 16)
                ColorWheel()
                    .aspectRatio(contentMode: .fit)
                Picker(selection: $pointers.colorCombination,
                       label: Text("Combination")) {
                        ForEach(ColorCombinations.allCases, id: \.self) { combo in
                            Text(combo.rawValue)
                        }
                }
                .labelsHidden()
                .frame(maxHeight: 150)
                .clipped()
                ColorSwabs()
            }
            if pointers.selectedColor != nil {
                withAnimation {
                    ColorDetail()
                }
            }
        }.edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
