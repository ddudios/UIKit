//
//  ViewController.swift
//  ToDoApp
//
//  Created by Suji Jang on 8/18/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    // 모델(저장 데이터를 관리하는 코어데이터)
    let toDoManager = CoreDataManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
    }
    
    // 화면에 다시 진입할때마다 테이블뷰 리로드
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    func setupNavigationBar() {
        self.title = "메모"
        
        // +버튼 생성: UIBarButton으로 만들어서 할당
        let plusButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plusButtonTapped))
        plusButton.tintColor = .black
        navigationItem.rightBarButtonItem = plusButton
    }

    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        // 테이블뷰의 선 없애기
        tableView.separatorStyle = .none
    }
    
    @objc func plusButtonTapped() {
        performSegue(withIdentifier: "ToDetailView", sender: nil)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoManager.getToDoListFromCoreData().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as! ToDoCell
        
        // 셀에 모델(ToDoData) 전달
        // 투두매니저한테 요청해서 배열을 가져온 다음에 배열에서 인덱스패스값을 확인해서 셀한테 전달
        // 그러면 셀은 표현하고싶은 투두데이터를 받아서 셀에다가 표시
        let toDoDataArray = toDoManager.getToDoListFromCoreData()
        cell.toDoData = toDoDataArray[indexPath.row]
        
        // 셀위에 있는 버튼이 눌렸을때 뷰컨트롤러에서 동작하기위해서 클로저 전달
        cell.updateButtonPressed = { [weak self] (senderCell) in
            self?.performSegue(withIdentifier: "ToDetailView", sender: indexPath)
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    // 세그웨이를 실행할 때 실제 데이터 전달 (ToDoData 전달)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToDetailView" {
            let detailVC = segue.destination as! DetailViewController
            
            guard let indexPath = sender as? IndexPath else { return }
            detailVC.toDoData = toDoManager.getToDoListFromCoreData()[indexPath.row]
        }
    }
}

extension ViewController: UITableViewDelegate {
    
    // 테이블뷰의 높이를 자동으로 추정하는 메서드
    // ToDo에서 메세지가 길때는 셀의 높이를 더 높게 => 셀의 오토레이아웃 설정도 필요
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
