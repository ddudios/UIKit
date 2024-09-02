//
//  Observable.swift
//  LoginMVVM
//
//  Created by Suji Jang on 9/1/24.
//

import Foundation

// 데이터가 변할때마다 -> 뷰를 다시 그릴 수 있다
class Observable<T> {
    // 관찰대상의 변화에따라 반응하는 것들
    // 나중에호출될수있는함수들의 배열
    private var listeners: [(T) -> Void] = []
    
    // 관찰 중인 값(관찰대상)의 변경을 알림
    // 값이 변할때마다 나중에호출될수있는함수를 호출
    var value: T {
        didSet {
            // 값이 변경될 때마다 모든 리스너들에게 알림
            // 나중에호출될수있는함수?(데이터값)
            listeners.forEach { $0(value) }
        }
    }
    
    // 초기화 시 값 설정
    init(_ value: T) {
        self.value = value
    }
    
    // 데이터값이 변할때 => 나중에호출될수있는함수 호출
    // var 나중에호출될수있는함수: ((T) -> Void)?
    func bind(listener: @escaping (T) -> Void) {
        listener(value)  // 초기값에 대해 리스너를 호출
        listeners.append(listener)  // 리스너 추가
    }
}
