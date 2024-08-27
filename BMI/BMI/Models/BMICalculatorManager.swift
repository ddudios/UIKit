//
//  BMICalculatorManager.swift
//  BMI
//
//  Created by Suji Jang on 7/31/24.
//

import UIKit

enum CalculateError: Error {
    case noNumberError
    case minusNumberError
    case notAnError
}

// 의존성을 주입할 수 있게 프로토콜로 작성 -> 확장성
protocol CalculatorType {
    func calculateBMI(height: String, weight: String) throws -> BMI
}

// 비즈니스 로직 담당
// BMI계산과 관련된 로직만 담당 - Domain 로직
struct BMICalculatorManager: CalculatorType {
    
    // BMI만들기 메서드: BMI수치 계산해서 BMI리턴
    // 디테일하게 만들기 위해서 에러를 던질 수 있게 만들었다
    // 에러를 던질 수 있는 함수로 구현하면 제대로된 경우에는 BMI를 리턴하고
    // BMI계산할 수 없는 경우 중에서 디테일한 에러 발생 코드를 던질 수 있다
    func calculateBMI(height: String, weight: String) throws -> BMI {
        
        // 문자열을 숫자로 변환
        guard let h = Double(height), let w = Double(weight) else {
            throw CalculateError.noNumberError
        }
        
        // 0이상인지 확인
        guard h > 0, w > 0 else {
            throw CalculateError.minusNumberError
        }
        
        // BMI 계산
        var bmiNumber = w / (h * h) * 10000
        bmiNumber = round(bmiNumber * 10) / 10
        
        switch bmiNumber {
        case ..<18.6:
            let color = UIColor(displayP3Red: 22/255, green: 231/255, blue: 207/255, alpha: 1)
            return BMI(value: bmiNumber, advice: "저체중", matchColor: color)
        case 18.6..<23.0:
            let color = UIColor(displayP3Red: 212/255, green: 251/255, blue: 121/255, alpha: 1)
            return BMI(value: bmiNumber, advice: "표준", matchColor: color)
        case 23.0..<25.0:
            let color = UIColor(displayP3Red: 218/255, green: 127/255, blue: 163/255, alpha: 1)
            return BMI(value: bmiNumber, advice: "과체중", matchColor: color)
        case 25.0..<30.0:
            let color = UIColor(displayP3Red: 255/255, green: 150/255, blue: 141/255, alpha: 1)
            return BMI(value: bmiNumber, advice: "중도비만", matchColor: color)
        case 30.0...:
            let color = UIColor(displayP3Red: 255/255, green: 100/255, blue: 78/255, alpha: 1)
            return BMI(value: bmiNumber, advice: "고도비만", matchColor: color)
        default:
            return BMI(value: 0.0, advice: "문제: \(#function)", matchColor: .black)
        }
    }
}
