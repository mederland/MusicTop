//
//  UIStackViewExtention.swift
//  MusicTop
//
//  Created by Consultant on 7/24/22.
//

import UIKit

extension UIStackView {
    convenience init(axis: NSLayoutConstraint.Axis, spacing: CGFloat, distribution: Distribution ) {
        self.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .black
        self.axis = axis
        self.spacing = spacing
        self.distribution = distribution
    }
}
