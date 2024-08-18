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
        
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoManager.getTodoListFormCoreData().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as! ToDoCell
        
        // 셀에 모델(ToDoData) 전달
        let toDoDataArray = toDoManager.getTodoListFormCoreData()
        cell.toDoData = toDoDataArray[indexPath.row]
        
        cell.selectionStyle = .none
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    // 셀 자체를 선택시 다음화면으로 이동하기위해 구현했던 방식
    // 셀을 선택시 실행되는 메서드
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // 세그웨이를 통한 화면이동
        performSegue(withIdentifier: "ToDoCell", sender: indexPath)
    }
    
    // 세그웨이를 실행할 때 실제 데이터 전달 (ToDoData 전달)
    // performSegue실행시 내부적인 메커니즘에 의해 실행되는 메서드
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // identifier 확인하고 -> 해당 뷰컨트롤러에 데이터 전달
        if segue.identifier == "ToDoCell" {
            let detailVC = segue.destination as! DetailViewController
            
            guard let indexPath = sender as? IndexPath else { return }
            detailVC.toDoData = toDoManager.getTodoListFormCoreData()[indexPath.row]
        }
    }
    
    // 테이블뷰의 높이를 자동으로 추정하는 메서드
    // ToDo에서 메세지가 길때는 셀의 높이를 더 높게 => 셀의 오토레이아웃 설정도 필요
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
