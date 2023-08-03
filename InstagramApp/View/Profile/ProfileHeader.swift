//
//  ProfileHeader.swift
//  InstagramApp
//
//  Created by Vadim Kononenko on 24.07.2023.
//

import UIKit
import SnapKit
import SDWebImage

class ProfileHeader: UICollectionReusableView {
    
    // MARK: - Properties
    
    var viewModel: ProfileHeaderViewModel? {
        didSet { configureViewModel() }
    }
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 80 / 2
        return iv
    }()
    
    private let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .boldSystemFont(ofSize: 14)
        return lbl
    }()
    
    private lazy var editProfileFollowBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Edit Profile", for: .normal)
        btn.layer.cornerRadius = 3
        btn.layer.borderColor = UIColor.lightGray.cgColor
        btn.layer.borderWidth = 0.5
        btn.titleLabel?.font = .boldSystemFont(ofSize: 14)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(handleEditProfileFollowTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var postsLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.attributedText = attributedStatText(value: 8, label: "posts")
        return lbl
    }()
    
    private lazy var followersLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.attributedText = attributedStatText(value: 2, label: "followers")
        return lbl
    }()
    
    private lazy var followingLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.attributedText = attributedStatText(value: 1, label: "following")
        return lbl
    }()
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        return stack
    }()
    
    private lazy var gridBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "grid"), for: .normal)
        return btn
    }()
    
    private lazy var listBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "list"), for: .normal)
        btn.tintColor = UIColor(white: 0, alpha: 0.2)
        return btn
    }()
    
    private lazy var bookmarkBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "ribbon"), for: .normal)
        btn.tintColor = UIColor(white: 0, alpha: 0.2)
        return btn
    }()
    
    private let topDivider: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let bottomDivider: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let buttonStackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        return stack
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc private func handleEditProfileFollowTapped() {
        
    }
    
    // MARK: - Helpers
    
    private func configureViewModel() {
        guard let viewModel = viewModel else { return }
        
        nameLabel.text = viewModel.fullname
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
    }
    
    private func attributedStatText(value: Int, label: String) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: "\(value)\n", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: label, attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.lightGray]))
        return attributedText
    }
    
}

// MARK: - Constraints

extension ProfileHeader {
    
    private func configure() {
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        backgroundColor = .white
        
        addSubview(profileImageView)
        addSubview(nameLabel)
        addSubview(editProfileFollowBtn)
        
        addSubview(stack)
        stack.addArrangedSubview(postsLabel)
        stack.addArrangedSubview(followersLabel)
        stack.addArrangedSubview(followingLabel)
        
        addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(gridBtn)
        buttonStackView.addArrangedSubview(listBtn)
        buttonStackView.addArrangedSubview(bookmarkBtn)
        
        addSubview(topDivider)
        addSubview(bottomDivider)
    }
    
    private func setupConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.top.equalToSuperview().offset(16)
            make.height.width.equalTo(80)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(12)
        }
        
        editProfileFollowBtn.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }
        
        stack.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView)
            make.leading.equalTo(profileImageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.height.equalTo(50)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.leading.bottom.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        topDivider.snp.makeConstraints { make in
            make.top.equalTo(buttonStackView.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        bottomDivider.snp.makeConstraints { make in
            make.top.equalTo(buttonStackView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
    
}
