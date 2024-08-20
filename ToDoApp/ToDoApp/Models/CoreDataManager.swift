//
//  CoreDataManager.swift
//  ToDoApp
//
//  Created by Suji Jang on 8/18/24.
//

import UIKit
import CoreData

// MARK: - ToDo관리하는 매니저 (코어데이터 관리)

final class CoreDataManager {
    
    // Singleton
    static let shared = CoreDataManager()
    private init() {}
    
    // 앱델리게이트에 언제든지 접근할 수 있도록 상수로 선언
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    // ⭐️ 임시 저장소
    lazy var context = appDelegate?.persistentContainer.viewContext
    
    // 엔터티 이름 (코어데이터에 저장된 객체)
    let modelName: String = "ToDoData"
    
    // MARK: - [Read] 코어데이터에 저장된 데이터 모두 읽어오기
    
    // 데이터를 요청하면 -> 하드에 저장된 데이터를 리턴
    func getToDoListFromCoreData() -> [ToDoData] {
        var toDoList: [ToDoData] = []
        
        // 임시 저장소 있는지 확인하기 위한 옵셔널 바인딩
        if let context {
            
            // fetch메서드에 필요한 요청서 생성
            // entityName: 만드려는 데이터 실체의 이름을 문자열로 넣어주면 된다
            // 실체: ToDoApp파일에서 만든 ToDoData
            let request = NSFetchRequest<NSManagedObject>(entityName: modelName)
            
            // 정렬순서를 정해서 요청서에 넘겨주기
            // ToDoData실체를 만들때 선언했던 date속성(날짜)을 기준으로 내림차순으로 데이터를 가져온다
            // ascending(오름차순): true / (내림차순)false
            let dataOrder = NSSortDescriptor(key: "date", ascending: false)
            
            // 데이터를 어떤 기준으로 가져올건지 지정하는 속성
            request.sortDescriptors = [dataOrder]
            
            do {
                // 임시저장소에서 (요청서를 통해서) 데이터 가져오기 (fetch메서드)
                if let fetchedToDoList = try context.fetch(request) as? [ToDoData] {
                    toDoList = fetchedToDoList
                }
            } catch {
                print("가져오기 실패")
            }
        }
        return toDoList
    }
    
    // MARK: - [Create] 코어데이터에 데이터 생성하기
    
    func saveToDoData(toDoText: String?, colorInt: Int64, completion: @escaping () -> Void) {
        
        // 임시저장소 있는지 확인
        if let context {
            
            // 비동기처리시 .perform메서드 활용
//            context.perform {
            
            // 임시 저장소에 있는 데이터의 형태 파악 -> 실체를 뽑아낼 수 있음
            // 실체의 이름인 문자열 + 임시저장소를 가지고 생성하고 싶은 데이터의 형태를 그려준다
            if let entity = NSEntityDescription.entity(forEntityName: modelName, in: context) {
                
                // 임시저장소에 올라가게할 객체 만들기 (NSManagedObject => ToDoData)
                // 임시저장소로 ToDoData를 생성하는 방법도 있다 (타입캐스팅 필요없음)
                //ToDoData(context: context)
                
                // 실체 + 임시저장소를 가지고 NSManagedObject(관리객체)를 생성해서
                // 구체적인 타입으로 타입캐스팅해서 구체적인 실체인ToDoData 생성해서 접근
                if let toDoData = NSManagedObject(entity: entity, insertInto: context) as? ToDoData {
                    
                    // MARK: - ToDoData에 실제 데이터 할당
                    toDoData.memoText = toDoText
                    toDoData.date = Date()  // 저장하는 순간의 날짜로 생성
                    toDoData.color = colorInt
                    
                    // 임시저장소에 접근해서 변한 내용이 있는지 확인하고 저장
                    // appDelegate?.saveContext()  // 앱델리게이트의 메서드로도 호출 가능
                    if context.hasChanges {
                        do {
                            try context.save()  // 영구저장소(하드)에 저장
                            completion()
                        } catch {
                            print(error)
                            completion()
                        }
                    }
                }
            }
            // }
        }
        completion()
    }
    
    // MARK: - [Update] 코어데이터에서 데이터 수정하기 (일치하는 데이터 찾아서 => 수정)
    
    func updateToDo(newToDoData: ToDoData, completion: @escaping () -> Void) {
        
        // 날짜 옵셔널 바인딩
        guard let date = newToDoData.date else {
            completion()
            return
        }
        
        // 임시저장소 있는지 확인
        if let context {
            
            // 요청서
            let request = NSFetchRequest<NSManagedObject>(entityName: modelName)
            
            // 찾기위한 조건(단서) 설정
            request.predicate = NSPredicate(format: "date = %@", date as CVarArg)
            
            do {
                // 요청서를 통해서 데이터 가져오기
                if let fetchedToDoList = try context.fetch(request) as? [ToDoData] {
                    
                    // 배열의 첫번째
                    if var targetToDo = fetchedToDoList.first {
                        
                        // MARK: - ToDoData에 실제 데이터 재할당(바꾸기)
                        targetToDo = newToDoData
                        
//                        appDelegate?.saveContext()  // 앱델리게이트의 메서드로도 가능
                        if context.hasChanges {
                            do {
                                try context.save()
                                completion()
                            } catch {
                                print(error)
                                completion()
                            }
                        }
                    }
                }
                completion()
            } catch {
                print("업데이트 실패")
                completion()
            }
        }
    }
    
    // MARK: - [Delete] 코어데이터에서 데이터 삭제하기 (일치하는 데이터 찾아서 => 삭제)
    
    // 외부에서 지우고싶은 데이터를 전달
    func removeToDo(data: ToDoData, completion: @escaping () -> Void) {
        
        // 날짜 옵셔널 바인딩
        // 지우고싶은 데이터를 전달해주면 날짜 확인
        guard let date = data.date else {
            completion()
            return
        }
        
        // 임시저장소 있는지 확인
        if let context {
            
            // 데이터를 가져오기 위한 요청서
            // 일단 임시저장소에서 데이터를 배열로 무조건 가져온 다음에 삭제
            let request = NSFetchRequest<NSManagedObject>(entityName: modelName)
            
            // 찾기 위한 조건(단서) 설정
            // 날짜를 기준으로 한다는 문자열, 옵셔널바인딩한 date를 타입캐스팅한것 전달
            request.predicate = NSPredicate(format: "date = %@", date as CVarArg)
            
            do {
                // 요청서를 통해서 데이터 가져오기 (fetch메서드)
                // 조건에 일치하는 데이터 찾기
                if let fetchedToDoList = try context.fetch(request) as? [ToDoData] {
                    
                    // 임시저장소에서 (요청서를 통해서) 데이터 삭제하기 (delete메서드)
                    if let targetToDo = fetchedToDoList.first {
                        
                        // 임시저장소에 delete메서드가 존재해서 임시저장소에서 지운 다음에
                        context.delete(targetToDo)
                        
                        
                        // 임시저장소의 내용이 바뀌었다면 영구저장소에 저장
//                        appDelegate?.saveContext()  // 앱델리게이트의 메서드로도 가능
                        if context.hasChanges {
                            do {
                                try context.save()
                                completion()
                            } catch {
                                print(error)
                                completion()
                            }
                        }
                    }
                }
                completion()
            } catch {
                print("지우기 실패")
                completion()
            }
        }
    }
    
}
