//
//  SceneDelegate.swift
//  MemberList
//
//  Created by Suji Jang on 8/8/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // 테이블뷰UI를 코드로 작성했기 때문에 코드를 통해서 인스턴스 생성하는 코드
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        // 리스트뷰컨트롤러를 생성하기 전에 뷰모델이 필요하니까 뷰모델 먼저 생성
        // 뷰모델을 만들때는 데이터를 관리하는 객체를 만들어서 전달해야하니까 데이터 관리 객체를 생성
        let dataManager = MemberListManager()
        
        // 뷰모델 생성: 데이터 관리 객체 생성 -> 뷰모델한테 전달하면서 네비게이션 타이틀 세팅
        let viewModel = MemberListViewModel(dataManager: dataManager, title: "회원 목록")
        
        // 뷰모델을 뷰컨트롤러의 생성자한테 전달
        let ListVC = ListViewController(viewModel: viewModel)
        
        // 이렇게 만들수도 있고 의존성을 관리하는 라이브러리를 사용해서 간단하게 구현할 수도 있다
        
        let naviVC = UINavigationController(rootViewController: ListVC)
        
        window?.rootViewController = naviVC
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

