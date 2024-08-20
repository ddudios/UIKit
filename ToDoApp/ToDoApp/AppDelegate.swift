//
//  AppDelegate.swift
//  ToDoApp
//
//  Created by Suji Jang on 8/18/24.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack
    // 코어 데이터를 생성하면 컨테이너가 하나 생겨서 언제든지 컨테이너에 접근할 수 있고
    // 임시저장소에 변화가 있을때 저장하는 메서드까지 생성

    // 영구 컨테이너: 메모리에 올라가는 것
    // 클로저를 실행하는 형태로 구현
    // 파일 이름이 "ToDoApp"인 파일에 접근해서 컨테이너를 생성하는 코드
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ToDoApp")
        
        // 컨테이너에 접근해서 영구 저장소를 불러오는 함수
        // 에러가 발생하면 앱 종료
        // 영구 저장소를 제대로 불러왔다면 컨테이너를 리턴해서 persistentContainer에 담아 놓는다
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    // 임시 저장소의 내용을 저장하는 메서드 (변화가 없다면 => 저장)
    func saveContext () {
        
        // 컨테이너 내부에 임시 저장소가 있어서 접근 연산자로 임시 저장소인 viewContext에 접근
        // 컨테이너의 임시 저장소를 context상수에 담으니까 context를 임시 저장소라고 생각하면 된다
        let context = persistentContainer.viewContext
        
        // save()는 오래 걸리는 메서드이기 때문에 변화를 체크해서 변할때만 저장
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

