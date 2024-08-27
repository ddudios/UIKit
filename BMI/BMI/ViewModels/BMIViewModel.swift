//
//  BMIViewModel.swift
//  BMI
//
//  Created by Suji Jang on 8/27/24.
//

import UIKit

// 열거형 타입으로 제대로 입력됐을때/제대로 입력되지 않았을때를 구분
// 유효성 검사
enum ValidationText: String {
    case right = "키와 몸무게를 입력해 주세요"
    case notRight = "키와 몸무게를 입력해야 합니다!"
    
    var textColor: UIColor {
        switch self {
        case .right:
            return .black
        case .notRight:
            return .red
        }
    }
}

final class BMIViewModel {
    
    // 뷰모델이 BMICalculator모델을 소유
    // BMI 결과값을 받아오는 로직을 가지고 있음
    var logicManager: CalculatorType
    
    // MARK: - 뷰를 위한 데이터
    
    private var mainText: ValidationText = .right
    
    // 뷰와 연관된 1:1매칭 데이터로서 뷰와 유사한 형태인 문자열로 가지게 만듦
    // -> 문자열을 숫자로 바꾸는 로직은 BMI모델에서 구현
    private var heightString: String = ""
    private var weightString: String = ""
    
    // BMI 데이터 모델
    var bmi: BMI?
    
    // MARK: - Output
    
    var mainTextString: String? {
        return mainText.rawValue
    }
    
    var mainLabelTextColor: UIColor? {
        return mainText.textColor
    }
    
    var bmiNumberString: String {
        return String(bmi?.value ?? 0.0)
    }
    
    var bmiAdviceString: String {
        return bmi?.advice ?? ""
    }
    
    var bmiColor: UIColor {
        return bmi?.matchColor ?? .white
    }
    
    init(logicManager: CalculatorType) {
        self.logicManager = logicManager
    }

    
    // MARK: - Input
    
    // 키가 입력될때마다 호출되는 메서드
    func setHeightTextField(_ height: String) {
        self.heightString = height
    }
    
    func setWeightTextField(_ weight: String) {
        self.weightString = weight
    }
    
    // 버튼이 눌렸을때 BMI 계산 결과가 있으면 다음화면으로 이동
    func handleButtonTapped(storyboard: UIStoryboard?, fromCurrentVC: UIViewController, animated: Bool) {
        
        // BMI계산하는 로직 실행
        if self.makeBMI() {
            heightString = ""
            weightString = ""
            goToNextVC(storyboard: storyboard, fromeCurrentVC: fromCurrentVC, animated: animated)
        } else {
            print("다음화면으로 이동 불가")
        }
    }
    
    // MARK: - Logic
    
    // 제대로 계산 -> 참
    private func makeBMI() -> Bool {
        do {
            bmi = try logicManager.calculateBMI(height: self.heightString, weight: self.weightString)
            return true
        } catch {
            let er = error as! CalculateError
            switch er {
            case .minusNumberError:
                print("마이너스 숫자 입력")
            case .noNumberError:
                print("숫자가 아닌 글자 입력")
            default:
                break
            }
            mainText = .notRight
            return false
        }
    }
    
    func resetBMI() {
        heightString = ""
        weightString = ""
        
        bmi = nil
            mainText = .right
    }
    
    // 다음화면으로 이동
    // 내부의 present메서드는 UIViewController를 상속받은 클래스에서만 호출할 수 있다
    private func goToNextVC(storyboard: UIStoryboard?, fromeCurrentVC: UIViewController, animated: Bool) {
        
        // 스토리보드 생성 + 커스텀 생성자
        // 다음화면으로 이동하려면 뷰컨트롤러 인스턴스 생성해야하는데 뷰모델에서 직접적으로 생성할 수 없으니까 뷰컨트롤러로부터 스토리보드를 전달받는다
        // 외부에서 주입하고 싶으면 creator파라미터가 들어간 메서드 호출
        
        guard let secondVC = storyboard?.instantiateViewController(identifier: "SecondViewController", creator: { coder in
            SecondViewController(coder: coder, viewModel: self)
        }) else {
            fatalError("SecondViewController 생성 에러")
        }
        secondVC.modalPresentationStyle = .fullScreen
        
        // UIViewController를 상속한 타입을 전달받아서 present 가능
        fromeCurrentVC.present(secondVC, animated: true, completion: nil)
    }
}
