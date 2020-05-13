//
//  ColorDetailSheet.swift
//  ColorWheel
//
//  Created by Austin Evans on 5/13/20.
//  Copyright © 2020 ajevans. All rights reserved.
//

import SwiftUI

struct ColorDetailSheet: View {
    let color: UIColor

    @EnvironmentObject var favorites: Favorites

    @Binding var isPresenting: Bool
    @State var showShareSheet = false

    var body: some View {
        NavigationView {
            ColorDetail(color: self.color)
                .navigationBarTitle("Details", displayMode: .inline)
                .navigationBarItems(leading: HStack(spacing: 16) {
                    Button(action: self.toggleFavorite) {
                        Image(systemName: self.favorites.contains(color: self.color) ? "star.fill" : "star")
                        .scaledToFit()
                            .frame(height: 50)
                    }
                    Button(action: self.share) {
                        Image(systemName: "square.and.arrow.up")
                            .frame(height: 50)
                    }
                }, trailing: Button(action: self.dismiss) {
                    Text("Done")
                })
        }
        .sheet(isPresented: $showShareSheet) {
            ActivityView(activityItems: [ColorActivityItemSource(color: self.color), UIImage(color: self.color) as Any],
                         applicationActivities: nil)
        }
    }

    func dismiss() {
        isPresenting = false
    }

    func share() {
        showShareSheet = true
    }

    func toggleFavorite() {
        if favorites.contains(color: color) {
            favorites.remove(color: color)
        } else {
            favorites.add(color: color)
        }
    }
}
