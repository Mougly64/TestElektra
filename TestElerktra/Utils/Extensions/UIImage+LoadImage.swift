//
//  UIImage+LoadImage.swift
//  TestElerktra
//
//  Created by Luan Road on 02/02/22.
//

import UIKit
 
extension UIImageView {
    
    /// method who get the image from an url
    /// - Parameter url: url from the image
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
