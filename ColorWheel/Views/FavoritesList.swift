//
//  FavoritesList.swift
//  ColorWheel
//
//  Created by Austin Evans on 5/12/20.
//  Copyright © 2020 ajevans. All rights reserved.
//

import SwiftUI

struct FavoritesList: View {
    @EnvironmentObject var favorites: Favorites

    @State var editMode: EditMode = .inactive

    var body: some View {
        Group {
            if favorites.colors.count == 0 {
                VStack(alignment: .center) {
                    Text("No favorites found")
                        .padding(.vertical, 32)
                    Text("Select a color and tap the star to add to favorites")
                        .multilineTextAlignment(.center)
                    Spacer()
                }.padding(.horizontal, 32)
            } else {
                List {
                    ForEach(favorites.colors) { color in
                        FavoritesRow(favoriteColor: color)
                            .environmentObject(self.favorites)
                    }
                    .onDelete(perform: self.removeRows)

                }
            }
        }
        .navigationBarTitle(Text("Favorites"))
        .navigationBarItems(trailing: EditButton())
        .environment(\.editMode, $editMode)
    }

    func removeRows(at offsets: IndexSet) {
        offsets.forEach { favorites.colors.remove(at: $0) }
        _ = FavoritesService.shared.save(favorites.colors)
    }
}
