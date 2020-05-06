//
//  ContentView.swift
//  ColorWheel
//
//  Created by Austin Evans on 5/5/20.
//  Copyright © 2020 ajevans. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var selectedColor: Color = .white

    var body: some View {
        ZStack {
            selectedColor
            VStack {
                ColorWheel(selectedColor: $selectedColor)
                    .aspectRatio(contentMode: .fit)
                    .padding(8)
            }

//                .frame(width: 100, height: 100, alignment: .center)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
