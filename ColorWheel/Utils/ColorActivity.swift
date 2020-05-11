//
//  ColorActivity.swift
//  ColorWheel
//
//  Created by Austin Evans on 5/11/20.
//  Copyright © 2020 ajevans. All rights reserved.
//

import SwiftUI
import LinkPresentation

class ColorActivityItemSource: NSObject, UIActivityItemSource {
    private var color: UIColor

    init(color: UIColor) {
        self.color = color
        super.init()
    }

    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return UIImage()
    }

    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        return self.color.hex
    }

    func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
        let metadata = LPLinkMetadata()
        let previewImage = urlForPreviewImage()

        metadata.title = "Color Sample (#\(color.hex))"
        metadata.originalURL = previewImage
        metadata.url = previewImage
        metadata.imageProvider = NSItemProvider(contentsOf: previewImage)
        metadata.iconProvider = NSItemProvider(contentsOf: previewImage)

        return metadata
    }

    func urlForPreviewImage() -> URL? {
        let image = UIImage(color: color)
        let temporaryDirectory = FileManager.default.temporaryDirectory
        let sharePreviewURL = temporaryDirectory.appendingPathComponent("color_preview.png")

        if let data = image?.pngData() {
            do {
                try data.write(to: sharePreviewURL)
                return sharePreviewURL
            } catch {
                print ("Error: \(error.localizedDescription)")
            }
        }

        return nil
    }
}
