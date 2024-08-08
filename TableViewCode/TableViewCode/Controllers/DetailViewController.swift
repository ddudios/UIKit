//
//  DetailViewController.swift
//  TableViewCode
//
//  Created by Suji Jang on 8/8/24.
//

import UIKit

final class DetailViewController: UIViewController {
    
    private let detailView = DetailView()
    var movieData: Movie?
    
    // 뷰 할당
    override func loadView() {
        view = detailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        detailView.movieImageView.image = movieData?.movieImage
        detailView.movieNameLabel.text = movieData?.movieName
        detailView.descriptionLabel.text = movieData?.movieDescription
    }
}
