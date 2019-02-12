//
//  ColorSchema.swift
//  VIPTemplate
//
//  Created by Tue Nguyen on 4/15/16.
//  Copyright © 2016 Savvycom. All rights reserved.
//

import Foundation
import UIKit
//This class to setup color schema for the app
struct ColorSchema {
    fileprivate init() {
        
    }
    
    static func mainColor() -> UIColor {
        return UIColor.orange;
    }
    
    static func blueColor() -> UIColor {
        return UIColor.blue
    }
}


// Color palette

extension UIColor {
    @nonobjc class var svDenimBlue: UIColor {
        return UIColor(red: 59.0 / 255.0, green: 89.0 / 255.0, blue: 152.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var svCoolGrey: UIColor {
        return UIColor(red: 144.0 / 255.0, green: 147.0 / 255.0, blue: 152.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var svCharcoalGrey: UIColor {
        return UIColor(white: 74.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var svSlateGrey: UIColor {
        return UIColor(red: 96.0 / 255.0, green: 103.0 / 255.0, blue: 113.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var svWarmPink: UIColor {
        return UIColor(red: 241.0 / 255.0, green: 82.0 / 255.0, blue: 104.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var svWhite: UIColor {
        return UIColor(white: 210.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var svDarkSkyBlue: UIColor {
        return UIColor(red: 53.0 / 255.0, green: 119.0 / 255.0, blue: 229.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var svWarmGrey: UIColor {
        return UIColor(white: 151.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var svScarlet: UIColor {
        return UIColor(red: 208.0 / 255.0, green: 2.0 / 255.0, blue: 27.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var svPinkishGrey50: UIColor {
        return UIColor(white: 198.0 / 255.0, alpha: 0.5)
    }

}

extension UIColor {
    var toHexString: String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        return String(
            format: "%02X%02X%02X",
            Int(r * 0xff),
            Int(g * 0xff),
            Int(b * 0xff)
        )
    }
}

