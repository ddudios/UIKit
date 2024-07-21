//
//  ViewController.swift
//  FirstNewApp
//
//  Created by Suji Jang on 7/21/24.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    weak var timer: Timer?
    var number = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    func configureUI() {
        mainLabel.text = "초를 선택하세요"
        
        // slider 가운데 설정
        slider.value = 0.5
    }

    @IBAction func sliderChanged(_ sender: UISlider) {
        // slider의 value값을 가지고 MainLabel의 text를 세팅
        number = Int(sender.value * 60)
        mainLabel.text = "\(number) 초"
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        // 타이머: 초가 지나갈 때마다 실행
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { [self] _ in
            // 반복하고 싶은 코드
            if number > 0 {
                number -= 1
                slider.value = Float(number) / Float(60)
                mainLabel.text = "\(number) 초"
            } else if number == 0 {
                mainLabel.text = "초를 선택하세요"
                timer?.invalidate()
                // 소리
                AudioServicesPlayAlertSound(SystemSoundID(1322))
            } else {
                timer?.invalidate()
            }
        })
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        // 초기화 세팅
        mainLabel.text = "초를 선택하세요"
        slider.setValue(0.5, animated: true)
        number = -1
        timer = nil
    }
}
