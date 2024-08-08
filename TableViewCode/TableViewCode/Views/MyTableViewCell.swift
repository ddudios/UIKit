//
//  MyTableViewCell.swift
//  TableViewCode
//
//  Created by Suji Jang on 8/8/24.
//

import UIKit

final class MyTableViewCell: UITableViewCell {
    
    let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let movieNameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.numberOfLines = 0  // 무한 줄 허용
        return label
    }()
    
    let labelStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fill
        sv.alignment = .fill
        sv.spacing = 8
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupStackView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 셀 위에 올리기
    func setupStackView() {
        self.contentView.addSubview(mainImageView)
        self.contentView.addSubview(labelStackView)
        labelStackView.addArrangedSubview(movieNameLabel)
        labelStackView.addArrangedSubview(descriptionLabel)
    }
    
    // 셀 위에 오토레이아웃
    func setConstraints() {
        setMainImageViewConstraints()
        setMovieNameLabelConstraints()
        setLabelStackViewConstraints()
    }
    
    // 셀은 기본뷰로 contentView를 가지고 있음
    
    func setMainImageViewConstraints() {
        NSLayoutConstraint.activate([
            mainImageView.heightAnchor.constraint(equalToConstant: 100),
            mainImageView.widthAnchor.constraint(equalToConstant: 100),
            mainImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            mainImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        ])
    }
    
    func setMovieNameLabelConstraints() {
        NSLayoutConstraint.activate([
            movieNameLabel.heightAnchor.constraint(equalToConstant: 22)
        ])
    }
    
    func setLabelStackViewConstraints() {
        NSLayoutConstraint.activate([
            labelStackView.leadingAnchor.constraint(equalTo: mainImageView.trailingAnchor, constant: 15),
            labelStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            labelStackView.topAnchor.constraint(equalTo: self.mainImageView.topAnchor),
            labelStackView.bottomAnchor.constraint(equalTo: self.mainImageView.bottomAnchor)
        ])
    }
}
