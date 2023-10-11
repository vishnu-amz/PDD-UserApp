//
//  UIImageView+.swift
//  UserApp
//
//  Created by Vishnu - iOS on 11/10/23.
//

import Foundation
import Kingfisher

extension UIImageView {
    
    // display image
    func setImage(withURL url: URL?, placeholder: UIImage? = nil, completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil) {
        self.kf.setImage(with: url, placeholder: placeholder, completionHandler: completionHandler)
    }
}
