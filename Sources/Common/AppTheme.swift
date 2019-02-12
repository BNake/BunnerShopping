//
//  AppTheme.swift
//  VIPTemplate
//
//  Created by Tue Nguyen on 9/27/17.
//  Copyright © 2017 Savvycom. All rights reserved.
//

import UIKit

class AppTheme {
    static func applyGlobalStyle() {
        
        let appearance = UINavigationBar.appearance(whenContainedInInstancesOf: [UINavigationBar.self])
        appearance.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        appearance.shadowImage = UIImage(color: UIColor.svDarkSkyBlue)
        appearance.barTintColor = UIColor.svDenimBlue
        appearance.isTranslucent = false
        appearance.barStyle = .black
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                                          NSAttributedString.Key.strokeColor: UIColor.white,
                                          NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .medium)
        ]
        
        let backImage = UIImage(named: "")
        appearance.backIndicatorImage = backImage
        appearance.backIndicatorTransitionMaskImage = backImage
        appearance.tintColor = UIColor.white
        
        let appearanceImagePicker = UINavigationBar.appearance(whenContainedInInstancesOf: [UIImagePickerController.self])
        appearanceImagePicker.barTintColor = UIColor.svDenimBlue
        appearanceImagePicker.tintColor = UIColor.white
        appearanceImagePicker.isTranslucent = false
        appearanceImagePicker.barStyle = .black
        appearanceImagePicker.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                                                     NSAttributedString.Key.strokeColor: UIColor.white,
                                                     NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .medium)
                                         ]
        
        let tabbarAppearance = UITabBar.appearance()
        tabbarAppearance.tintColor = UIColor.clear
    }
}

