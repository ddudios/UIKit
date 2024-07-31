//
//  BMICalculatorManager.swift
//  BMI
//
//  Created by Suji Jang on 7/31/24.
//

import UIKit

struct BMICalculatorManager {
    
    // BMI계산 결과값 보관할 변수
    private var bmi: BMI?
    
    // BMI 계산
    mutating private func calculateBMI(height: String, weight: String) {
        guard let h = Double(height), let w = Double(weight) else {
            bmi = BMI(value: 0.0, advice: "문제: \(#function)", matchColor: UIColor.white)
            return
        }
        
        var bmiNumber = w / (h * h) * 10000
        bmiNumber = round(bmiNumber * 10) / 10
        
        switch bmiNumber {
        case ..<18.6:
            let color = UIColor(displayP3Red: 22/255, green: 231/255, blue: 207/255, alpha: 1)
            return bmi = BMI(value: bmiNumber, advice: "저체중", matchColor: color)
        case 18.6..<23.0:
            let color = UIColor(displayP3Red: 212/255, green: 251/255, blue: 121/255, alpha: 1)
            return bmi = BMI(value: bmiNumber, advice: "표준", matchColor: color)
        case 23.0..<25.0:
            let color = UIColor(displayP3Red: 218/255, green: 127/255, blue: 163/255, alpha: 1)
            return bmi = BMI(value: bmiNumber, advice: "과체중", matchColor: color)
        case 25.0..<30.0:
            let color = UIColor(displayP3Red: 255/255, green: 150/255, blue: 141/255, alpha: 1)
            return bmi = BMI(value: bmiNumber, advice: "중도비만", matchColor: color)
        case 30.0...:
            let color = UIColor(displayP3Red: 255/255, green: 100/255, blue: 78/255, alpha: 1)
            return bmi = BMI(value: bmiNumber, advice: "고도비만", matchColor: color)
        default:
            bmi = BMI(value: 0.0, advice: "문제: \(#function)", matchColor: .black)
        }
    }
    
    // BMI 얻기
    mutating func getBMI(height: String, weight: String) -> BMI {
        calculateBMI(height: height, weight: weight)
        return bmi ?? BMI(value: 0.0, advice: "문제: \(#function)", matchColor: UIColor.white)
    }
}
