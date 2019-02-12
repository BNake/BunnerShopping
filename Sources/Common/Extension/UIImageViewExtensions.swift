//
//  UIImageViewExtensions.swift
//  VIPTemplate
//
//  Created by Savvycom on 11/2/17.
//  Copyright © 2017 Savvycom. All rights reserved.
//

import Kingfisher

extension UIImageView {
    func setImage(_ urlString: String, placeholder: UIImage? = nil, options: KingfisherOptionsInfo? = nil, progressBlock: DownloadProgressBlock? = nil, completionHandler: CompletionHandler? = nil) {
        if let urlEncode = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) {
            if let url = URL(string: urlEncode) {
                kf.setImage(with: url, placeholder: placeholder, options: options, progressBlock: progressBlock, completionHandler: completionHandler)
            } else {
                self.image = placeholder
            }
        } else {
            self.image = placeholder
        }
    }
}
