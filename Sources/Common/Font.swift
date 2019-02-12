//
//  Font.swift
//  VIPTemplate
//
//  Created by Tue Nguyen on 4/14/16.
//  Copyright © 2016 Savvycom. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    class func applicationFont(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Helvetica", size: size)!
    }
    class func boldApplicationFont(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Helvetica-Bolt", size: size)!
    }
    
    class func lightApplicationFont(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Helvetica-Light", size: size)!
    }
    
    class func italicApplicationFont(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Helvetica-Italic", size: size)!
    }
    
    class func robotoMediumItalicFont(_ size: CGFloat = 12) -> UIFont {
        return UIFont(name: "Roboto-MediumItalic", size: size)!
    }
    
    class func robotoMediumFont(_ size: CGFloat = 12) -> UIFont {
        return UIFont(name: "Roboto-Medium", size: size)!
    }
    
    class func robotoRegularFont(_ size: CGFloat = 12) -> UIFont {
        return UIFont(name: "Roboto-Regular", size: size)!
    }
    
    class func robotoBoldFont(_ size: CGFloat = 12) -> UIFont {
        return UIFont(name: "Roboto-Bold", size: size)!
    }
}

extension UIFont {
    
    func withTraits(_ traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        
        // create a new font descriptor with the given traits
        if let fd = fontDescriptor.withSymbolicTraits(traits) {
            // return a new font with the created font descriptor
            return UIFont(descriptor: fd, size: pointSize)
        }
        
        // the given traits couldn't be applied, return self
        return self
    }
    
    func italics() -> UIFont {
        return withTraits(.traitItalic)
    }
    
    func bold() -> UIFont {
        return withTraits(.traitBold)
    }
    
    func boldItalics() -> UIFont {
        return withTraits([ .traitBold, .traitItalic ])
    }
}
