//
//  Extentions.swift
//  InstagramApp
//
//  Created by Vadim Kononenko on 23.07.2023.
//

import UIKit

extension UIButton {
    
    func attributedTitle(firstPart: String, secondPart: String) {
        let attrs: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(white: 1, alpha: 0.87), .font: UIFont.systemFont(ofSize: 16)]
        
        let attributedTitle = NSMutableAttributedString(string: "\(firstPart) ", attributes: attrs)
        
        let boldAttrs: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(white: 1, alpha: 0.87), .font: UIFont.boldSystemFont(ofSize: 16)]
        attributedTitle.append(NSMutableAttributedString(string: secondPart, attributes: boldAttrs))
        
        setAttributedTitle(attributedTitle, for: .normal)
    }
    
}
