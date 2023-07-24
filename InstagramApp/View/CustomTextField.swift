//
//  CustomTextField.swift
//  InstagramApp
//
//  Created by Vadim Kononenko on 23.07.2023.
//

import UIKit
import SnapKit

class CustomTextField: UITextField {

    init(placeholder: String) {
        super.init(frame: .zero)
        
        let spacer = UIView()
        spacer.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(12)
        }
        leftView = spacer
        leftViewMode = .always
        
        borderStyle = .none
        textColor = .white
        keyboardAppearance = .dark
        backgroundColor = UIColor(white: 1, alpha: 0.1)
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor(white: 1, alpha: 0.7)])
        layer.cornerRadius = 5
        autocapitalizationType = .none
        autocorrectionType = .no
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
