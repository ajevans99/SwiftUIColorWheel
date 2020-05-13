//
//  FavoritesService.swift
//  ColorWheel
//
//  Created by Austin Evans on 5/12/20.
//  Copyright © 2020 ajevans. All rights reserved.
//

import Foundation

class FavoritesService {
    static let shared = FavoritesService()
    private static let filename = "favorites.json"

    func save(_ colors: [FavoriteColor]) -> Bool {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(colors)
            try data.write(to: path())
        } catch {
            return false
        }

        return true
    }

    func retrieve() -> [FavoriteColor] {
        do {
            let decoder = JSONDecoder()
            let data = try Data(contentsOf: path())
            return try decoder.decode([FavoriteColor].self, from: data)
        } catch {
            // File does not exist or is corrupted
            return [FavoriteColor]()
        }
    }
}

extension FavoritesService {
    private func path() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0].appendingPathComponent(FavoritesService.filename)
    }
}

