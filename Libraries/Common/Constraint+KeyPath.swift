//
//  Constraint+KeyPath.swift
//  bms
//
//  Created by HuyNguyen on 11/2/18.
//  Copyright © 2018 Savvycom. All rights reserved.
//

import UIKit


///MARK: Example:
/**
 *
     self.contentView.addSubview(self.imgvIcon, constraints: [
         equal(\.widthAnchor, constant: 24),
         equal(\.heightAnchor, constant: 24),
         equal(\.centerYAnchor),
         equal(\.leadingAnchor, constant: 24)
     ])
 
 equivalent:
 
    self.imgvIcon.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, constant:).isActive = true
 *
 *
 *
 */

typealias Constraint = (UIView, UIView) -> NSLayoutConstraint

func equal<L, Axis>(_ from: KeyPath<UIView, L>, _ to: KeyPath<UIView, L>, constant: CGFloat = 0) -> Constraint where L: NSLayoutAnchor<Axis> {
    return { view1, view2 in
        view1[keyPath: from].constraint(equalTo: view2[keyPath: to], constant: constant)
    }
}
func equal<L, Axis>(_ to: KeyPath<UIView, L>, constant: CGFloat = 0) -> Constraint where L: NSLayoutAnchor<Axis> {
    return equal(to, to, constant: constant)
}


func equal<L>(_ keyPath: KeyPath<UIView, L>, constant: CGFloat) -> Constraint where L: NSLayoutDimension {
    return { view1, _ in
        view1[keyPath: keyPath].constraint(equalToConstant: constant)
    }
}


extension UIView {
    func addSubview(_ other: UIView, constraints: [Constraint]) {
        other.translatesAutoresizingMaskIntoConstraints = false
        addSubview(other)
        addConstraints(constraints.map { $0(other, self) })
    }
}
