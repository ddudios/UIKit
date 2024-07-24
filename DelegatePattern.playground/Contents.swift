import UIKit

protocol TextFieldDelegate {
    func textFieldDidBeginEdigint()
    func textFieldShouldReturn(textField: String) -> Bool
}

class TextField {
    var delegate: TextFieldDelegate?
    
    func type() {
        delegate?.textFieldDidBeginEdigint()
    }
    
    func enter(contents: String) {
        guard let returnValue = delegate?.textFieldShouldReturn(textField: contents) else { return }
        if returnValue {
            print("엔터키 사용 가능")
        } else {
            print("엔터키 사용 불가")
        }
    }
}

class ViewController: TextFieldDelegate {
    init(textField: TextField) {
        textField.delegate = self
    }
    
    func textFieldDidBeginEdigint() {
        print("유저가 텍스트필드에 입력을 시작했다")
    }
    
    func textFieldShouldReturn(textField: String) -> Bool {
        if textField == "" {
            return false
        } else {
            return true
        }
    }
}

class Website: TextFieldDelegate {
    func textFieldDidBeginEdigint() {
        print("유저가 검색창에 입력을 시작했다")
    }
    
    func textFieldShouldReturn(textField: String) -> Bool {
        if textField == "" {
            print("검색어를 입력하세요")
            return false
        } else {
            print("검색 결과")
            return true
        }
    }
}

let textField = TextField()
let myViewController = ViewController(textField: textField)

let searchBar = TextField()
let website = Website()
searchBar.delegate = website
//textField.delegate = website

textField.type()
textField.enter(contents: "")
// 유저가 텍스트필드에 입력을 시작했다
// 엔터키 사용 불가

// textField의 delegate를 website로 변경하면
// 유저가 검색창에 입력을 시작했다
// 검색어를 입력하세요
// 엔터키 사용 불가

searchBar.type()
searchBar.enter(contents: "검색어")
// 유저가 검색창에 입력을 시작했다
// 검색 결과
// 엔터키 사용 가능


// protocol을 통하지 않고 객체끼리 소통하게 만들 수도 있다
class CustomTextField {
    var delegate: CustomViewController?
    
    func type() {
        delegate?.textFieldDidBeginEdigint()
    }
    
    func enter(contents: String) {
        guard let returnValue = delegate?.textFieldShouldReturn(textField: contents) else { return }
        if returnValue {
            print("엔터키 사용 가능")
        } else {
            print("엔터키 사용 불가")
        }
    }
}

class CustomViewController {
    func textFieldDidBeginEdigint() {
        print("유저가 텍스트필드에 입력을 시작했다")
    }
    
    func textFieldShouldReturn(textField: String) -> Bool {
        if textField == "" {
            return false
        } else {
            return true
        }
    }
}

let customTextField = CustomTextField()
let customViewController = CustomViewController()
customTextField.delegate = customViewController

customTextField.type()
// 유저가 텍스트필드에 입력을 시작했다
