//
//  CoreDataManager.swift
//  MusicApp
//
//  Created by Suji Jang on 8/20/24.
//

import UIKit
import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()
    private init() {}
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    lazy var context = appDelegate?.persistentContainer.viewContext
    let modelName = "MusicSaved"
    
    // MARK: - [Create] 코어데이터에 데이터 생성하기 (Music => MusicSaved)
    func saveMusic(with music: Music, message: String?, completion: @escaping () -> Void) {
        if let context {
            if let entity = NSEntityDescription.entity(forEntityName: modelName, in: context) {
                
                // 임시저장소에 올라가게할 객체 만들기 (NSManagedObject => ToDoData)
                // 임시저장소로 ToDoData를 생성하는 방법도 있다 (타입캐스팅 필요없음)
                let musicSaved = MusicSaved(context: context)
                
                // MusicSaved에 실제 데이터 할당
                musicSaved.songName = music.songName
                musicSaved.artistName = music.artistName
                musicSaved.albumName = music.albumName
                musicSaved.imageUrl = music.imageUrl
                musicSaved.releaseDate = music.releaseDateString
                musicSaved.savedDate = Date()
                musicSaved.myMessage = message
                
                // 임시저장소에 접근해서 변한 내용이 있는지 확인하고 저장
                appDelegate?.saveContext()  // 앱델리게이트의 메서드로도 호출 가능
            }
        }
        completion()
    }
    
    // MARK: - [Read] 코어데이터에 저장된 데이터 모두 읽어오기
    
    func getMusicSavedArrayFromCoreData() -> [MusicSaved] {
        var savedMusicList: [MusicSaved] = []
        
        if let context {
            let request = NSFetchRequest<MusicSaved>(entityName: modelName)
            let savedDate = NSSortDescriptor(key: "savedDate", ascending: true)  // 오름차순
            request.sortDescriptors = [savedDate]
            
            do {
                let fetchedMusicList = try context.fetch(request)
                savedMusicList = fetchedMusicList
            } catch {
                print("CoreData: Read 실패")
            }
        }
        
        return savedMusicList
    }
    
    // MARK: - [Update] 코어데이터에서 데이터 수정하기 (일치하는 데이터 찾아서 => 수정)
        
        func updateMusic(with music: MusicSaved, completion: @escaping () -> Void) {
            guard let date = music.savedDate else {
                completion()
                return
            }
            
            if let context {
                let request = NSFetchRequest<MusicSaved>(entityName: modelName)
                request.predicate = NSPredicate(format: "savedDate = %@", date as CVarArg)
                
                do {
                    // 요청서를 통해서 데이터 가져오기
                    let fetchedMusicList = try context.fetch(request)
                        if var targetMusic = fetchedMusicList.first {
                            
                            // 실제 데이터 재할당(바꾸기)
                            targetMusic = music
                            
                            appDelegate?.saveContext()
                        }
                    completion()
                } catch {
                    print("CoreData: 업데이트 실패")
                    completion()
                }
            }
        }
        
    // MARK: - [Delete] 코어데이터에서 데이터 삭제하기 (일치하는 데이터 찾아서 => 삭제)
    
    // 외부에서 지우고싶은 데이터를 전달
    func deleteMusic(with music: MusicSaved, completion: @escaping () -> Void) {
        guard let date = music.savedDate else {
            completion()
            return
        }
        
        if let context {
            let request = NSFetchRequest<NSManagedObject>(entityName: modelName)
            request.predicate = NSPredicate(format: "savedDate = %@", date as CVarArg)
            
            do {
                // 조건에 일치하는 데이터 찾기
                let fetchedMusicList = try context.fetch(request)
                
                // 임시저장소에서 (요청서를 통해서) 데이터 삭제하기 (delete메서드)
                if let targetMusic = fetchedMusicList.first {
                    
                    // 임시저장소의 delete메서드로 임시저장소에서 지운 다음에
                    context.delete(targetMusic)
                    
                    // 임시저장소의 내용이 바뀌었다면 영구저장소에 저장
                    appDelegate?.saveContext()
                }
                completion()
            } catch {
                print("CoreData: 지우기 실패")
                completion()
            }
        }
    }
}
