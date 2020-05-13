//
//  Favorites.swift
//  ColorWheel
//
//  Created by Austin Evans on 5/12/20.
//  Copyright © 2020 ajevans. All rights reserved.
//

import SwiftUI

class Favorites: ObservableObject {
    @Published var colors: [FavoriteColor]

    init() {
        colors = FavoritesService.shared.retrieve()
    }

    @discardableResult
    func add(color: UIColor) -> Bool {
        let rgbaPrime = color.rgbaPrime
        let favoriteColor = FavoriteColor(red: Double(rgbaPrime.red),
                                          green: Double(rgbaPrime.green),
                                          blue: Double(rgbaPrime.blue))
        colors.append(favoriteColor)
        return FavoritesService.shared.save(colors)
    }

    @discardableResult
    func remove(color: UIColor) -> Bool {
        if let index = colors.firstIndex(where: { $0.color == color }) {
            colors.remove(at: index)
        }
        return FavoritesService.shared.save(colors)
    }

    func contains(color: UIColor) -> Bool {
        return colors.contains(where: { $0.color == color })
    }
}

struct FavoriteColor: Codable, Identifiable {
    let id = UUID()
    var red: Double
    var green: Double
    var blue: Double

    var color: UIColor {
        UIColor(red: CGFloat(red),
                green: CGFloat(green),
                blue: CGFloat(blue),
                alpha: 1.0)
    }
}
