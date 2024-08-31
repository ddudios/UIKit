//
//  Observable.swift
//  BasicMusic
//
//  Created by Suji Jang on 8/30/24.
//

import Foundation

class 클래스로감싸진데이터<T> {
    
    // 값이 변할때마다 "나중에호출될수있는함수"(클로저/함수) 호출
    var 데이터값: T {
        didSet {
            나중에호출될수있는함수?(데이터값)
        }
    }
    
    // "데이터값"이 변할때 => 함수호출
    var 나중에호출될수있는함수: ((T) -> Void)?
    
    init(_ 값: T) {
        self.데이터값 = 값
    }
    
    // 클로저를 input으로 받아서 단순히 할당하는 메서드
    // 저장속성에 직접적으로 클로저를 할당해도되는데
    // 일반적으로 아예 메서드를 만들어놓고 쓰기도 한다
    func 바인딩하기(콜백함수: @escaping (T) -> Void) {
        self.나중에호출될수있는함수 = 콜백함수
    }
}
