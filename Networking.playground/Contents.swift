import UIKit


// MARK: - Model

// 실제 API에서 받게 되는 정보
struct MusicData: Codable {
    let resultCount: Int
    let results: [Music]
    
    enum CodingKeys: String, CodingKey {
        case resultCount
        case results
    }
}

// 실제 우리가 사용하게될 음악(Music) 모델 구조체
// 서버에서 가져온 데이터만 표시해주면 되기 때문에 일반적으로 구조체로 만듬
struct Music: Codable {
    let soneName: String?
    let artistName: String?
    let albumName: String?
    let previewUrl: String?
    let imageUrl: String?
    let releaseDate: String?

    // 네트워크에서 주는 이름을 변경하는 방법 (원시값)
    // 모든 멤버에 대해서 나열해줘야 한다
    // (서버)trackName => (앱)songName
    enum CodingKeys: String, CodingKey {
        case soneName = "trackName"
        case artistName
        case albumName = "collectionName"
        case previewUrl
        case imageUrl = "artworkUrl100"
        case releaseDate
    }
}


// MARK: - 네트워크 통신 메서드

func getMethod() {

    // URL구조체 만들기: 음악 jazz 검색 주소를 넣은 URL
    guard let url = URL(string: "https://itunes.apple.com/search?mdeia=music&term=jazz") else {
        print("Error: cannot create URL")
        return
    }
    
    // URL요청 생성
    // URL 구조체를 가지고 Request 생성
    var request = URLRequest(url: url)
    request.httpMethod = "GET"  // Request는 GET 방식으로 요청
    
    // 요청을 가지고 작업세션시작
    // dataTask메서드 실행이 끝나면 JSON 데이터가 날아온다
    // dataTask(네트워킹)메서드 자체가 오래 걸리는 메서드이기 때문에 내부에서 비동기 처리가 되어 있다
    URLSession.shared.dataTask(with: request) { data, response, error in
        // 에러가 없어야 넘어감
        guard error == nil else {
            print("Error: error calling GET")
            print(error!)
            return
        }
        // 옵셔널 바인딩
        guard let safeData = data else {
            print("Error: Did not receive data")
            return
        }
        // HTTP 200번대 정상코드인 경우만 다음 코드로 넘어감
        guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
            print("Error: HTTP request failed")
            return
        }

        // safeData(JSON형태) -> 구조체 형태로 변환
        // 분석한 decode 결과값이 throws형태이기 때문에 do-catch문 사용
        do {
            // JSONDecoder 생성해서 decoder에 담아준다
            let decoder = JSONDecoder()
            
            // JSONDecoder에 코드를 분석한다는 .decode(_ type:from:)메서드가 있다
            // type: 변형하고 싶은 타입 (Decodable.Protocol 메타 타입: Decodable을 채택한 타입)
            // - MusicData() 하나의 인스턴스를 쓰는게 아니라 메타타입이니까 타입 인스턴스를 넣어야 한다
            // frome: ~로 부터 (Data 타입)
            let musicArray = try decoder.decode(MusicData.self, from: safeData)
            dump(musicArray)  // 정리된 형태로 출력
        } catch {
            
        }

    }.resume()     // 시작
    print("⭐️ resume동작 ⭐️")
}

getMethod()
