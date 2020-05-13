//
//  SearchView.swift
//  ColorWheel
//
//  Created by Austin Evans on 5/13/20.
//  Copyright © 2020 ajevans. All rights reserved.
//

import SwiftUI

struct Search: View {
    @EnvironmentObject var pointers: Pointers

    @State var text = ""
    @State var validationError: ValidationError?
    @State var opacity = 0.0

    static let allowedCharacters = CharacterSet(charactersIn: "0123456789ABCDEF")

    @Binding var isPresenting: Bool

    var body: some View {
        ZStack {
            Color.black
                .opacity(0.5)
                .onTapGesture(perform: dismiss)

            NavigationView {
                Form {
                    if validationError != nil {
                        Text(validationError!.description)
                            .foregroundColor(.red)
                    }

                    TextField("Color Hex",
                              text: $text,
                              onCommit: submit)
                }
                .navigationBarTitle(Text("Search"), displayMode: .inline)
                .navigationBarItems(leading: Button("Cancel", action: dismiss), trailing: Button("Submit", action: submit))
                }
                .cornerRadius(8)
                .scaledToFit()
                .padding(.horizontal, 16)
        }
        .edgesIgnoringSafeArea(.all)
        .opacity(opacity)
        .onAppear {
            withAnimation(.easeIn, { self.opacity = 1.0 })
        }
    }

    func submit() {
        validateHex()

        guard validationError == nil else { return }

        let color = UIColor(hex: text)
        let hsba = color.hsba

        pointers.primaryPointer.angle = Angle(degrees: hsba.hue)
        pointers.primaryPointer.radius = CGFloat(hsba.saturation / 100) * pointers.circleRadius
        pointers.primaryPointer.brightnessAngle = Angle(degrees: hsba.brightness / 100 * 360)
        pointers.objectWillChange.send()

        dismiss()
    }

    func dismiss() {
        isPresenting = false
    }

    private func validateHex() {
        text = text.replacingOccurrences(of: "#", with: "")
        if text.count < 6 {
            validationError = .tooShort
        } else if text.count > 6 {
            validationError = .tooLong
        } else if text.rangeOfCharacter(from: Search.allowedCharacters, options: .caseInsensitive) == nil {
            validationError = .invalidCharacter
        } else {
            validationError = nil
        }
    }
}

// MARK: - Validation Errors

extension Search {
    enum ValidationError {
        case tooShort
        case tooLong
        case invalidCharacter

        var description: String {
            switch self {
            case .tooShort, .tooLong:
                return "Hex codes must be exactly 6 characters long."
            case .invalidCharacter:
                return "Invalid characters. Use only A-Z and 0-9."
            }
        }
    }
}
