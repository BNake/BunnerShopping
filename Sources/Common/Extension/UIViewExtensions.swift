//
//  UIViewExtensions.swift
//  VIPTemplate
//
//  Created by Savvycom on 10/31/17.
//  Copyright © 2017 Savvycom. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    class func loadFromNib(named name: String, bundle: Bundle? = nil) -> UIView? {
        return UINib(nibName: name, bundle: bundle).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
    
    class func loadFromNib<T: UIView>() -> T {
        let nibName = "\(self)".split { $0 == "." }.map(String.init).last!
        let nib = UINib(nibName: nibName, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as! T
    }
    
    class func nib(_ bundle: Bundle? = nil) -> UINib? {
        return UINib(nibName: self.nibName(), bundle: bundle)
    }
    
    private static func nibName() -> String {
        let nameSpaceClassName = NSStringFromClass(self)
        let className = nameSpaceClassName.components(separatedBy: ".").last! as String
        return className
    }
    
    func border(borderWidth:CGFloat, cornerRadius:CGFloat, borderColor:UIColor) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }
    
    func circleBorder() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.size.height/2
    }
}

extension UIView {
    
    func dropShadow(scale: Bool = true) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowRadius = 1
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offSet
        self.layer.shadowRadius = radius
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

extension UIScrollView {
    func scrollToBottom() {
        self.layoutSubviews()
        let offsetY = (contentSize.height - bounds.size.height + contentInset.bottom - contentInset.top)
        if (offsetY > 0) {
            let bottomOffset = CGPoint(x: 0, y: offsetY)
            setContentOffset(bottomOffset, animated: true)
        }
    }
}

extension UITableView {
    func scrollToBottom(animated: Bool = true) {
        let sections = self.numberOfSections
        let rows = self.numberOfRows(inSection: max(0, sections-1))
        if (rows > 0 && sections > 0){
            self.scrollToRow(at: IndexPath.init(row: (rows-1), section: (sections-1)), at: .bottom, animated: true)
        }
    }
}
