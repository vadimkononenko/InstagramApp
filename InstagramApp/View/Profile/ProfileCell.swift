//
//  ProfileCell.swift
//  InstagramApp
//
//  Created by Vadim Kononenko on 24.07.2023.
//

import UIKit
import SnapKit

class ProfileCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private let postImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "venom-7")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Configuration

extension ProfileCell {
    
    private func configure() {
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        addSubview(postImageView)
    }
    
    private func setupConstraints() {
        postImageView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalToSuperview()
        }
    }
    
}
