//
//  MyTableViewCell.swift
//  MemberList
//
//  Created by Suji Jang on 8/10/24.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    
    // 멤버 저장속성 구현
    // 멤버를 가지는게 아니라
//    var member: Member? {
//        didSet {
//            guard var member else { return }
//            mainImageView.image = member.memberImage
//            memberNameLabel.text = member.name
//            addressLabel.text = member.address
//        }
//    }
    
    // MARK: - 뷰모델
    
    // 해당 뷰를 그릴 수 있는 뷰모델을 가진다
    var viewModel: MemberViewModel! {
        didSet {
            configureUI()
        }
    }
    
    // MARK: - UI 구현
    
    let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let memberNameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fill
        sv.alignment = .fill
        sv.spacing = 5
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    // MARK: - 생성자
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        setupConstraints()
//        mainImageView.image = member?.memberImage
//        memberNameLabel.text = member?.name
//        addressLabel.text = member?.address
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        self.contentView.addSubview(mainImageView)
        self.contentView.addSubview(labelStackView)
        labelStackView.addArrangedSubview(memberNameLabel)
        labelStackView.addArrangedSubview(addressLabel)
    }
    
    // MARK: - 오토레이아웃 셋팅
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            // contentView는 UITableViewCell의 하위 뷰로, 셀의 컨텐츠를 담는 주요 영역
            // 사용자 정의 컨텐츠(라벨, 이미지 등)를 추가할 때는 contentView에 추가하는 것이 일반적
            // 하지만, contentView의 높이와 위치는 셀의 전체 높이와 완전히 동일하지 않을 수 있다
            // self에 맞추면 이미지 뷰가 셀의 전체 중앙에 맞춰진다
            mainImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            mainImageView.heightAnchor.constraint(equalToConstant: 40),
            mainImageView.widthAnchor.constraint(equalToConstant: 40),
            
            
            memberNameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            labelStackView.leadingAnchor.constraint(equalTo: self.mainImageView.trailingAnchor, constant: 20),
            labelStackView.topAnchor.constraint(equalTo: self.mainImageView.topAnchor),
            labelStackView.bottomAnchor.constraint(equalTo: self.mainImageView.bottomAnchor)
        ])
    }
    
    // MARK: - 레이아웃 셋팅 (자동)
    
    // 프레임에 대한 넓이가 정확히 재계산되는 시점
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 이 시점에 정확한 프레임 넓이를 얻어서 이미지뷰 수정
        self.mainImageView.clipsToBounds = true
        self.mainImageView.layer.cornerRadius = self.mainImageView.frame.width / 2
    }
    
    // MARK: - 뷰모델을 가지고 뷰 셋팅
    func configureUI() {
        mainImageView.image = viewModel.memberImage
        memberNameLabel.text = viewModel.nameString
        addressLabel.text = viewModel.addressString
    }
}
