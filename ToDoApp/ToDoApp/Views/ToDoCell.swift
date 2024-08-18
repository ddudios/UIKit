//
//  ToDoCell.swift
//  ToDoApp
//
//  Created by Suji Jang on 8/18/24.
//

import UIKit

class ToDoCell: UITableViewCell {
    
    // TodoData를 전달받을 변수
    // ⭐️ 전달받으면 => 표시하는 메서드 실행
    // 데이터가 실제로 들어오면 속성감시자를 통해서 데이터 세팅
    var toDoData: ToDoData? {
        didSet {
            configureUIwithData()
        }
    }
    
    // (델리게이트 대신에) 실행하고싶은 클로저를 저장
    // updateButtonPressed를 실행하면
    // 뷰컨트롤러에서 전달된 클로저를 실행하는 방식으로 동작
    var updateButtonPressed: (ToDoCell) -> Void = { (sender) in }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureUIwithData() {
        
    }
    
    @IBAction func updateButtonTapped(_ sender: UIButton) {
        // ⭐️ 내 자신 ToDoCell을 전달하면서
        // 뷰컨트롤러에서 전달받은 클로저를 실행
        updateButtonPressed(self)
    }
    
}
