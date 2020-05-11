//
//  ActivityView.swift
//  ColorWheel
//
//  Created by Austin Evans on 5/11/20.
//  Copyright © 2020 ajevans. All rights reserved.
//

import SwiftUI

// Adapted from https://swiftui.gallery/uploads/code/ShareSheet.html

struct ActivityView: UIViewControllerRepresentable {

    let activityItems: [Any]
    let applicationActivities: [UIActivity]?

    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityView>) -> UIActivityViewController {
        let activityVC = UIActivityViewController(activityItems: activityItems,
                                        applicationActivities: applicationActivities)
        return activityVC
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController,
                                context: UIViewControllerRepresentableContext<ActivityView>) { }
}
