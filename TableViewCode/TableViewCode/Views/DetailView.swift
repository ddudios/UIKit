//
//  DetailView.swift
//  TableViewCode
//
//  Created by Suji Jang on 8/8/24.
//

import UIKit

final class DetailView: UIView {
    
    let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let movieNameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fill
        sv.alignment = .fill
        sv.spacing = 15
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 뷰가 변하는 경우 오토레이아웃 재계산
    override func updateConstraints() {
        setConstraints()
        super.updateConstraints()
    }
    
    func setupStackView() {
        stackView.addArrangedSubview(movieImageView)
        stackView.addArrangedSubview(movieNameLabel)
        stackView.addArrangedSubview(descriptionLabel)
        
        self.addSubview(stackView)
    }
    
    func setConstraints() {
        setMovieImageViewConstraints()
        setMovieNameLabelContraints()
        setDescriptionLabelConstraints()
        setStackViewConstraints()
    }
    
    func setMovieImageViewConstraints() {
        NSLayoutConstraint.activate([
            movieImageView.heightAnchor.constraint(equalToConstant: 240)
        ])
    }
    
    func setMovieNameLabelContraints() {
        NSLayoutConstraint.activate([
            movieNameLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func setDescriptionLabelConstraints() {
        NSLayoutConstraint.activate([
            descriptionLabel.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func setStackViewConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 100),
            stackView.widthAnchor.constraint(equalToConstant: 240)
        ])
    }
}
