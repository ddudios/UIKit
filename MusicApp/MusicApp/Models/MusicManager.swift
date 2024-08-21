//
//  MusicManager.swift
//  MusicApp
//
//  Created by Suji Jang on 8/20/24.
//

import UIKit
import CoreData

// MARK: - 데이터 관리 모델 (전체 관리)

final class MusicManager {
    
    // Singleton
    // 저장된 데이터, 서버에서 받아오는 데이터 등 여러 화면의 모든것을 관리
    static let shared = MusicManager()
    
    // 초기화할때 저장된 데이터 셋팅
    private init() {
        fetchMusicFromCoreData {
            print("저장된 데이터 세팅 완료")
        }
    }
    
    // 뮤직매니저가 네트워킹매니저, 코어데이터매니저 모두 다루도록 구현
    // 외부에서 호출할 수 없고 내부 메서드에서만 다룰 수 있도록 구현
    // 네트워크매니저 (싱글톤)
    private let networkManager = NetworkManager.shared
    // 코어데이터매니저 (싱글톤)
    private let coreDataManager = CoreDataManager.shared
    
    // 서버에서 받아온 음악배열 (첫번째탭 표시)
    private var musicArray: [Music] = []
    
    // 코어데이터에 저장하기위한 음악배열 (두번째탭 표시)
    // 저장된 데이터 관리
    private var musicSavedArray: [MusicSaved] = []
    
    // API를 통해서 서버에서 가져오는 메서드
    func getMusicArrayFromAPI() -> [Music] {
        return musicArray
    }
    
    // 코어데이터에서 가져오는 메서드
    func getMusicDataFromCoreData() -> [MusicSaved] {
        return musicSavedArray
    }
    
    // MARK: - API 통신 관련 메서드
    // 네트워킹매니저를 통해서 할 수 있는 일
    
    // 첫화면 기본 데이터 셋업하기
    func setupDataFromAPI(completion: @escaping () -> Void) {
        print("시작")
        getDataFromAPI(with: "jazz") {
            completion()
        }
    }
    
    // 검색하기
    func fetchDataFromAPI(withTerm searchTerm: String, completion: @escaping () -> Void) {
        getDataFromAPI(with: searchTerm) {
            completion()
        }
    }
    
    // 네트워크매니저한테 요청해서 서버에서 데이터 가져오기
    private func getDataFromAPI(with searchTerm: String, completion: @escaping () -> Void) {
        networkManager.fetchMusic(searchTerm: searchTerm) { result in
            switch result {
            case .success(let musicData):
                self.musicArray = musicData
                self.checkWhetherSaved()
                completion()
            case .failure(let error):
                print(error.localizedDescription)
                self.checkWhetherSaved()
                completion()
            }
        }
    }
    
    // MARK: - 코어데이터와 커뮤니케이션하는 메서드
    
    // 첫화면 셋팅
    func setupDataFromCoreData(completion: () -> Void) {
        fetchMusicFromCoreData {
            completion()
        }
    }
    
    // Create (데이터 생성)
    func saveMusicData(with music: Music, message: String?, completion: @escaping () -> Void) {
        coreDataManager.saveMusic(with: music, message: message) {
            self.fetchMusicFromCoreData {
                completion()
            }
        }
    }
    
    // Delete (Music타입을 가지고 데이터 지우기) => 저장되어 있는지 확인하고 지우기
    // 첫번째 탭
    func deleteMusic(with music: Music, completion: @escaping () -> Void) {
        
        // 동일한 데이터(제목&가수이름)를 가진 것들을 찾아내서 (배열로 리턴)
        let musicSaved = musicSavedArray.filter { $0.songName == music.songName && $0.artistName == music.artistName }
        
        // 전달
        if let targetMusicSaved = musicSaved.first {
            self.deleteMusicFromCoreData(with: targetMusicSaved) {
                print("삭제 완료")
                completion()
            }
        } else {
            print("일치하는 데이터 없음")
            completion()
        }
    }
    
    // Delete (MusicSaved타입을 가지고 코어데이터에 저장되어 있는 데이터 지우기)
    // 두번째 탭
    func deleteMusicFromCoreData(with music: MusicSaved, completion: @escaping () -> Void) {
        coreDataManager.deleteMusic(with: music) {
            self.fetchMusicFromCoreData {
                completion()
            }
        }
    }
    
    // Update (수정하기)
    func updateMusicToCoreData(with music: MusicSaved, completion: @escaping () -> Void) {
        coreDataManager.updateMusic(with: music) {
            self.fetchMusicFromCoreData {
                completion()
            }
        }
    }
    
    // Read (데이터 불러오기)
    // 코어데이터에서 가져와서 => 현재 모델의 배열에 저장
    func fetchMusicFromCoreData(completion: () -> Void) {
        musicSavedArray = coreDataManager.getMusicSavedArrayFromCoreData()
        completion()
    }
    
    // 이미 저장된 데이터들인지 확인 (저장 여부 확인)
    // 저장여부를 확인해야 하트표시 가능
    // 서버에서 받아온 음악 데이터 배열: 저장안된 날것의 데이터 (좋아요X)
    // 코어데이터를 통해서 영구 저장소에 저장되어 있는 음악 데이터 배열
    // 이미 코어데이터에 저장된 데이터인지 여부 판단할 수 있는 메서드
    func checkWhetherSaved() {
        musicArray.forEach { music in
            
            // 코어데이터에 저장된 것들중 음악이름, 가수이름이 같은 것을 찾아내서
            if musicSavedArray.contains(where: {
                $0.songName == music.songName && $0.artistName == music.artistName
            }) {
                
                // 이미 저장되어있는 데이터라고 설정
                music.isSaved = true
            } else {
                music.isSaved = false
            }
        }
    }
}
