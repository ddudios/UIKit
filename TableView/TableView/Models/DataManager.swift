//
//  DataManager.swift
//  TableView
//
//  Created by Suji Jang on 8/7/24.
//

import UIKit

class DataManager {
    
    // 데이터 저장 속성
    private var movieDataArray: [Movie] = []
    
    // 데이터 생성
    func makeMovieData() {
        movieDataArray = [
            Movie(movieImage: UIImage(named: "batman.png"), movieName: "배트맨", movieDescription: "배트맨이 출연하는 영화"),
            Movie(movieImage: UIImage(named: "captain.png"), movieName: "캡틴 아메리카", movieDescription: "캡틴 아메리카의 기원. 캡틴 아메리카는 어떻게 탄생하게 되었을까?"),
            Movie(movieImage: UIImage(named: "ironman.png"), movieName: "아이언맨", movieDescription: "토니 스타크가 출현, 아이언맨이 탄생하게된 계기가 재미있는 영화"),
            Movie(movieImage: UIImage(named: "thor.png"), movieName: "토르", movieDescription: "아스가르드의 후계자 토르가 지구에 오게되는 스토리"),
            Movie(movieImage: UIImage(named: "hulk.png"), movieName: "헐크", movieDescription: "브루스 배너 박사의 실험을 통해 헐크가 탄생하게 되는 영화"),
            Movie(movieImage: UIImage(named: "spiderman.png"), movieName: "스파이더맨", movieDescription: "피터 파커 학생에서 스파이더맨이 되는 과정을 담은 스토리"),
            Movie(movieImage: UIImage(named: "blackpanther.png"), movieName: "블랙펜서", movieDescription: "와칸다의 왕위 계승자 티찰과 블랙펜서가 되다."),
            Movie(movieImage: UIImage(named: "doctorstrange.png"), movieName: "닥터스트레인지", movieDescription: "외과의사 닥터 스트레인지가 히어로가 되는 과정을 담은 영화"),
            Movie(movieImage: UIImage(named: "guardians.png"), movieName: "가디언즈 오브 갤럭시", movieDescription: "빌런 타노스에 맞서서 세상을 지키려는 가오겔 멤버들")
        ]
    }
    
    // 데이터 호출
    func getMovieData() -> [Movie] {
        return movieDataArray
    }
    
    // 데이터 추가
    func updateMovieData() {
        let movie = Movie(movieImage: UIImage(named: "spiderman2.png"), movieName: "스파이더맨2", movieDescription: "스파이더맨 시즌2")
        movieDataArray.append(movie)
    }
}
