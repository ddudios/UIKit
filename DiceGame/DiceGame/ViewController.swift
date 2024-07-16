//
//  ViewController.swift
//  DiceGame
//
//  Created by Suji Jang on 7/16/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var secondImageView: UIImageView!
    
    // 주사위 이미지 배열
    var diceArray: [UIImage] = [#imageLiteral(resourceName: "black1"), #imageLiteral(resourceName: "black2"), #imageLiteral(resourceName: "black3"), #imageLiteral(resourceName: "black4"), #imageLiteral(resourceName: "black5"), #imageLiteral(resourceName: "black6")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstImageView.image = diceArray[0]
        secondImageView.image = diceArray[0]
    }

    @IBAction func rollButtonTapped(_ sender: UIButton) {
        // 첫번째 이미지뷰의 이미지를 랜덤으로 변경
        firstImageView.image = diceArray.randomElement()
        
        // 두번째 이미지뷰의 이미지를 랜덤으로 변경
        secondImageView.image = diceArray.randomElement()
    }
}

