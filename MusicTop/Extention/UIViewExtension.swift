//
//  UIViewExtansion.swift
//  MusicTop
//
//  Created by Consultant on 7/24/22.
//

import UIKit

extension UIView {
    
    func bindToSuperview(insets: UIEdgeInsets = UIEdgeInsets(top: 1, left: 0, bottom: 0, right: 0)) {
        guard let superSafe = self.superview?.safeAreaLayoutGuide else {
            fatalError("Forgot to add the view to view hierarchy. FIX IT!")
        }
        self.backgroundColor = .black
        self.topAnchor.constraint(equalTo: superSafe.topAnchor, constant: insets.top).isActive = true
        self.leadingAnchor.constraint(equalTo: superSafe.leadingAnchor, constant: insets.left).isActive = true
        self.trailingAnchor.constraint(equalTo: superSafe.trailingAnchor, constant: -insets.right).isActive = true
        self.bottomAnchor.constraint(equalTo: superSafe.bottomAnchor, constant: -insets.bottom).isActive = true
    }
}
