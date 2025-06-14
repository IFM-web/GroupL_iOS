//
//  AlamofireImage.swift
//  DexgoHousekeeping
//
//  Created by Apple on 13/07/22.
//

import UIKit
import AlamofireImage
extension UIImageView {
    func setImageWithUrl(_ urlString: String, placeHolderImage image: UIImage?) {
        if let url = URL(string: urlString), url.host != nil && url.scheme != nil {
            self.af_setImage(withURL: url, placeholderImage: image)
        }
    }
    func setRenderImageWithUrl(_ urlString: String, placeHolderImage image: UIImage?) {
        if let url = URL(string: urlString), url.host != nil && url.scheme != nil {
            let filterValue = DynamicImageFilter("TemplateImageFilter") { image in
                return image.withRenderingMode(.alwaysTemplate)
            }
            self.af_setImage(withURL: url, placeholderImage: image, filter:filterValue)
        }
    }
    func rotated(angle: Int) {
        self.transform = CGAffineTransform(rotationAngle: angle.degreesToRadians.cgFloat);
    }
}

