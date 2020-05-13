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
    @State var isShowingSearch = false

    var body: some View {
        ZStack {
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
                .navigationBarItems(leading: self.leading, trailing: self.trailing)
            }
            if isShowingSearch {
                Search(isPresenting: $isShowingSearch)
            }
        }
    }

    func showSearch() {
        isShowingSearch = true
    }
}

// MARK: - Navigation Buttons

extension ContentView {
    var leading: some View {
        NavigationLink(destination: FavoritesList()) {
            Text("Favorites")
        }
    }

    var trailing: some View {
        Button(action: showSearch) {
                Image(systemName: "magnifyingglass")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
