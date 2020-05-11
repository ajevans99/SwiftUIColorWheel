//
//  UIImage+UIColor.swift
//  ColorWheel
//
//  Created by Austin Evans on 5/11/20.
//  Copyright © 2020 ajevans. All rights reserved.
//

import SwiftUI

extension UIImage {
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 100, height: 100)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}
