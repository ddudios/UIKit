//
//  FirstPageViewController.swift
//  LoginMVVM
//
//  Created by Suji Jang on 9/1/24.
//

import UIKit

final class FirstPageViewController: UIViewController {
    
    let viewModel: FirstPageViewModel
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.textColor = .gray
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let userEmailLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var emailStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [emailLabel, userEmailLabel])
        sv.axis = .vertical
        sv.distribution = .fill
        sv.alignment = .leading
        sv.spacing = 5
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Logout", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.setTitleColor(.gray, for: .normal)
        button.backgroundColor = .clear
        button.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(viewModel: FirstPageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupAutoLayout()
        setupAddTargets()
    }
    
    func configureUI() {
        self.view.backgroundColor = .white
        userEmailLabel.text = viewModel.userEmailString
    }
    
    func setupAutoLayout() {
        self.view.addSubview(emailStackView)
        self.view.addSubview(logoutButton)
        
        NSLayoutConstraint.activate([
            emailStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 40),
            emailStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            emailStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
            
            logoutButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            logoutButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            logoutButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
            logoutButton.heightAnchor.constraint(equalToConstant: 48),
            logoutButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -40)
        ])
    }
    
    func setupAddTargets() {
        self.logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
    }
    
    @objc func logoutButtonTapped() {
        viewModel.logoutAlert(fromCurrentVC: self)
    }
}
