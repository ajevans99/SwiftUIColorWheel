//
//  ColorDetailRow.swift
//  ColorWheel
//
//  Created by Austin Evans on 5/12/20.
//  Copyright © 2020 ajevans. All rights reserved.
//

import SwiftUI

struct ColorDetailRow: View {
    let text: String
    let subtext: String
    var image: Image?
    var animation: ColorCombinationAnimation?

    var body: some View {
        HStack {
            if image != nil {
                image!
                    .frame(width: 40, height: 40)
                    .overlay(RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.primary, lineWidth: 3))
                    .cornerRadius(8)
            } else {
                animation!
                    .frame(width: 40, height: 40)
                    .overlay(RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.primary, lineWidth: 3))
                    .cornerRadius(8)
            }
            VStack(alignment: .leading) {
                Text(text.capitalized)
                Text(subtext.capitalized)
                    .foregroundColor(.secondary)
                    .font(.subheadline)
            }
            Spacer()
        }.font(.body)
    }
}
