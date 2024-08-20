//
//  MyColor.swift
//  ToDoApp
//
//  Created by Suji Jang on 8/20/24.
//

import UIKit

// 코어데이터 저장 타입을 Int64로 설정했기 때문에 타입변환을 하지 않고 편하게 사용하기 위해서 Int64로 선언
enum MyColor: Int64 {
    case red    = 1
    case green  = 2
    case blue   = 3
    case purple = 4
    
    // 계산속성 -> self는 enum타입의 인스턴스 자체에 접근
    // 연한 색상 (UIColor확장해서 16진법 사용)
    var viewColor: UIColor {
        switch self {
        case .red:
            return UIColor(hexString: "#EFD9D4")
            //return UIColor(red: 239/255, green: 217/255, blue: 212/255, alpha: 1)
        case .green:
            return UIColor(hexString: "#C2EDEA")
            //return UIColor(red: 194/255, green: 237/255, blue: 234/255, alpha: 1)
        case .blue:
            return UIColor(hexString: "#C4E4F2")
            //return UIColor(red: 196/255, green: 228/255, blue: 242/255, alpha: 1)
        case .purple:
            return UIColor(hexString: "#D4D4F5")
            //return UIColor(red: 212/255, green: 212/255, blue: 245/255, alpha: 1)
        }
    }
    
    // 진한 색상
    var buttonColor: UIColor {
        switch self {
        case .red:
            return UIColor(red: 232/255, green: 163/255, blue: 153/255, alpha: 1)
        case .green:
            return UIColor(red: 89/255, green: 190/255, blue: 183/255, alpha: 1)
        case .blue:
            return UIColor(red: 88/255, green: 181/255, blue: 236/255, alpha: 1)
        case .purple:
            return UIColor(red: 118/255, green: 103/255, blue: 228/255, alpha: 1)
        }
    }
}
