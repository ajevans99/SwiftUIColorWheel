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
    @State var fakeState = true

    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                ColorWheel()
                    .scaleEffect(0.9)
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
            .navigationBarTitle(Text("Color Wheel"), displayMode: .large)
            .navigationBarItems(trailing: NavigationLink(
                destination: FavoritesList()) {
                    Text("Favorites")
                }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
