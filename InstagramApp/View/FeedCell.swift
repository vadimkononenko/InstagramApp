//
//  FeedCell.swift
//  InstagramApp
//
//  Created by Vadim Kononenko on 22.07.2023.
//

import UIKit
import SnapKit

class FeedCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.image = UIImage(named: "venom-7")
        iv.layer.cornerRadius = 40 / 2
        return iv
    }()
    
    private lazy var usernameBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("venom", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 13)
        btn.addTarget(self, action: #selector(didTapUsername), for: .touchUpInside)
        return btn
    }()
    
    /// horizontal stack for: profileImageView + usernameBtn
    private let userInfoStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 8
        return stack
    }()
    
    private let postImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "venom-7")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    private lazy var likeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "like_unselected"), for: .normal)
        btn.tintColor = .black
        return btn
    }()
    
    private lazy var commentBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "comment"), for: .normal)
        btn.tintColor = .black
        return btn
    }()
    
    private lazy var shareBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "send2"), for: .normal)
        btn.tintColor = .black
        return btn
    }()
    
    /// horizontal stack for: likeBtn + commentBtn + shareBtn
    private let postActionsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let likesLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "1 like"
        lbl.font = .boldSystemFont(ofSize: 13)
        return lbl
    }()
    
    private let captionLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Some text caption for now.."
        lbl.font = .systemFont(ofSize: 14)
        return lbl
    }()
    
    private let postTimeLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "2 days ago"
        lbl.font = .systemFont(ofSize: 12)
        lbl.textColor = .lightGray
        return lbl
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    @objc private func didTapUsername() {
        print("Tapped")
    }
    
}

// MARK: - Constraints

extension FeedCell {
    
    private func configure() {
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {        
        // userInfoStackView
        addSubview(userInfoStackView)
        userInfoStackView.addArrangedSubview(profileImageView)
        userInfoStackView.addArrangedSubview(usernameBtn)
        
        addSubview(postImageView)
        
        // postActionsStackView
        addSubview(postActionsStackView)
        postActionsStackView.addArrangedSubview(likeBtn)
        postActionsStackView.addArrangedSubview(commentBtn)
        postActionsStackView.addArrangedSubview(shareBtn)
        
        addSubview(likesLabel)
        addSubview(captionLabel)
        addSubview(postTimeLabel)
    }
    
    private func setupConstraints() {
        userInfoStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(12)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.height.width.equalTo(40)
        }
        
        postImageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(userInfoStackView.snp.bottom).offset(8)
            make.height.equalTo(contentView.snp.width)
        }
        
        postActionsStackView.snp.makeConstraints { make in
            make.top.equalTo(postImageView.snp.bottom)
            make.width.equalTo(120)
            make.height.equalTo(50)
        }
        
        likesLabel.snp.makeConstraints { make in
            make.top.equalTo(postActionsStackView.snp.bottom).offset(-4)
            make.leading.equalToSuperview().offset(8)
        }
        
        captionLabel.snp.makeConstraints { make in
            make.top.equalTo(likesLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(8)
        }
        
        postTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(captionLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(8)
        }
    }
    
}
