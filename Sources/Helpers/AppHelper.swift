//
//  AppHelper.swift
//  VIPTemplate
//
//  Created by The Son    on 10/30/17.
//  Copyright © 2017 Savvycom. All rights reserved.
//

import UIKit
import Photos

class AppHelper: NSObject {
    class func openURL(url: URL) {
        if UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }

     class func getAssetImage(asset: PHAsset) -> UIImage {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        option.isSynchronous = true
        option.isNetworkAccessAllowed = true
        var thumbnail = UIImage()
        manager.requestImage(for: asset, targetSize: CGSize(width: 720, height: 1024), contentMode: .aspectFit, options: option, resultHandler: { result, _ -> Void in
            if let res = result {
                thumbnail = res
            }
        })

        return thumbnail
    }
}

