//
//  FavoritesRow.swift
//  ColorWheel
//
//  Created by Austin Evans on 5/13/20.
//  Copyright © 2020 ajevans. All rights reserved.
//

import SwiftUI

struct FavoritesRow: View {
    @EnvironmentObject var favorites: Favorites

    @State var showShareSheet = false

    let favoriteColor: FavoriteColor
    let color: UIColor

    init(favoriteColor: FavoriteColor) {
        self.favoriteColor = favoriteColor
        self.color = favoriteColor.color
    }

    var body: some View {
        NavigationLink(destination: destination) {
            HStack {
                Color(color)
                    .frame(width: 40, height: 40)
                    .overlay(RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.primary, lineWidth: 3))
                    .cornerRadius(8)
                Text("#\(color.hex)")
                    .font(.system(.body, design: .monospaced))
                Spacer()
            }
        }
    }

    var destination: some View {
        ColorDetail(color: favoriteColor.color)
            .navigationBarTitle(Text(color.hex), displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: self.share) {
                    Image(systemName: "square.and.arrow.up")
                        .frame(height: 50)
                }
            )
    }

    func toggleFavorite() {
        if favorites.contains(color: color) {
            favorites.remove(color: color)
        } else {
            favorites.add(color: color)
        }
    }

    func share() {
        showShareSheet = true
    }
}
