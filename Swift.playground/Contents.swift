import UIKit

/*
 // if문
 var num = 9
 
 if num < 0 {
 print("음수")
 } else {
 print("0 또는 양수")
 
 if num % 2 == 0 {
 print("짝수")
 } else if num % 2 == 1 {
 print("홀수")
 }
 }
 
 // switch문
 var age: Int = 17
 var person: String = "나이 모름"
 
 switch age {
 case 0...13:
 person = "어린이"
 case 14...19:
 person = "청소년"
 case 20...:
 person = "성인"
 default:
 break
 }
 
 switch person {
 case "어린이", "청소년":
 print("어린이, 청소년 입장료: 3000원")
 case "성인":
 print("성인 입장료: 5000원")
 default:
 break
 }
 
 // Value Binding + where
 switch num {
 case let x where x > 0:
 print("num = \(x), 양수")
 case let x where x < 0:
 print("num = \(x), 음수")
 default:
 break
 }
 
 // [연습문제: if문 사용 연습해보기] 가위/바위/보 게임 만들기
 var computerChoice = Int.random(in: 0...2) // 0: 가위, 1: 바위, 2: 보
 var myChoice: Int = 1
 
 switch computerChoice {
 case 0:
 print("computer: 가위")
 case 1:
 print("computer: 바위")
 case 2:
 print("computer: 보")
 default:
 break
 }
 
 print("me: 1 = 바위")
 
 // if문에서의 콤마는 AND의 의미로 논리적 오류, switch문에서의 콤마가 OR
 // 이렇게 짠 이유: 모든 콤마가 OR의 의미인줄 알았음
 //if myChoice == computerChoice {
 //    print("무승부입니다.")
 //} else if (myChoice == 0 && computerChoice == 2),
 //(myChoice == 1 && computerChoice == 0), (myChoice == 2 && computerChoice == 1) {
 //    print("당신이 이겼습니다.")
 //} else {
 //    print("당신은 졌습니다.")
 //}
 
 if myChoice == computerChoice {
 print("무승부입니다.")
 } else if myChoice == 0 && computerChoice == 2 {
 print("당신이 이겼습니다.")
 } else if myChoice == 1 && computerChoice == 0 {
 print("당신이 이겼습니다.")
 } else if myChoice == 2 && computerChoice == 1 {
 print("당신이 이겼습니다.")
 } else {
 print("당신은 졌습니다.")
 }
 
 // [연습문제: if문 사용 연습해보기] 랜덤 빙고 게임 만들기
 var comChoice = Int.random(in: 1...10)
 
 if comChoice == myChoice {
 print("Bingo")
 } else if comChoice > myChoice {
 print("Up")
 } else {
 print("Down")
 }
 
 
 // Tuple
 //var twoValues = ("장수지", 20)
 //twoValues = ("장수지", 20, "서울")  // 오류
 
 typealias information = (String, Int)
 
 //var twoValues = (name: "장수지", age: 20)
 //twoValues.0  // "장수지"
 //twoValues.age  // 20
 
 //let twoValues = ("장수지", 20)
 //let (name, age) = twoValues
 let name = "장수지", age = 20
 name  // "장수지"
 age  // 20
 
 
 (1, "apple") < (2, "apple")
 (1, "apple") < (1, "bird")
 //(1, true) < (2, false)
 
 // Tuple - if (1) 각 요소 조건 확인
 let info = ("장수지", 20)
 
 if info.0 == "장수지" && info.1 == 20 {
 print("이름은 장수지이고 나이는 20살입니다.")
 } else {
 print("이름과 나이를 입력해주세요.")
 }
 
 // Tuple - if (2) 묶음 조건 확인
 if info == ("장수지", 20) {
 print("이름: 장수지, 나이: 20")
 }
 
 // Tuple - switch
 let info = ("장수지", "20")
 
 switch info {
 case (let information, "30"), ("김수지", let information):
 print("이 사람의 정보중 하나: \(information)")
 case let (name, age) where name == "최수지":
 print("장수지의 나이는 \(age)")
 case let (name, age):
 print("이름: \(name), 나이: \(age)")
 }
 
 let info = ("장수지", 20)
 
 switch info {
 case (let name, let age), (let name, let age):
 print("이 사람의 정보중 하나: \(name)")
 }
 
 // 삼항 연산자
 let weight = 13
 
 var packaging = weight < 10 ? "plastic bag" : "box"
 
 if weight < 10 {
 packaging = "plastic bag"
 } else {
 packaging = "box"
 }
 
 // 범위 연산자 - switch문, tuple
 var progressChart = (section: 3, understanding: 5)
 
 switch progressChart {
 case (1, 1..<2):  // Range<Int>
 print("\(progressChart.0)강 강의 다시 듣기")
 case (1, 2 ... 3):  // ClosedRange<Int>
 print("\(progressChart.0)강 복습하기")
 case (1, 4...):  // PartialRangeFrom<Int>
 print("\(progressChart.0)직접 코드 만들어 보기")
 case (2, ..<3):  // PartialRangeUpTo<Int>
 print("\(progressChart.0)강 강의 다시듣기")
 case (3, ...5):  // PartialRangeThrough<Int>
 print("\(progressChart.0)강 강의 2번씩 듣기")
 default:
 print("숫자 잘못 입력")
 }
 
 // 패턴매칭연산자 - 범위연산자
 var wakeupTime = 7...24
 var now = 2
 
 wakeupTime ~= now
 
 if wakeupTime ~= now {
 print("\(now): 공부 시간")
 } else {
 print("\(now): 자는 시간")
 }
 
 var behavior = wakeupTime ~= now ? "공부 시간" : "자는 시간"
 print("\(now): \(behavior)")
 
 var n = 30
 if 10...100 ~= n {
 print("10 <= n <= 100")
 }
 
 // for문 - 반복상수, scope
 var sum = 0
 for number in 1...3 {
 sum += number
 print("\(number)번째 sum: \(sum)")
 }
 
 print("합계: \(sum)")
 //print(number)
 
 // while문 vs. repeat-while문
 var number = 0
 
 while number < 0 {
 print("같은 조건에서 while문은 출력되면 안됨")
 }
 
 repeat {
 print("같은 조건에서 repeat-while문은 출력돼야 함")
 } while number < 0
 
 // 제어전송문 - continue
 for i in 1...5 {
 if i % 2 == 0 {
 continue
 print("continue 아래 코드") // 경고: Code after 'continue' will never be executed - 'continue'후의 코드는 실행되지 않습니다
 }
 print("조건문 false -> \(i)")
 }
 
 // 제어전송문 - break
 for i in 1...5 {
 if i % 2 == 0 {
 break
 print("break 아래 코드")  // 경고: Code after 'break' will never be executed - 'break'후의 코드는 실행되지 않습니다
 }
 print("조건문 false -> \(i)")
 }
 
 // Labeled Statements
 OUTER: for i in 1...2 {
 print("OUTER: \(i)")
 
 for j in 1...2 {
 print("INNER: \(j)")
 continue OUTER
 }
 }
 
 // [연습문제: 반복문 사용 연습해보기] 구구단 출력해보기
 for i in 2...9 {
 for j in 1...9 {
 print("\(i) X \(j) = \(i * j)")
 }
 }
 
 // [연습문제: 반복문 사용 연습해보기] 배수 구해서 출력해보기
 for i in 1...100 {
 if i % 3 == 0 {
 print("3의 배수 발견: \(i)")
 }
 }
 
 // [연습문제: 반복문 사용 연습해보기] 반복문 활용, 논리를 구성하여 출력해보기
 for i in 1...5 {
 var j = 0
 
 while j < i {
 j += 1
 print("😄", terminator:"")
 }
 print()
 }
 
 // continue활용 - 여러개의 조건일 때 걸러내는 논리, 가독성 증가
 for i in 5...15 {
 if i % 7 == 0 {
 continue
 }
 if i % 11 == 0 {
 continue
 }
 if i % 13 == 0 {
 continue
 }
 print("\(i)", terminator: " ")
 }
 
 // print함수
 print("---")
 print() // 엔터 1번
 print("---")
 print("\n") // 엔터 2번
 print("---")
 print("terminator의 기본세팅 \"\\n\"를 ", terminator: "")
 print("\"\"로 바꾸면 이어쓸 수 있다")
 
 // 함수 - input만
 func information(name: String) {
 print("이름: \(name)")
 }
 
 information(name: "장수지")
 
 // 함수 - output만
 func piDouble() -> Double {
 return 3.14
 }
 
 let pi = piDouble()
 print(2.0 * pi * 5.0)  // 31.400000000000002
 
 // 함수 - input, output
 func sum(a: Int, b: Int) -> Int {
 let c = a + b
 return c
 }
 
 print("a + b = \(sum(a: 2, b: 3))")  // a + b = 5
 
 // 함수 - Void타입 vs. return타입
 func voidType() {
 print("내부에서 프린트")
 }
 
 voidType()  // 내부에서 프린트
 
 func returnType() -> String {
 return "반환값"
 }
 
 let returnValue = returnType()
 print(returnValue)  // 반환값
 
 // 함수의 파라미터, 아규먼트 - Argument Label
 func name(firstName name1: String, lastName name2: String) {
 print("이름: \(name2)\(name1)")
 }
 name(firstName: "수지", lastName: "장")
 
 // 함수의 파라미터, 아규먼트 - Argument Label -> 와일드카드패턴
 func sum(_ a: Int, _ b: Int) {
 print("\(a) + \(b) = \(a + b)")
 }
 sum(2, 4)
 
 // 함수의 파라미터, 아규먼트 - 가변파라미터
 func average(number: Double...) {
 var total: Double = 0.0
 
 for n in number {
 total += n
 }
 
 print("평균: \(total / Double(number.count))")
 }
 average(number: 2, 4, 6, 1)
 
 func rollBook(name: String...) {
 print("1학년: \(name)")
 }
 rollBook(name: "장수지", "김수지", "이수지")
 
 // 함수의 파라미터, 아규먼트 - 파라미터의 기본값
 func information(name: String, introduce: String = "자기소개 없음") {
 print("이름: \(name), 자기소개: \(introduce)")
 }
 information(name: "장수지", introduce: "안녕하세요")
 information(name: "김수지")
 
 // 함수 사용시 주의점 - 함수 파라미터는 상수, scope
 func square(a: Int) {
 //    a *= a  // 오류
 var c = a
 c *= c
 print(c)
 }
 square(a: 3)
 //c = 3   // Cannot find 'c' in scope
 
 // 함수 사용시 주의점 - return 키워드: output없을 때 -> 함수 종료
 func name(name: String) {
 if name.count == 3 {
 print("이름: \(name)")
 return
 }
 print("3글자로 입력해 주세요")
 }
 name(name: "장수지")
 name(name: "수지")
 
 // 함수 사용시 주의점 - return 키워드: output있을 때 -> 리턴값 반환하고 종료
 func name(name: String) -> String {
 return "3글자로 입력해 주세요"
 }
 var name = "수지"
 if name(name: name).count != 3 {
 print(name(name: name))
 }   // 3글자로 입력해 주세요
 
 // 함수 사용시 주의점 - 함수의 중첩 사용
 func random(num: Int) -> String {
 let randomNum = Int.random(in: 1...5)
 print(randomNum)
 
 func bingo(input: Int) -> String {
 return "bingo"
 }
 
 func fail(input: Int) -> String {
 return "fail"
 }
 
 if num == randomNum {
 return bingo(input: randomNum)
 } else {
 return fail(input: randomNum)
 }
 }
 print(random(num: 2))
 
 // overloading
 func calculate(a: Int, b: Int) -> Int {
 return a + b
 }
 
 func calculate(a: Int, b: Int) -> Double {
 return Double(a + b)
 }
 
 func calculate(c: Int, d: Int) -> Int {
 return c * d
 }
 
 func calculate(a: Double, b: Double) -> Double {
 return a / b
 }
 
 func calculate(_ a: Int, _ b: Int) -> Int {
 return a - b
 }
 
 func calculate(a: Int, b: Int, c: Int) -> Int {
 return a + b + c
 }
 
 // scope
 //var age = 8   // 초등학교 중학교
 if age > 7 && age < 14 {
 var school = "초등학교"
 print(school)
 //    var school = "초등"  // 오류: 선언이 먼저 돼야 가능
 
 func middleschool() {
 var school = "중학교"  // 다른 범위에서 같은 변수명 사용 가능
 print(school)
 }
 middleschool()
 }
 
 var age = 8  // 전역변수는 선언이 더 아래 있어도 가능하지만 위의 if문은 실행되지 않는다
 //middleschool()  // 오류: 외부에서 접근 불가능
 
 // Optional
 var a: Int?
 print(a)
 
 let num: Int = 1
 let temp: Int? = num
 print(temp)  // Optional(1)
 
 // 배열
 var array1: Array<Int> = []
 var array: [Int] = [1, 2, 3, 4, 1]
 let emptyArray: [String] = []
 let emptyArray1: Array<Int> = Array<Int>()
 let emptyArray2 = [Int]()
 
 // 배열 요소의 개수
 print(array.count)  // 5
 
 // 빈배열
 print(array.isEmpty)  // false
 
 // 요소에 (값)의 포함 여부
 print(array.contains(2))  // true
 
 // 1개의 요소 랜덤으로 꺼내기
 print(array.randomElement())  // Optional(3)
 
 // 요소의 인덱스 맞바꾸기
 array.swapAt(2, 4)
 print(array)  // [1, 2, 1, 4, 3]
 
 array[0]  // 1
 array[0] = 5  // [5, 2, 1, 4, 3]
 
 // 값이 있을지 없을지 모르기 때문에 옵셔널
 // 배열의 0번째 요소 추출
 array.first  // Optional(5)
 
 // 배열의 마지막 요소 추출
 array.last  // Optional(3)
 print(array.first!)  // 5
 
 var array = [1, 2, 3, 1, 4]
 // 배열의 시작 인덱스
 print(array.startIndex)  // 0
 // 항상 0
 
 // 배열의 마지막 인덱스
 print(array.endIndex)  // 5
 // 배열로 저장되는 메모리 공간 끝의 주소
 // 배열의 실질적 마지막 인덱스의 값을 추출하려면 -1
 print(array[array.endIndex - 1])  // 4
 
 // array[array.endIndex]  // error: Index out of range
 
 // 배열은 중복을 허용하기 때문에 필요
 // 앞에서부터 찾았을 때 앞에서부터 센 인덱스
 array.firstIndex(of: 1)  // 0
 
 // 뒤에서부터 찾았을 때 앞에서부터 센 인덱스
 array.lastIndex(of: 1)  // 3
 
 print(array.lastIndex(of: 1))
 
 // 배열의 추가적인 기능 - 삽입
 var array = ["a", "b", "c"]
 
 array.insert("A", at: 0)  // ["A", "a", "b", "c"]
 print(array)
 array.insert(contentsOf: ["e", "f"], at: 2)  // ["A", "a", "e", "f", "b", "c"]
 print(array)
 
 // 배열의 추가적인 기능 - 교체
 var array = ["a", "b", "c"]
 
 array[1] = "B"  // ["a", "B", "c"]
 print(array)
 array[0...1] = ["A", "b"]  // ["A", "b", "c"]
 print(array)
 array.replaceSubrange(0...2, with: ["a", "B", "C"])  // ["a", "B", "C"]
 print(array)
 
 // 배열의 추가적인 기능 - 추가
 var array = ["a", "b", "c"]
 
 array += ["d"]  // ["a", "b", "c", "d"]
 print(array)
 array.append("e")  // ["a", "b", "c", "d", "e"]
 print(array)
 array.append(contentsOf: ["f", "g"])  // ["a", "b", "c", "d", "e", "f", "g"]
 print(array)
 
 // 배열의 추가적인 기능 - 삭제
 var array = ["a", "b", "c", "d", "e", "f", "g"]
 
 array[0...1] = []  // ["c", "d", "e", "f", "g", "h", "i", "j", "k"]
 print(array)
 array.remove(at: 2)  // ["c", "d", "f", "g", "h", "i", "j", "k"]
 print(array)
 array.remove(at: array.endIndex - 1)  // ["c", "d", "f", "g", "h", "i", "j"]
 print(array)
 array.removeSubrange(0...1)  // ["f", "g", "h", "i", "j"]
 print(array)
 
 // 배열의 추가적인 기능 - 삭제
 var array = ["a", "b", "c", "d", "e", "f", "g"]
 print(array.removeFirst())  // a
 print(array)  // ["b", "c", "d", "e", "f", "g"]
 print(array.removeFirst(2))  // ()
 print(array)  // ["d", "e", "f", "g"]
 print(array.removeLast())  // g
 print(array)  // ["d", "e", "f"]
 print(array.removeLast(1))  // ()
 print(array)  // ["d", "e"]
 print(array.removeLast(2))  // ()
 print(array)  // []
 array.removeAll()  // []
 print(array)
 array.removeAll(keepingCapacity: true)  // []
 print(array)
 
 // guard statement
 func password(word: String) -> Bool {
 guard word.count != 0 else {
 print("입력해주세요.")
 return false
 }
 
 guard word.count >= 6 else {
 print("6자리 이상이어야 합니다.")
 return false
 }
 
 print("비밀번호가 변경되었습니다.")
 return true
 }
 
 var changePW: Bool = password(word: "")  // false
 // 입력해주세요.
 password(word: "abc")  // false, 6자리 이상이어야 합니다.
 password(word: "abcdef")  // true, 비밀번호가 변경되었습니다.
 
 // @discardableResult
 func name() -> String {
 return "장수지"
 }
 name()
 _ = name()
 
 @discardableResult
 func age() -> Int {
 return 20
 }
 age()
 
 // Tuple
 func info() -> (String, Int) {
 return ("장수지", 20)
 }
 print(info())  // ("장수지", 20)
 
 // [연습문제] 문자열 중에서 한글자를 랜덤으로 뽑아내는 함수
 func randomString(word: String) -> Character {
 guard let alphabet = word.randomElement() else { return " " }
 return alphabet
 }
 print(randomString(word: "장수지"))
 
 // [연습문제] 소수 판별 해보기
 func primeNumber(number: Int) {
 for i in 2..<number {
 if number % i == 0 {
 print("소수가 아닙니다")
 return
 }
 }
 print("소수입니다")
 }
 
 primeNumber(number: 97)
 
 // [연습문제] 팩토리얼 함수 만들어보기
 func factorial(number: Int) -> Int {
 var result = 1
 
 for i in 1...number {
 result *= i
 }
 
 return result
 }
 
 factorial(number: 5)
 
 // [연습문제] 재귀함수
 func factorial(num: Int) -> Int {
 if num <= 1 {
 return 1
 }
 return num * factorial(num: num - 1)
 }
 
 print(factorial(num: 5))  // 120
 
 // print 함수 직접 만들기
 func myPrint(_ item: Any..., separator: String = " ", terminator: String = "\n") {
 print(item, separator: separator, terminator: terminator)
 }
 
 myPrint("안녕", 123)
 myPrint("하세요", 4.5)
 
 // Forced Unwrapping
 let name: String? = "장수지"
 print(name)  // Optional("장수지")
 print(name!)  // 장수지
 
 let age: Int?
 //print(age)  // Error: Constant 'age' used before being initialized
 
 // nil이 아니면 강제 추출
 let name: String? = "장수지"
 
 if name != nil {
 print(name!)  // 장수지
 }
 
 // if let 바인딩 연습
 var number: Int? = 7
 var hello: String? = "안녕하세요"
 var name: String? = "홍길동"
 var newNum: Double? = 5.5
 
 if let num = number {
 print(num)
 }
 
 if let hi = hello {
 print(hi)
 }
 
 if let name = name {
 print(name)
 }
 
 if let newNum = newNum {
 print(newNum)
 }
 
 // guard let 바인딩 연습
 var number: Int? = 7
 var hello: String? = "안녕하세요"
 var name: String? = "홍길동"
 var newNum: Double? = 5.5
 
 func doPrint(num: Int?) {
 guard let n = num else { return }
 print(n)
 }
 
 doPrint(num: number)
 
 func hi(say: String?) {
 guard let sayHi = say else { return }
 print(sayHi)
 }
 
 hi(say: hello)
 
 func introduce(word: String?) {
 guard let name = word else { return }
 print(name)
 }
 
 introduce(word: name)
 
 func writeDouble(num: Double?) {
 guard let n = num else { return }
 print(n)
 }
 
 writeDouble(num: newNum)
 
 // 옵셔널 파라미터
 func information(name: String, age: Int? = nil) {
 guard let number = age else {
 print(name)
 return
 }
 print("이름: \(name), 나이: \(number)")
 }
 
 information(name: "장수지")  // 디폴트값 nil 설정 없을 시 오류
 information(name: "장수지", age: nil)
 information(name: "장수지", age: 20)
 
 // 배열의 추가기능
 // 오름차순
 var numArray: Array = [0, 5, 2, 1, 2, 3, 3, 1]
 
 // 동사원형: 배열 자체 변경
 numArray.sort()
 print(numArray)
 
 // -ed 또는 -ing: 배열 자체는 건들지 않고 리턴값만 변경
 numArray = [0, 5, 2, 1, 2, 3, 3, 1]
 numArray.sorted()
 print(numArray)
 print(numArray.sorted())
 
 // 역순
 var numArray: Array = [0, 5, 2, 1, 2, 3, 3, 1]
 
 let reversedArray: Array = numArray.reversed()  // 역순
 // 배열 자체를 바꾸는게 아니라 변환한 것을 리턴하는 것이기 때문에 앞으로도 필요하면 새로운 상수에 담아준다
 
 print(reversedArray)
 // reversedArray를 타입 주석으로 했을때: [1, 3, 3, 2, 1, 2, 5, 0]
 // reversedArray를 타입 추론으로 했을때: ReversedCollection<Array<Int>>(_base: [0, 5, 2, 1, 2, 3, 3, 1])
 
 // 내림차순: 오름차순 정렬 -> 역순
 print(numArray.sorted().reversed())  // ReversedCollection<Array<Int>>(_base: [0, 1, 1, 2, 2, 3, 3, 5])
 
 numArray.sort()
 numArray.reverse()
 print(numArray)  // [5, 3, 3, 2, 2, 1, 1, 0]
 
 // 랜덤 정렬
 var numArray: Array = [0, 5, 2, 1, 2, 3, 3, 1]
 
 let newArray: Array = numArray.shuffled()
 print(newArray)  // [5, 0, 3, 1, 2, 1, 3, 2]
 
 numArray.shuffle()  // let이면 때문에 오류
 print(numArray)  // [1, 1, 0, 3, 2, 3, 5, 2]
 
 // 배열의 비교
 let a = [0, 1, 2]
 let b = [2, 1, 0]
 
 a == b  // false
 
 // 요소를 인덱스로 찾아서 지우기
 var word: [String] = ["r", "a", "i", "n", "n", "i", "n", "g"]
 
 if let haveN = word.lastIndex(of: "n") {
 word.remove(at: haveN)
 print(word)
 }
 // ["r", "a", "i", "n", "n", "i", "g"]
 
 func removeN(word: [String]) {
 var newWord = word
 guard let haveN = word.lastIndex(of: "n") else {
 print("no 'n'")
 return
 }
 newWord.remove(at: haveN)
 print(newWord)
 }
 
 removeN(word: ["r", "a", "i", "n", "n", "i", "n", "g"])
 // ["r", "a", "i", "n", "n", "i", "g"]
 
 // 빈배열 확인, 요소 개수 세기
 func isEmptyArray(array: [Int]) {
 if array.isEmpty {
 print("\(array) is empty")
 } else {
 print("\(array) has \(array.count) elements")
 }
 }
 
 let a = [0, 1]
 let b: [Int] = []  // 빈배열은 명시적이어야 한다
 
 isEmptyArray(array: a)
 isEmptyArray(array: b)
 
 // 배열의 중첩
 let a = [["a", "b"], ["c", "d", "e"], ["f"]]
 
 print(a[0][1])  // b
 
 // 배열의 요소 하나씩 꺼내기
 let word = ["a", "p", "p", "l", "e"]
 var count: Int = 0
 
 for item in word {
 print("\(count): \(item)")
 count += 1
 }
 
 // 자동으로 인덱스 확인하기
 let word: [String] = ["a", "p", "p", "l", "e"]
 
 for item in word.enumerated() {
 print(item)
 }
 // (offset: 0, element: "a")
 // (offset: 1, element: "p")
 // (offset: 2, element: "p")
 // (offset: 3, element: "l")
 // (offset: 4, element: "e")
 
 for (index, item) in word.enumerated() {
 print("\(index): \(item)")
 }
 // 0: a
 // 1: p
 // 2: p
 // 3: l
 // 4: e
 
 for item in word.enumerated().reversed() {
 print("\(item.0): \(item.1)")
 }
 // 4: e
 // 3: l
 // 2: p
 // 1: p
 // 0: a
 
 // 빈 딕셔너리 생성
 let dic: Dictionary<Int, Int> = [:]
 let dic1: [Int: String] = [:]
 let dic2 = Dictionary<String, String>()
 let dic3 = [Double: Int]()
 
 // 딕셔너리의 기본기능
 let numDictionary = ["one": 1, "two": 2, "three": 3]
 
 // 딕셔너리 요소의 개수
 print(numDictionary.count)  // 3
 
 // 빈 딕셔너리 확인
 print(numDictionary.isEmpty)  // false
 
 // 포함 판별
 // numDictionary.contains(where: /)
 
 // 랜덤값
 print(numDictionary.randomElement())  // Optional((key: "one", value: 1))
 if let numDict = numDictionary.randomElement() {
 print(numDict)
 }  // (key: "three", value: 3)
 
 // 딕셔너리의 각 요소에 접근: 키값으로 접근
 let numDictionary = ["one": 1, "two": 2, "three": 3]
 
 print(numDictionary["one"])  // Optional(1)
 
 if let value = numDictionary["one"] {
 print(value)
 } else {
 print("Not found")
 }  // 1
 
 // 참고: 기본값을 줘서 nil이 나오지 않음
 print(numDictionary["four", default: 0])  // 0
 
 // 묶음
 let numDictionary = ["one": 1, "two": 2, "three": 3]
 
 print(numDictionary.keys)  // ["one", "two", "three"]
 print(numDictionary.values)  // [2, 1, 3]
 
 for numKeys in numDictionary.keys.sorted() {
 print(numKeys)
 }  // one three two
 
 for numValues in numDictionary.values.sorted() {
 print(numValues)
 }  // 1 2 3
 
 // dictionary - update
 var dict: [String: String] = [:]
 
 // Subscript 문법
 dict["a"] = "apple"  // 동일한 키가 없으면 추가하기  // "apple"
 print(dict)  // ["a": "apple"]
 
 dict["a"] = "ant"  // 동일한 키가 있으면 덮어쓰기  // "ant"
 print(dict)  // ["a": "ant"]
 
 // 함수 문법
 dict.updateValue("blue", forKey: "b")  // nil
 print(dict)  // ["b": "blue", "a": "ant"]
 
 dict.updateValue("bee", forKey: "b")  // "blue"
 print(dict)  // ["b": "bee", "a": "ant"]
 
 // 전체 교체
 dict = ["a": "a"]
 print(dict)  // ["a": "a"]
 
 dict = [:]
 print(dict)  // [:]
 
 // dictionary - remove
 var dict = [1: 111, 2: 222, 3: 333, 4: 444, 5: 555]
 
 // Subscript 문법
 dict[1] = nil  // 현재값 리턴  // nil
 print(dict)  // [2: 222, 3: 333, 4: 444, 5: 555]
 
 dict[3] = nil  // nil
 
 
 // 함수 문법
 dict.removeValue(forKey: 2)  // 삭제값 리턴  // 222
 print(dict)  // [4: 444, 5: 555]
 
 dict.removeValue(forKey: 2)  // nil
 
 
 // 전체 삭제
 dict.removeAll()
 dict.removeAll(keepingCapacity: true)  // 메모리 공간은 유지
 print(dict)  // [:]
 
 // 딕셔너리 비교
 let a = [1: 111, 2: 222, 3: 333]
 let b = [2: 222, 1: 111, 3: 333]
 print(a == b)  // true
 
 // 딕셔너리 중첩 - 배열
 var dict = [Int: [String]]()
 
 dict[1] = ["배열", "중첩", "가능"]
 print(dict)  // [1: ["배열", "중첩", "가능"]]
 
 // 딕셔너리 중첩 - 딕셔너리
 let dict1 = ["딕셔너리": ["중첩": "가능"]]
 // (type) let dict1: [String : [String : String]]
 print(dict1)  // ["딕셔너리": ["중첩": "가능"]]
 
 // 딕셔너리와 반복문
 let dict = [1: "one", 2: "two", 3: "three"]
 
 for (key, value) in dict {
 print("key: \(key) / value: \(value)")
 }  // key: 1 / value: one key: 2 / value: two key: 3 / value: three
 
 for (key, _) in dict {
 print("key: \(key)")
 }  // key: 1 key: 2 key: 3
 
 for (_, value) in dict {
 print("value: \(value)")
 }  // value: one value: two value: three
 
 // set 표기법
 // 정식 문법
 let set: Set<Int> = []
 
 // 단축 문법
 let set1: Set = [1, 2]
 
 // 빈 set 생성
 let set = Set<String>()
 let set1: Set<Double> = []
 
 // set의 기본기능
 let set: Set = [1, 2, 3]
 
 // 개수 세기
 print(set.count)  // 3
 
 // 빈 Set 판별
 print(set.isEmpty)  // false
 
 // 요소 포함 여부 판별
 print(set.contains(2))  // true
 
 // 랜덤 요소 리턴
 print(set.randomElement())  // Optional(1)
 
 // set - update
 var set: Set = [1, 2, 3]
 
 set.update(with: 4)  // nil
 print(set)  // [1, 3, 4, 2]
 
 set.update(with: 1)  // 1
 print(set)  // [1, 3, 4, 2]
 
 // set - remove
 var set: Set = [1, 2, 3, 4, 5]
 
 set.remove(1)  // 1
 print(set)  // [3, 2, 4, 5]
 
 set.remove(6)  // nil  // 오류 안남
 
 // 전체 삭제
 set.removeAll()
 set.removeAll(keepingCapacity: true)  // 메모리 공간은 남기고 전체 삭지
 print(set)  // []
 
 // set 비교
 var set1: Set = [1, 1, 1, 2, 2, 3, 4]
 var set2: Set = [1, 2]
 var set3: Set = [3, 4]
 var set4: Set = [1, 2, 3, 4]
 var set5: Set = [1, 1, 1, 2, 2, 3, 4]
 
 set1 == set4  // true
 set1 != set5  // false
 
 // 부분집합
 set1.isSubset(of: set2)  // false
 set2.isSubset(of: set1)  // true
 
 // 진부분집합
 set2.isStrictSubset(of: set1)  // true
 set4.isStrictSubset(of: set1)  // false
 set5.isStrictSubset(of: set1)  // false
 
 // 상위집합
 set1.isSuperset(of: set2)  // true
 set2.isSuperset(of: set1)  // false
 
 // 진상위집합
 set1.isStrictSuperset(of: set2)  // true
 set1.isStrictSuperset(of: set4)  // false
 set1.isStrictSuperset(of: set5)  // false
 
 // 서로소
 set1.isDisjoint(with: set2)  // false
 set2.isDisjoint(with: set3)  // true
 
 // 합집합
 print(set2.union(set3))  // [2, 4, 1, 3]
 print(set2)  // [2, 1]
 print(set3)  // [4, 3]
 
 print(set2.formUnion(set3))  // ()
 print(set2)  // [1, 2, 4, 3]
 print(set3)  // [4, 3]
 print("---")
 
 // 교집합
 print(set1.intersection(set3))  // [4, 3]
 print(set1)  // [2, 3, 4, 1]
 print(set3)  // [4, 3]
 
 print(set4.formIntersection(set3))  // ()
 print(set4)  // [3, 4]
 print(set3)  // [4, 3]
 print("---")
 
 // 차집합
 print(set1.subtracting(set3))  // [2, 1]
 
 print(set2.subtract(set3))  // ()
 print(set2)  // [2, 1]
 print("---")
 
 // 대칭차집합
 print(set1.symmetricDifference(set4))  // [2, 1]
 
 print(set5.formSymmetricDifference(set2))  // ()
 print(set5)  // [4, 3]
 
 // Set과 반복문
 let set1: Set = [0, 0, 0, 1]
 
 for num in set1 {
 print(num)
 }  // 1 0
 
 // copy on write 예시
 var array = [1, 2, 3, 4, 5, 6, 7]
 // 이 배열은 어떤 공간에 1, 2, 3, 4, 5, 6, 7을 계속 담고 있다
 
 var subArray = array[0...2]  // Copy On Write 최적화가 일어날 수 있다
 // 여기서 1, 2, 3만 사용하려고 subArray에 바꿔서 담았지만
 // subArray라는 새로운 메모리 공간을 만들지 않을 수도 있다
 // 왜냐하면 array가 큰 메모리 공간을 차지하고 있고
 // 거기서 일부분만을 사용하기 때문에
 // 아예 새로운 변수로 새로운 메모리 공간을 만든다기보다는
 // 그냥 주소만 가리키게 해서 array 전체 메모리에서 일부분만 사용하는 개념
 
 // KeyValuePairs
 var newDict: KeyValuePairs = [1: "one", 2: "two", 3: "three"]
 
 newDict.count  // 3
 newDict.isEmpty  // false
 
 print(newDict[0])  // (key: 1, value: "one")
 print("0번째 키: \(newDict[0].0) / 0번째 값: \(newDict[0].1)")
 // 0번째 키: 1 / 0번째 값: one
 print("1번째 키: \(newDict[1].key) / 1번째 값: \(newDict[1].value)")
 // 1번째 키: 2 / 1번째 값: two
 
 var count = 0
 for item in newDict {
 print("\(count)번째: \(item)")
 count += 1
 }
 // 0번째: (key: 1, value: "one")
 // 1번째: (key: 2, value: "two")
 // 2번째: (key: 3, value: "three")
 
 // Copy-On-Write
 let array = [1, 2, 3, 4, 5]
 
 let copyArray = array[0...1]
 // Copy-On-Write 최적화가 일어날 수 있다
 
 // enum 예시
 enum School {  // 한정된 사례에서 다룰 수 있는 타입
 case elementary
 case middle
 case high
 case university
 }
 
 // 타입이니까 대문자로 시작하고 변수에 넣어서 사용할 수 있다
 // School만 쓰면 타입 자체니까 .으로 접근 -> 타입 안에 있는 명확한 그 케이스
 // 정수라고 치면 숫자 1처럼 케이스 값을 의미
 // var school: Int = 1
 var school:School = School.elementary
 
 // 열거형
 // 타입정의
 enum 타입이름 {
 case 사례1, 사례2
 }
 
 enum Clothes {
 case hoodie
 case shirts
 }
 
 // 사용
 let hat: Clothes = .hoodie
 
 // switch문으로 분기처리
 switch hat {
 case .hoodie:
 print("후드에는 모자가 있다")
 case Clothes.shirts:
 print("셔츠에는 모자가 없다")
 }  // 후드에는 모자가 있다
 
 // 원시값(rawValue)
 enum Apple: Int {
 case iPhone
 case iPad = 2
 case Mac
 }
 
 var wishList = Apple(rawValue: 0)
 var uniqueNumber = Apple.Mac.rawValue
 print(wishList)  // Optional(__lldb_expr_15.Apple.iPhone)
 print(uniqueNumber)  // 3
 
 if let cart = wishList {
 print("장바구니에 \(cart)를 담았다")
 }
 // 장바구니에 iPhone를 담았다
 
 // 연관값(Associated Value)
 enum Character {
 case sanrio(name: String, kind: String)
 case kakaoFriends(name: String, kind: String)
 }
 
 let keyring = Character.sanrio(name: "kitty", kind: "cat")
 
 switch keyring {
 case let .sanrio(_, b):
 print("\(b)키링")
 case .kakaoFriends(let a, let b):
 print("\(a)키링은 \(b)")
 }  // cat키링
 
 // 옵셔널 타입 정의
 enum Optional<Wrapped> {
 case some(Wrapped)
 case none
 }
 
 // 옵셔널 인트
 enum OptionalInt {
 case some(Int)
 case none
 }
 
 // 옵셔널 사용
 let num: OptionalInt = OptionalInt.some(1)
 let noneCase = OptionalInt.none
 
 // if let 바인딩 원리
 switch noneCase {
 case let .some(a):
 print(a)
 case .none:
 print("nil")
 }
 
 // 옵셔널 열거형
 enum Step {
 case up
 case down
 }
 
 let choice: Step? = Step.up
 let cancel: Step? = .down
 
 // switch문 2번 사용
 switch choice {
 case let .some(a):
 switch a {
 case Step.up:
 print("up")
 case .down:
 print("down")
 }
 case .none:
 print("stop")
 }  // up
 
 // 편의적 기능 - 예전: 옵셔널일때 내부 접근 불가
 switch choice! {
 case Step.up:
 print("up")
 case .down:
 print("down")
 }  // up
 
 // 편의적 기능 - 요즘: 옵셔널 벗기지 않아도 내부값 접근 가능
 switch cancel {
 case .up:
 print("up")
 case .down:
 print("down")
 case .none:
 print("stop")
 }  // down
 
 // 연관값 - if문 case: 한가지 케이스 처리, 조건
 enum PencilCase {
 case pen(color: String, ea: Int)
 case etc(kind: String, ea: Int)
 }
 
 let bag: PencilCase = .pen(color: "pink", ea: 2)
 
 switch bag {
 case .pen(color: _, ea: _):
 print("가방에 펜이 있다")
 default:
 break
 }
 // 가방에 펜이 있다
 
 if case .pen(let color, let ea) = bag, ea > 0 {
 print("가방에 펜이 있다")
 }
 // 가방에 펜이 있다
 
 // 연관값 - for문 case: 특정 케이스만 뽑아내기
 let myPencilCase: [PencilCase] = [
 .pen(color: "black", ea: 2),
 .pen(color: "red", ea: 1),
 .pen(color: "blue", ea: 1),
 .etc(kind: "ruler", ea: 1),
 .etc(kind: "eraser", ea: 3),
 .etc(kind: "X-Acto", ea: 1),
 .etc(kind: "highlighter", ea: 5)
 ]
 
 for case PencilCase.etc(kind: let something, ea: _) in myPencilCase {
 print("필통에 \(something)가 있다")
 }
 // 필통에 ruler가 있다
 // 필통에 eraser가 있다
 // 필통에 X-Acto가 있다
 // 필통에 highlighter가 있다
 
 // 연관값 - for문 case: 옵셔널 배열에서 nil 제외하고 뽑아내기
 let names: [String?] = ["수지", nil, "수진"]
 
 for case let .some(name) in names {
 print("\(name)")
 }
 // 수지 수진
 
 for case .none in names {
 print("nil값이 있다")
 }
 
 // 옵셔널 패턴
 // switch문에서
 enum Song {
 case singer(name: String)
 case title
 }
 
 let favoriteSinger: Song? = .singer(name: "IU")
 
 switch favoriteSinger {
 //case .some(let singer):
 case let singer?:
 print("가수: \(singer)")
 case .none:
 print("empty")
 }
 // 가수: singer(name: "IU")
 
 // if문에서
 //if case .some(let singer) = favoriteSinger {
 if case let singer? = favoriteSinger {
 print("가수: \(singer)")
 }
 
 // for문에서
 let playList: [String?] = ["관객이 될게", "작별인사", nil, "Architect"]
 var count = 1
 
 //for case .some(let title) in playList {
 for case let title? in playList {
 print("\(count). \(title)")
 count += 1
 }
 // 1. 관객이 될게
 // 2. 작별인사
 // 3. Architect
 
 // unknown 키워드
 enum Genre {
 case rhythmNblues
 case jazz
 case hiphop
 }
 
 let song = Genre.hiphop
 
 // 논리적 오류 없음
 switch song {  // 경고: Switch must be exhaustive
 case .rhythmNblues:
 print("This song is rhythmNblues")
 case .jazz:
 print("This song is jazz")
 //case .hiphop:
 //    print("This song is hiphop")
 @unknown default:
 print("Not found")
 }  // Not found
 
 // 클래스 - 도서관리 프로그램 만들기
 // 틀 만들기
 class Book {
 var name = "책제목"
 var price = 0
 var pages = 100
 }
 
 // 책을 반복적으로 찍어내서 만들 수 있다
 var book1 = Book()  // 변수를 만들고 클래스를 찍어낸다
 book1.name = "스위프트"
 book1.price = 30000
 book1.pages = 300
 
 book1.name  // 스위프트
 book1.price  // 30000
 book1.pages  // 300
 
 // 장점: 클래스를 만들면 무한대로 찍어낼 수 있다
 var book2 = Book()
 book2.name = "알고리즘"
 book2.price = 50000
 book2.pages = 500
 
 book2.name  // 알고리즘
 book2.price  // 50000
 book2.pages  // 500
 
 // 구조체
 struct Bird {
 var name = "새"
 var weight = 0.0
 
 func fly() {
 print("날아갑니다.")
 }
 }
 
 func doSomething() {
 var aBird = Bird()
 // 클래스를 찍어내는 것과 똑같이
 // Bird라고 하고 ()하면 붕어빵을 하나 찍어내서 변수에 담음
 
 aBird.name  // 새
 aBird.name == "참새1"
 aBird.name  // 참새1
 
 var bBird = Bird()
 bBird.name  // 새
 bBird.name == "참새2"
 bBird.name  // 참새2
 
 var cBird = Bird()
 cBird.name == "참새3"
 cBird.name  // 참새3
 }
 
 doSomething()
 
 // 클래스
 class 클래스명 {
 var property = "속성"
 
 func method() {
 // 메서드
 }
 }
 
 var instance = 클래스명()
 var objcet = 클래스명()
 
 // 클래스 - 메모리 영역
 class Snack {
 var name = "과자"
 
 func printList() {
 print("\(name)")
 }
 }
 
 var chips = Snack()
 chips.name = "스윙칩"
 
 // 구조체
 struct 구조체명 {
 var property = "속성"
 
 func method() { }
 }
 
 var instance = 구조체명()
 
 // 구조체 - 메모리 영역
 struct Beverage {
 var name = "주스"
 
 func printList() {
 print(name)
 }
 }
 
 func doSomething() {
 var orangeJuice = Beverage()
 orangeJuice.name = "orange juice"
 }
 
 // 클래스 vs. 구조체
 class Pen {
 var color = "검정"
 }
 
 struct Snack {
 var name = "스윙칩"
 }
 
 // 메모리 복사
 var pen1 = Pen()
 print(pen1.color)  // 검정
 
 var pen2 = pen1
 pen2.color = "파랑"
 print(pen1.color)  // 파랑
 
 var snack1 = Snack()
 
 var snack2 = snack1
 snack2.name = "쿠쿠다스"
 print(snack1.name)  // 스윙칩
 print(snack2.name)  // 쿠크다스
 
 // let / var
 let pen = Pen()
 pen.color = "노랑"
 
 let snack = Snack()
 //snack.name = "뺴뺴로"  // error: Cannot assign to property: 'snack' is a 'let' constant
 
 // 초기화 - 예제
 // 변수 생성 - 정식 문법: 처음부터 안녕하세요 담을 수 있다
 var a: String = "안녕하세요"
 // 클래스도 처음부터 만들어낼 때 데이터를 담을 수 있다
 // 그걸 가능하게 해주는 클래스 안의 메서드를 생성자(initializer)라고 한다
 
 // 메모리 공간만 생성 -> 나중에 안녕하세요 담을 수 있다
 var b: String
 b = "안녕하세요"
 
 // 초기화 - 예제
 class Dog {
 var name: String
 // 처음부터 강아지라고 세팅하는게 아니라 타입만 선언
 var weight: Double
 // 붕어빵을 찍어낼 때 그 붕어빵의 요소, 붕어빵의 멤버 즉,
 // name은 문자열 타입이고 weight은 더블형 타입이다
 
 // 함수를 정의하듯이 func가 아닌 init이라고 한다
 init(n: String, w: Double) {
 name = n
 weight = w
 }
 // init자체가 함수의 이름이자 특별한 형식
 // func를 없애고 어떤 함수의 이름을 init이라고 통일한 것
 }
 
 //var bori = Dog(n: <#T##String#>, w: <#T##Double#>)
 // Dog를 생성하려면 기존에는 기본값이 다 설정돼 있어서 Dog()로만 생성할 수 있었는데
 // Dog를 생성하려면 이제는 파라미터에 두가지를 줘야한다
 
 var bori = Dog(n: "보리", w: 15.0)
 // 이것도 생성하는것, 붕어빵을 찍어내는 것
 // Dog이라는 클래스로부터 실제 데이터를 찍어내는 행위
 // 보리, 15.0이라는 실제 데이터를 가지고 찍어내는 것
 
 bori.name  // 보리
 // 이름이 벌써 보리가 돼있다
 // 강아지라고 찍고 나서 나중에 이름을 바꿀 필유가 없어진다
 // 데이터를 생성할 때마다 실제 데이터를 가지고 붕어빵을 찍어낼 수 있다
 
 // 초기화 - 예제
 class Dog {
 var name: String
 var weight: Double
 
 // 일반적으로 이렇게 쓰는데 구분이 안된다
 // 그래서 헷갈리지 않도록 명확하게 지칭할 수 있는 self가 필요하다
 init(name: String, weight: Double) {
 self.name = name  // 인스턴스의 name = 파라미터의 name
 self.weight = weight
 }
 // self: 인스턴스, 실제 데이터의 이름을 의미
 // self를 안쓰면 에러: Cannot assign to value: 'name' is a 'let' constant
 // 동일한 파라미터 이름을 쓰면 가장 가까운게 init의 파라미터이기 때문에
 // 무조건 그냥 파라미터로 인식해서 에러가 난다
 // 그래서 name이 파라미터가 아니라 인스턴스의 네임이라고 지칭을 해줘야 한다
 // self.name은 위의 var name을 의미한다
 }
 // 이거는 클래스고 여기서 보리라는 데이터를 찍어낼 건데
 
 var bori = Dog(name: "보리", weight: 15.0)
 // 이거는 실제 데이터
 // 어떤 메모리 공간에 name이라는 공간과 weight이라는 공간이 힙 영역에 생긴다
 // 그 실제 데이터(=인스턴스)를 가리키는 용어가 self
 // 인스턴스의 name을 의미: 찍어냈을 때 그 name의 데이터를 의미
 
 // initializer
 class 클래스명 {
 var 변수명: String
 
 init(파라미터명: String) {
 self.변수명 = 파라미터명
 }
 }
 
 var instance = 클래스명(파라미터명: "데이터")
 
 // 옵셔널 타입 초기화 - 예제
 var a: String
 //print(a)  // error: Variable 'a' used before being initialized
 a = "안녕하세요"
 // 순서를 바꾸면 변수가 초기화되지 않았다고 에러가 난다
 // a라는 변수가 들어있는 메모리 영역에 갔더니 메모리에 아무것도 안들어있다
 // 그러면 에러가 날 수 있다, 앱이 꺼진다
 // 반드시 변수를 선언한 다음에 데이터를 넣고
 // 데이터가 있는 상태에서 접근을 해야 앱이 꺼지지 않는다
 
 // 옵셔널 타입: 값이 없는 경우에는 nil이라는 키워드를 가질 수 있다
 var b: String?
 print(b)  // nil
 // 안녕하세요를 집어넣지 않더라도 print를 통해 b 변수에 접근해보면 nil이 나온다
 // nil: 실제로 값이 없는게 아니고 값이 없음을 나타내는 키워드
 // enum타입을 통해 값이 없음을 나타내는 키워드
 
 // 클래스에서 옵셔널 타입 초기화 - 예제
 // 정석
 class Dog1 {
 var name: String
 
 init(name: String) {
 self.name = name
 }
 }
 
 // 무조건 강아지로 초기화
 class Dog3 {
 var name: String
 
 init() {
 self.name = "강아지"
 }
 } // 문자열로 선언했고 생성자 안에서 강아지 값을 넣어주고 있기 때문에 가능
 
 class Dog2 {
 var name: String
 
 init(name: String) {
 self.name = "강아지"
 }
 }  // 이런것도 가능하지만 이렇게하진 않음
 
 // 함수에서 기본값을 주는 것처럼 기본값을 세팅
 class Dog {
 var name: String
 
 init(name: String = "강아지") {
 self.name = name
 }
 }
 
 // 기본값을 제시해줬기 때문에 name없이도 생성가능
 var dog = Dog()  // 강아지
 var dog1 = Dog(name: "보리")  // 보리
 
 // 옵셔널 타입 속성
 class Pen {
 var color: String?
 //init() { }
 }
 
 var pen = Pen()
 print(pen.color)  // nil
 
 // 도서 관리 프로그램
 class Book {
 var name: String
 var price: Int
 var company: String
 var author: String
 var pages: Int
 
 init(name: String, price: Int, company: String, author: String, pages: Int) {
 self.name = name
 self.price = price
 self.company = company
 self.author = author
 self.pages = pages
 }
 }
 
 var book1 = Book(name: "스위프트", price: 30000, company: "애플", author: "잡스", pages: 300)
 var book2 = Book(name: "재밌는소설", price: 5000, company: "잼컴퍼니", author: "웃긴녀석들", pages: 200)
 book2.name  // 재밌는소설
 book2.company = "JamCompany"
 
 // 영화 정보 프로그램
 class Movie {
 var name: String
 var jenre: String
 var actor: String
 var director: String
 var day: String
 
 init(name: String, jenre: String, actor: String, director: String, day: String) {
 self.name = name
 self.jenre = jenre
 self.actor = actor
 self.director = director
 self.day = day
 }
 }
 
 var movie1 = Movie(name: "새콤달콤", jenre: "로맨틱코미디", actor: "채수빈", director: "몰라", day: "20210610")
 
 // 회원 관리 프로그램
 struct Member {
 var name: String
 var gender: String
 var age: Int
 var address: String
 
 init(name: String, gender: String, age: Int, address: String) {
 self.name = name
 self.gender = gender
 self.age = age
 self.address = address
 }
 }
 
 var suji = Member(name: "장수지", gender: "여자", age: 20, address: "서울")
 
 // 날씨 프로그램
 struct Wether {
 var state: String
 var temperature: Int
 var fineDust: Double?
 var day: String
 
 init(state: String, temperature: Int, day: String) {
 self.state = state
 self.temperature = temperature
 self.day = day
 }
 }
 
 var today = Wether(state: "비", temperature: 9, day: "20240424")
 
 // 지연저장속성 - 예제
 func doSomething() -> Double {
 return 0.5
 }
 // 무조건 0.5를 리턴하는 함수
 
 struct Bird {
 lazy var name = "새"
 lazy var weight = doSomething()
 
 init() {
 //self. weight ??
 }
 }
 
 // 초기화
 class Pen {
 var color: String = "검정"
 }
 
 // 초기화
 var highlighter = Pen()
 
 // 속성들
 class Pen {
 var color: String  // Stored Property
 lazy var price: Int = 0  // Lazy Stored Property
 
 init(color: String) {
 self.color = color
 }
 }
 
 // 함수 복습
 // 2개의 숫자를 더하는 함수
 func addTwoNumber(_ a: Int, _ b: Int) -> Int {
 var c = a + b
 return c
 }
 
 var x = addTwoNumber(3, 4)
 var y = addTwoNumber(5, 6)
 
 // 클래스의 메서드
 class Dog {
 var name: String
 var weight: Int
 
 init(name: String, weight: Int) {
 self.name = name
 self.weight = weight
 }
 
 func sit() {
 print("\(self.name)가 앉았습니다.")
 }
 
 func layDown() {
 print("\(self.name)가 엎드렸습니다")
 }
 }
 
 var bori = Dog(name: "보리", weight: 15)
 var choco = Dog(name: "초코", weight: 10)
 
 class Dog {
 var name: String
 
 init(name: String) {
 self.name = name
 }
 
 func sit() {
 print("\(name)가 앉았습니다")
 }
 }
 
 var bori = Dog(name: "보리")
 bori.sit()
 
 // 계산속성 예제
 class Person {
 var birth: Int = 0
 
 // 계산속성
 var age: Int {
 get {
 return 2024 - birth
 }
 set(age) {
 self.birth = 2024 - age
 }
 }
 
 //    func getAge() -> Int {
 //        return 2024 - birth
 //    }
 //
 //    func setAge(_ age: Int) {
 //        self.birth = 2024 - age
 //    }
 }
 
 var p1 = Person()
 p1.birth = 2000
 p1.age  // get  // 24
 p1.age = 20  // set
 p1.birth  // 2004
 
 //p1.getAge()  // 24
 //p1.setAge(29)
 //p1.birth  // 1995
 
 // 속성
 class Pen {
 static var kind: Int = 0  // Stored Type Property(공유)
 static let pi = 3.14  // Stored Type Property(불변)
 
 static var area: Double {  // Computed Type Property
 return pi * 2 * 2
 }
 
 var ea: Int  // Stored Property
 lazy var color: String = "검정"  // Lazy Stored Property
 
 var price: Int {  // Coputed Property
 get {
 return ea * 3000
 }
 set(price) {
 self.ea = price / 3000
 }
 }
 
 var status: String = "good" {  // Property Observer
 willSet {
 print("상태: \(status)->\(newValue)")
 }
 didSet {
 print("상태: \(oldValue)->\(status)")
 }
 }
 
 init(ea: Int) {
 self.ea = ea
 Pen.kind += 1
 }
 }
 
 var highlighter = Pen(ea: 2)
 highlighter.price  // 6000
 highlighter.price = 9000
 highlighter.ea  // 3
 Pen.kind  // 1
 
 var marker = Pen(ea: 1)
 Pen.kind  // 여러 인스턴스들 공유: 2
 Pen.area  // 12.56
 marker.status = "bad"  // 상태: good->bad
 
 // Stored Property
 struct 구조체명 {
 let 상수명: String
 var 변수명: String
 
 init(파라미터명1: String, 파라미터명2: String) {
 self.상수명 = 파라미터명1
 self.변수명 = 파라미터명2
 }
 }
 var 인스턴스명 = 구조체명(파라미터명1: "저장속성1", 파라미터명2: "저장속성2")
 인스턴스명.변수명 = "접근가능"
 
 // Lazy Stored Property
 struct 구조체명 {
 lazy var 변수명: String = "기본값/초기값 필수"
 }
 var 인스턴스명 = 구조체명()
 print(인스턴스명.변수명)  // 기본값/초기값 필수
 
 // Coputed Property
 struct 구조체명 {
 var 저장속성: String = "저장속성"
 var 변수명: String {
 get {
 return self.저장속성 + "과 연산한 결과를 변수에 저장"
 }
 set {
 self.저장속성 = newValue + "에 의해 바뀐 값을 저장속성에 저장"
 }
 }
 }
 var 인스턴스명 = 구조체명()
 print(인스턴스명.변수명)  // 저장속성과 연산한 결과를 변수에 저장
 
 인스턴스명.변수명 = "새로운 변수명 셋팅"
 print(인스턴스명.저장속성)  // 새로운 변수명 셋팅에 의해 바뀐 값을 저장속성에 저장
 print(인스턴스명.변수명)  // 새로운 변수명 셋팅에 의해 바뀐 값을 저장속성에 저장과 연산한 결과를 변수에 저장
 
 class Pen {
 var price: Int = 3000
 var ea: Int = 3
 var total: Int {
 get {
 return price * ea
 }
 set {
 self.ea = newValue / price
 }
 }
 }
 var pen = Pen()
 pen.total
 pen.total = 12000
 pen.ea
 pen.price
 
 // Stored Type Property
 struct 구조체명 {
 static let 저장타입속성1 = "불변"
 static var 저장타입속성2 = "이 구조체에 의해 만들어진 모든 인스턴스들과 공유"
 
 init() {
 구조체명.저장타입속성2 += "+"
 }
 }
 let 인스턴스1 = 구조체명()
 구조체명.저장타입속성2  // +
 var 인스턴스2 = 구조체명()
 구조체명.저장타입속성2  // ++
 
 // Coputed Type Property
 struct 구조체명 {
 static var 저장타입속성: String = "저장타입속성"
 static var 계산타입속성: String {
 get {  // 인스턴스 멤버 저장속성과는 연산할 수 없다
 return 저장타입속성 + "과 연산해서 계산타입속성에 저장"
 }
 set {
 저장타입속성 = newValue + "에 의해 바뀐 저장타입속성으로 재할당"
 }
 }
 }
 print(구조체명.계산타입속성)  // 저장타입속성과 연산해서 계산타입속성에 저장
 구조체명.계산타입속성 = "새로운 계산타입속성 셋팅"
 print(구조체명.저장타입속성)  // 새로운 계산타입속성 셋팅에 의해 바뀐 저장타입속성으로 재할당
 
 // Property Observer
 struct 구조체명 {
 var 저장속성 = "처음 저장속성" {
 willSet {  // 값 변화 전 저장속성 = 처음 저장속성
 print("\(저장속성) -> \(newValue)")
 }
 didSet {  // 값 변화 후 저장속성 = 새로운 저장속성
 print("\(oldValue) -> \(저장속성)")
 }
 }
 }
 var 인스턴스 = 구조체명()
 인스턴스.저장속성 = "새로운 저장속성"
 // 처음 저장속성 -> 새로운 저장속성
 // 처음 저장속성 -> 새로운 저장속성
 
 // 오버로딩 예제
 struct Dog2 {
 var name: String
 var weight: Double
 
 init(name: String, weight: Double) {
 self.name = name
 self.weight = weight
 }
 
 func sit() {
 print("\(name)가 앉았습니다")
 }
 
 // 오버로딩: 동일한 이름을 붙인 sit이라는 함수를 또 만들 수 있다
 func sit(a: String) {
 print(a)
 }
 
 mutating func changeName(newName name: String) {
 self.name = name
 }
 }
 // sit이라는 이름을 가진 메서드가 2개
 // 이런식으로 오버로딩이 적용될 수 있다
 var d777 = Dog2(name: "뽀리", weight: 10)
 d777.sit()
 d777.sit(a: "안녕")
 
 // Method - class
 // 상위클래스
 class Dog {
 var name: String
 
 init(name: String) {
 self.name = name
 }
 
 func printName() {  // Instance Method - 기본
 print(name)
 }
 
 // Overloading
 func printName(nickname name: String) {
 print(name)
 }
 
 // Instance Method - 저장 속성 변경
 func changeName(newName name: String) {
 self.name = name
 }
 
 static func printClass() {  // Type Method - static
 print("class Dog")
 }
 
 class func superDog() {  // Type Method - class
 print("Dog")
 }
 
 subscript(tag: String) -> String {  // (Instance)Subscript
 get {
 return tag + name
 }
 set {
 self.name = newValue + "new" + name
 }
 }
 
 class subscript(tag: Int) -> Int {
 return tag
 }
 
 }
 
 var dog1 = Dog(name: "보리")
 
 // Instance Method
 dog1.printName()  // 보리
 dog1.printName(nickname: "뽀리")  // 뽀리
 dog1.changeName(newName: "초코")
 
 // Type Method
 Dog.printClass()  // class Dog
 Dog.superDog()  // Dog
 
 // Subscript
 dog1["1"] = "1"
 dog1.name  // 1new초코
 print(dog1["2"])  // 21new초코
 Dog[1]  // 1
 
 // 서브클래스: Dog상속
 class Puppy: Dog {
 override class func superDog() {  // override
 print("Puppy")
 }
 
 override class subscript(tag: Int) -> Int {
 return tag + 100
 }
 }
 Puppy.superDog()  // Puppy
 Puppy[1]  // 101
 
 // Method - struct
 struct Cat {
 var name: String
 
 init(name: String) {
 self.name = name
 }
 
 func printName() {  // Instance Method - 기본
 print(name)
 }
 
 // Overloading
 func printName(nickname name: String) {
 print(name)
 }
 
 // Instance Method - 저장 속성 변경
 mutating func changeName(newName name: String) {
 self.name = name
 }
 
 static func printStruct() {  // Type Method - 기본
 print("struct Cat")
 }
 
 subscript(tag: Int, nickname: String) -> String {  // (Instance)Subscript
 return "\(tag)" + nickname
 }
 
 static subscript(nickname: String) -> String {  // Type Subscript
 return nickname
 }
 }
 
 var cat1 = Cat(name: "나비")
 
 // Instance Method
 cat1.printName()  // 나비
 cat1.printName(nickname: "나비야")  // 나비야
 cat1.changeName(newName: "호랑")
 
 // Type Method
 Cat.printStruct()  // struct Cat
 
 // Subscript
 cat1[1, "고양이"]  // 1고양이
 Cat["고양이이이"]  // 고양이이이
 
 // Method - enum
 enum Country: Int {
 case korea
 case canada
 case unitedStates
 
 static subscript(i: Int) -> Country? {  // Subscript
 if let country = Country(rawValue: i) {
 return country
 } else { return nil }
 }
 
 subscript(i: Int) -> Country? {  // Subscript
 if let country = Country(rawValue: i) {
 return country
 } else { return nil }
 }
 }
 Country[0]
 let country = Country(rawValue: 1)
 country?[0]
 //country[0]
 //if let newCountry = country[0] {
 //    return newCountry
 //} else { return nil }
 
 // Access Control
 class SomeClass {
 var name = "이름"
 
 func nameChange(name: String) {
 self.name = name
 }
 }
 var s = SomeClass()
 s.name
 s.nameChange(name: "홍길동")
 
 // Singleton Pattern
 class Singleton {
 static let shared = Singleton()  // 자신의 객체를 생성해서 전역변수에 할당
 var mainScreen = "바탕화면"
 private init() {}  // 새로운 객체 생성 불가
 }
 
 //var today = Singleton()
 // error: 'Singleton' initializer is inaccessible due to 'private' protection level
 // 새로운 객체 생성 불가
 
 var clock = Singleton.shared
 clock.mainScreen = "시계"
 Singleton.shared.mainScreen  // 시계
 
 var calendar = Singleton.shared
 calendar.mainScreen = "달력"
 clock.mainScreen  // 달력
 
 // Access Control
 class Information {
 private var name: String
 
 init(name: String) {
 self.name = name
 print(self.name)
 }
 
 func changeName(name: String) {
 self.name = name
 print(self.name)
 }
 }
 var member = Information(name: "장수지")  // 장수지
 
 //member.name = "수지1"
 // error: 'name' is inaccessible due to 'private' protection level
 
 member.changeName(name: "수지2")  // 수지2
 
 // Instance Method
 class 클래스명 {
 func 메서드명() {
 // 구현
 }
 
 func 메서드명(파라미터: String) {
 // Overloading
 }
 }
 
 struct 구조체명 {
 var 변수: String
 
 func 메서드명() {
 // 구현
 }
 
 mutating func 메서드명(파라미터: String) {
 self.변수 = 파라미터
 }
 }
 
 // Inheritance
 class BaseClass {
 var 저장속성1 = "저장속성1"
 }
 
 final class SubClass: BaseClass {
 // 상위클래스를 통해 이미 저장속성1 가지고 있음
 
 final var 저장속성2 = "저장속성2"
 }
 
 //class SubSubClass: SubClass { }
 // final키워드가 붙은 클래스는 상속할 수 없음
 
 var 인스턴스 = SubClass()
 인스턴스.저장속성1
 
 // Type Method
 class 클래스타입 {
 static func 타입메서드1() {
 // 상속시 재정의 불가능
 }
 
 class func 타입메서드2() {
 // 상속시 재정의 가능
 }
 }
 
 클래스타입.타입메서드1()
 
 // (Instance) Subscript
 struct 구조체타입 {
 subscript(파라미터1: String, 파라미터2: String) -> String {
 get {
 return 파라미터1 + 파라미터2
 }
 set {
 newValue
 }
 }
 }
 var 인스턴스 = 구조체타입()
 인스턴스["argument1", "argument2"]
 
 // Type Subscript
 class 클래스타입 {
 static var 변수: String = "타입저장속성"
 
 class subscript(파라미터1: String) -> String {
 get {
 return 파라미터1
 }
 set(파라미터2) {
 self.변수 = 파라미터2
 }
 }
 }
 클래스타입["argument1"]
 클래스타입["argument2"] = "set"
 클래스타입.변수
 
 // overriding
 class Dog {
 var name: String = "개"
 
 func bow() {
 print("멍멍")
 }
 }
 
 class Puppy: Dog {
 // 저장속성 재정의 불가
 //override var name = "개"
 
 // 계산속성 재정의 가능
 //    override var name: String {
 //        get {
 //            return "강아지"
 //        }
 //        set {
 //            super.name = newValue
 //        }
 //    }
 
 // 속성감시자 재정의 가능
 override var name: String {
 didSet {
 print("이름 변경")
 }
 }
 
 // 메서드 재정의 가능
 override func bow() {
 super.bow()
 print("왈왈")
 }
 }
 
 // initializer - 예제
 class Color {
 let red: Double = 1.0
 let blue: Double = 1.0
 let green: Double = 1.0
 
 //    init() {
 //
 //    }
 }
 // 생성자를 만들지 않았는데도 찍어낼 수 있다
 var c = Color()
 var b = Color.init()
 
 struct Color1 {
 var red: Double = 1.0
 var blue: Double
 var green: Double = 1.0
 
 //    init(red: Double, blue: Double, green: Double) {
 //        self.red = red
 //        self.blue = blue
 //        self.green = green
 //    }
 }
 
 var c2 = Color1(red: <#T##Double#>, blue: <#T##Double#>, green: <#T##Double#>)
 var c1 = Color1(blue: <#T##Double#>)
 
 // initialization
 class Font {
 var title: Int
 var subtitle: Int
 
 init() {
 self.title = 3
 self.subtitle = 2
 }
 
 init(font: Int) {
 self.title = font
 self.subtitle = font
 }
 
 init(title: Int, subtitle: Int) {
 self.title = title
 self.subtitle = subtitle
 }
 }
 
 // 기본 생성자
 class 클래스 {
 let 상수 = "기본값"
 }
 
 let instance1 = 클래스.init()
 let instance2 = 클래스()
 
 // Memberwise Initailizer
 struct 구조체 {
 let 상수 = "기본값"
 var 변수1 = "기본값"
 var 변수2: String
 }
 
 let instance1 = 구조체(변수2: <#T##String#>)
 let instance2 = 구조체(변수1: <#T##String#>, 변수2: <#T##String#>)
 
 // struct - initializer
 struct Color1 {
 let red, green, blue, white: Double
 
 init() {
 self.init(red: 0.0, green: 0.0, blue: 0.0, white: 0.0)
 }
 
 init(value: Double) {
 self.init(red: value, green: value, blue: value, white: value)
 }
 
 init(red: Double, green: Double, blue: Double, white: Double) {
 self.red = red
 self.green = green
 self.blue = blue
 self.white = white
 }
 }
 
 // class - initializer 예제
 class Dog {
 var name: String
 var weight: Double
 
 init(name: String, weight: Double) {
 self.name = name
 self.weight = weight
 }
 
 convenience init() {
 self.init(name: "강아지", weight: 10.0)
 }
 
 convenience init(name: String) {
 //        self.name = name
 //        self.weight = 10.0
 self.init(name: name, weight: 10.0)
 }
 }
 var dog1 = Dog(name: "강아지", weight: 10)
 var dog2 = Dog(name: "보리")
 dog2.name  // 보리
 dog2.weight  // 10
 var dog3 = Dog()
 dog3.name  // 강아지
 dog3.weight  // 10
 
 // 지정생성자(Designated)
 struct 구조체 {
 var 변수1: String
 var 변수2: String
 
 init(변수1: String) {
 self.init(변수1: 변수1, 변수2: "기본값")
 }
 
 // Designated
 init(변수1: String, 변수2: String) {
 self.변수1 = 변수1
 self.변수2 = 변수2
 }
 }
 var instance1 = 구조체(변수1: "지정생성자를 호출해서 사용한 편리한 생성자")
 var instance2 = 구조체(변수1: "모든값을 넣을 수 있는", 변수2: "지정생성자")
 
 // 지정생성자 - 클래스
 class 상위클래스 {
 var 부모변수1, 부모변수2: String
 
 // Designated
 init(부모변수1: String, 부모변수2: String) {
 self.부모변수1 = 부모변수1
 self.부모변수2 = 부모변수2
 }
 
 // 편의생성자
 convenience init() {
 self.init(부모변수1: "편의생성자는", 부모변수2: "상속되지 않음")
 }
 }
 
 class 하위클래스: 상위클래스 {
 var 자식변수: String
 
 // Designated
 init(자식변수: String, 부모변수1: String, 부모변수2: String) {
 self.자식변수 = 자식변수
 super.init(부모변수1: 부모변수1, 부모변수2: 부모변수2)
 }
 }
 
 var instance1 = 상위클래스()  // 편의생성자
 var instance2 = 하위클래스(자식변수: "상위클래스의 편의생성자는", 부모변수1: "상속되지 않아서", 부모변수2: "하위클래스에서 사용할 수 없음")
 
 // 생성자 - 상속
 class Order {
 var name = "장수지"
 }
 
 // 상위의 지정생성자 init()
 class KFood: Order {
 var price: Int
 var spicy: String
 
 // 지정생성자로 재정의
 //    override init() {
 //        //self.init(price: 0, spicy: "순한맛")
 //        // 'KFood'의 지정이니셜라이저는 위임할 수 없습니다('self.init' 포함)
 //        // 편의를 위한 이니셜라이저를 말씀하시는 건가요?
 //
 //        self.price = 0
 //        self.spicy = "순한맛"
 //        super.init()
 //    }
 
 // 편의생성자로 재정의
 override convenience init() {
 self.init(price: 0)
 
 //super.init()
 // 하위의 편의생성자는 상위의 지정생성자('super.init' 포함)
 // 에 체인을 연결하는 대신 위임('self.init' 포함)해야 합니다
 }
 
 // 재정의X - 지정생성자
 init(price: Int, spicy: String) {
 self.price = price
 self.spicy = spicy
 super.init()
 }
 
 // 재정의X - 편의생성자
 convenience init(price: Int) {
 self.init(price: price, spicy: "매운맛")
 }
 }
 
 class A {
 var x = 0
 
 // init()
 }
 
 class B: A {
 var y = 0
 var z = 0
 
 //    override init() {
 //        super.init()
 //        x = 1
 //    }
 
 override convenience init() {
 self.init(k: 1)
 }
 
 init(k: Int) {
 self.y = k
 self.z = k
 super.init()
 }
 
 convenience init(h: Int) {
 self.init(k: 2)
 }
 }
 
 // 자동상속
 class Aclass {
 var a: Int
 
 init(a: Int) {
 self.a = a
 }
 
 convenience init() {
 self.init(a: 0)
 }
 }
 
 // 모든 지정생성자 자동상속
 class Bclass: Aclass {
 // 지정생성자 자동상속 1. 새로운 저장속성X
 // 지정생성자 자동상속 2. 지정생성자 재정의X
 // 지정생성자 자동상속 3. 모든 기본값 세팅
 var b = 0
 }
 
 var instance1 = Bclass(a: 1)  // 지정생성자 자동상속
 var instance2 = Bclass() // 편의생성자 자동상속 - 모든 지정생성자 자동상속
 
 // 모든 지정생성자 재정의
 class Cclass: Aclass {
 override init(a: Int) {
 super.init(a: a)
 }
 }
 
 var instance3 = Cclass()  // 편의생성자 자동상속 - 상위 모든 지정생성자 재정의
 
 // 지정생성자, 편의생성자 문제
 /**==================================================================
  - 아래의 코드 예제에서, Bclass는 Aclass를 상속하고 있습니다. Bclass의 저장속성인
  z를 고려해서, Bclass의 지정생성자를 한개이상 구현하고, 상위(Aclass)의 지정생성자
  (init(x: Int, y: Int))를 편의생성자로 재정의 해보세요.
  (자유롭게 구현해보세요.)
  ===================================================================**/
 
 
 class Aclass {
 var x: Int?
 var y: Int
 
 init(x: Int, y: Int) {
 self.x = x
 self.y = y
 }
 
 convenience init() {
 self.init(x: 0, y: 0)
 }
 }
 
 
 
 // 아래의 주석을 제거하고 코드를 구현
 
 class Bclass: Aclass {
 
 var z: Int
 
 init(x: Int, y: Int, z: Int) {
 self.z = z
 super.init(x: x, y: y)
 }
 
 override convenience init(x: Int, y: Int) {
 self.init(x: x, y: y, z: 0)
 }
 }
 
 // Required Initializer
 class Aclass {
 var x: Int
 
 required init(x: Int) {
 self.x = x
 }
 }
 
 class Bclass: Aclass {
 // 다른 지정생성자 구현하지 않으면 필수생성자 자동상속
 }
 
 class Cclass: Aclass {
 var y: Int
 
 // 다른 지정생성자 구현하면
 init(y: Int) {
 self.y = y
 super.init(x: 0)
 }
 
 // 필수생성자 반드시 구현
 required init(x: Int) {
 self.y = 0
 super.init(x: x)
 }
 }
 
 // Delegate across
 struct Item {
 var name = ""
 
 // 실패가능생성자에서 실패가능생성자 호출(가능)
 init() { }
 
 
 init?(name: String) {
 self.init()
 }
 
 // 실패불가능생성자에서 실패가능생성자 호출(불가능)
 //    init() {
 //        self.init(name: "헬로")
 //    }
 //
 //    init?(name: String) {
 //        self.name = name
 //    }
 }
 
 class Product {
 let name: String
 init?(name: String) {
 if name.isEmpty { return nil }
 self.name = name
 }
 }
 
 
 // 온라인 쇼핑 카트의 항목을 모델링
 
 class CartItem: Product {
 let quantity: Int
 init(name: String, quantity: Int) {
 self.quantity = quantity           // 수량이 한개 이상이면 ====> 초기화 성공
 super.init(name: name)             // "" (빈문자열이면)  ====> 실패 가능 위임 OK
 }
 }
 
 // Failable Initualizer
 class Aclass {
 var age: Int?
 
 init?(age: Int) {
 if age == 0 {
 return nil
 }
 self.age = age
 }
 
 // 범위 관계에 맞지 않아서 오류
 // 편의생성자 < 함수내부
 //    convenience init() {
 //        self.init(age: 0)
 //    }
 }
 
 class Bclass: Aclass {
 var gender: String
 
 // 논리 구조상 nil이 나올 수 없기 때문에 강제 언래핑 가능
 init(gender: String) {
 self.gender = gender
 super.init(age: 1)!
 }
 
 // 상위 > 하위 호출
 convenience init?() {
 self.init(gender: "여자")
 }
 
 // 상위 > 함수 내부 상위 호출
 override init?(age: Int) {
 self.gender = "여자"
 super.init(age: age)
 }
 
 // 범위 위배: 상위 < 함수내부 상위
 //    override init(age: Int) {
 //        self.gender = "여자"
 //        super.init(age: age) {
 //            if age == 0 { return nil }
 //            super.age = age
 //        }
 //    }
 }
 
 // deinit
 class Aclass {
 var x = 0
 
 deinit {
 print("인스턴스 소멸")
 }
 }
 
 var instance: Aclass? = Aclass()
 instance = nil
 
 // Type Casting - is
 class 상위클래스 {
 var a = "a"
 }
 
 class 하위클래스: 상위클래스 {
 // a
 var b = "b"
 }
 
 var instanceA = 상위클래스()
 var instanceB = 하위클래스()
 
 instanceA is 상위클래스  // true
 instanceA is 하위클래스  // false
 // A는 하위클래스에 포함되니?
 // A는 a, b 둘 다 가지고 있니?
 // A > 하위클래스 -> false
 
 instanceB is 상위클래스  // true
 // B는 상위클래스에 포함되니?
 // B는 a를 가지고 있니?
 // B > 상위클래스 -> true
 instanceB is 하위클래스  // true
 
 // Upcasting
 class 상위클래스 {
 var a = "a"
 }
 
 class 하위클래스: 상위클래스 {
 var b = "b"
 }
 
 var instanceB = 하위클래스()
 instanceB.a
 
 instanceB as 상위클래스
 instanceB.a
 
 // Downcasting
 var instanceA: 상위클래스 = 하위클래스()
 //instanceA.b
 // error: Value of type '상위클래스' has no member 'b'
 
 if let a = instanceA as? 하위클래스 {
 print(a.b)
 } // b
 
 // as 활용: bridging
 var a: String = "a"  // type: String
 let NSa = a as NSString  // a: String
 print(type(of: NSa))  // NSTaggedPointerString
 
 // Polymorphism
 class 상위클래스 {
 func 메서드() {
 print("상위메서드 출력")
 }
 }
 
 class 하위클래스: 상위클래스 {
 override func 메서드() {
 print("하위메서드 출력")
 }
 }
 
 let instance: 상위클래스 = 하위클래스()
 instance.메서드()  // 하위메서드 출력
 
 // Typecasting - switch
 class A {
 var a = "a"
 }
 
 class B: A {
 var b = "b"
 }
 
 var array: [Any] = [1, "Swift", A(), B(), true]
 
 for item in array {
 switch item {
 case is Int:
 print("Int: \(item)")
 case let something as B:
 print("as B: \(something)")
 case let something as A:
 print("as A: \(something)")
 default:
 print("etc")
 }
 }
 
 // Any - Optional
 let a: String? = "a"
 
 print(a)
 print(a as Any)
 
 // AnyObject
 class A {
 let a = "a"
 }
 
 class B {
 let b = "b"
 }
 
 let anyObject: [AnyObject] = [A(), B()]
 
 //print(anyObject[0].a)  // error
 print((anyObject[0] as! A).a)  // a
 
 // extension - 예제
 struct SomeType {
 }
 
 var a = SomeType()
 a.doSomething()
 
 extension SomeType {
 func doSomething() {
 print("Do something")
 }
 }
 
 var under = Undergraduate()
 under.play()
 
 extension Student {
 @objc func play() {
 print("학생이 논다.")
 }
 }
 
 class Undergraduate: Student {
 override func play() {
 print("대학생이 논다")
 }
 }
 Int
 
 // extension
 struct 오리지널타입 {}
 
 extension 오리지널타입 {
 func 추가기능() { }
 }
 
 // extension - 계산 속성
 extension String {
 static var guest: String { return "손님"}
 var customer: String { return self + "님" }
 }
 
 func customer(name: String) -> String {
 return name + "님"
 }
 
 print(String.guest)  // 손님
 print("장수지".customer)  // 장수지님
 print(customer(name: "장수지"))  // 장수지님
 
 // extension - type method
 extension String {
 static func hi() {
 print("안녕하세요")
 }
 }
 String.hi()  // 안녕하세요
 
 // extension - instance method
 extension String {
 func guest() {
 print("안녕하세요 \(self)님")
 }
 }
 "장수지".guest()  // 안녕하세요 장수지님
 
 extension String {
 mutating func customer() {
 self = self + "님"
 }
 }
 var name = "장수지"
 name.customer()  // 장수지님
 
 // extension - struct initializer
 struct Point {
 var x = 0.0, y = 0.0
 
 //init(x: Double, y: Double)
 //init()
 }
 
 extension Point {
 init(num: Double) {
 self.x = num
 self.y = num
 }
 }
 
 // extension - class initializer
 class 클래스 {
 var x = "x"
 
 init(x: String) {
 self.x = x
 }
 }
 
 extension 클래스 {
 convenience init() {
 self.init(x: "x")
 }
 }
 
 // class - initializer
 class Dog {
 var name: String
 
 init(name: String) {
 self.name = name
 }
 }
 //Dog()
 Dog(name: "보리")
 
 // struct - initializer
 struct 구조체 {
 var name = ""
 var age = 0
 }
 
 extension 구조체 {
 init(name: String) {
 self.name = name
 }
 }
 
 구조체(name: <#T##String#>)
 
 // 예외
 구조체()
 구조체(name: <#T##String#>, age: <#T##Int#>)
 
 // extension - subscript (algorithm)
 extension Int {
 subscript(num: Int) -> Int {
 var decimalBase = 1
 
 for _ in 0..<num {
 decimalBase *= 10
 }
 
 return (self / decimalBase) % 10
 }
 }
 
 1234567[1]  // 6
 
 class Day {
 enum Weekday {
 case mon
 case tue
 case wed
 }
 
 var day: Weekday = .mon
 }
 
 var ddd: Day.Weekday = Day.Weekday.mon
 // 타입이 대문자로 시작하고 .찍고 또 대문자로 시작한다
 // 이게 타입 내부에 있는 타입이라는 의미
 // Weekday라는 타입은 일반적으로 Day랑 연관성이 많아서 그 내부에만 선언해 놓은 것
 
 // extension - nested type
 var array: [Int] = [0, 1, 2, 3, 4, 5]
 
 extension Int {
 enum Kind {
 case odd
 case even
 }
 
 var kind: Kind {
 switch self {
 case let x where x % 2 == 0:
 return .even
 default:
 return .odd
 }
 }
 }
 
 var array1: [Int.Kind] = []
 
 for item in array {
 array1.append(item.kind)
 }
 
 func korean(array: [Int.Kind]) {
 for item in array {
 switch item {
 case .even:
 print("짝")
 case .odd:
 print("홀")
 }
 }
 }
 
 korean(array: array1)
 
 // 클래스의 한계: 불필요한 메서드까지 상속
 class Animal {
 func run() {
 print("달린다")
 }
 
 func swim() {
 print("수영하다")
 }
 }
 
 class Dog: Animal {
 // func run() -> O 개는 달릴 수 있음
 // func swim() -> O 개는 수영할 수 있음
 }
 
 class Fish: Animal {
 // func run() -> X 물고기는 달릴 수 없음
 // func swim() -> O 물고기는 수영할 수 있음
 }
 
 var goldfish = Fish()
 goldfish.run()  // 금붕어는 달리지 못하는데 상속받음
 
 // 프로토콜 장점
 protocol CanSwim {
 func swimming()
 }
 
 class Tiger: Animal, CanSwim {
 func swimming() {
 print("호랑이가 수영한다")
 }
 }
 
 // 필요한 것만 골라서 채택
 struct Fish1: CanSwim {
 func swimming() {
 print("물고기가 헤엄친다")
 }
 }
 
 // 프로토콜 자체가 하나의 타입으로 인식됨
 func inJungle(type: CanSwim) {
 type.swimming()
 }
 
 var tiger = Tiger()
 inJungle(type: tiger)  // 호랑이가 수영한다
 
 var fish = Fish1()
 inJungle(type: fish)  // 물고기가 헤엄친다
 
 // protocol 정의
 protocol ProtocolType {
 var 속성: 속성타입 { get set }
 func 매서드() -> 리턴타입
 }
 
 // protocol 채택
 class ClassType: 상위클래스, ProtocolType { 요구사항 }
 struct StructType: ProtocolType { 요구사항 }
 
 // protocol 속성 요구사항 정의
 protocol ProtocolType {
 var 속성1: String { get }
 var 속성2: String { get set }
 static var 속성3: String { get }
 static var 속성4: String { get set }
 }
 
 // 채택해서 속성 구현
 class ClassType: ProtocolType {
 let 속성1: String = "속성1"
 var 속성2: String = "속성2"
 static var 속성3: String {
 get {
 return "속성3"
 }
 }
 class var 속성4: String {
 get {
 return "속성4"
 }
 set {}
 }
 }
 
 //예제
 protocol RandomNumber {
 mutating func doSomething()
 }
 
 struct Number: RandomNumber {
 var num = 0
 
 mutating func doSomething() {
 self.num = 10
 }
 }
 
 // protocol - method 요구사항 정의
 protocol ProtocolType {
 func method()
 static func typeMethod() -> String
 mutating func valueTypeMethod()
 }
 
 class 클래스: ProtocolType {
 func method() {}
 
 class func typeMethod() -> String {
 return "타입 메서드"
 }
 
 func valueTypeMethod() {}
 }
 
 // 예제
 class SomeClass: SomeProtocol {
 convenience init(num: Int) {}
 }
 
 // protocol - initializer 요구사항 정의
 protocol ProtocolType {
 init(파라미터: String)
 init?(파라미터1: Int)
 }
 
 class 상위클래스: ProtocolType {
 required init!(파라미터: String) {}
 
 required init(파라미터1: Int) {}
 }
 
 class 하위클래스: 상위클래스 {}
 
 class 하위클래스1: 상위클래스 {
 init(){
 super.init(파라미터: "")
 }
 
 required init(파라미터: String) {
 super.init(파라미터: 파라미터)
 }
 
 required init(파라미터1: Int) {
 super.init(파라미터1: 파라미터1)
 }
 
 //    required convenience init(파라미터: String) {
 //        self.init()
 //    }
 }
 
 final class 하위클래스2: 상위클래스 {
 required init!(파라미터: String) {
 super.init(파라미터1: 0)
 }
 required init(파라미터1: Int) {
 super.init(파라미터1: 0)
 }
 // 여기서는 required 안붙이면 에러
 }
 
 final class 상위클래스1: ProtocolType {
 init(파라미터: String) {}
 init?(파라미터1: Int) {}
 }
 
 // protocol - subscript
 protocol ProtocolType {
 subscript(파라미터: Int) -> String { get }
 }
 
 struct 구조체: ProtocolType {
 var 변수: String
 
 subscript(파라미터: Int) -> String {
 get {
 return "getter"
 }
 set {
 변수 = newValue
 }
 }
 }
 
 var instance = 구조체(변수: "인스턴스 생성")
 instance[1]  // getter
 instance[1] = "setter"
 print(instance.변수)  // setter
 
 // 프로토콜: First Class Citizen
 protocol Drawable {
 func draw()
 }
 
 class Circle: Drawable {
 func draw() {
 print("Drawing a circle")
 }
 
 func check() {
 print("circle a check mark")
 }
 }
 
 struct Square: Drawable {
 func draw() {
 print("Drawing a square")
 }
 }
 
 // 1. 변수에 할당 가능: 프로토콜을 준수하는 모든 인스턴스 할당 가능
 var drawing: Drawable  // 프로토콜 타입 변수 선언
 drawing = Circle()  // 변수에 인스턴스 할당
 
 // 장점: 공통된 타입으로 뽑아내서 저장 가능
 var shape: [Drawable] = [Circle(), Square()]
 
 // 2. 함수의 파라미터로 사용 가능
 func draw(shape: [Drawable]) {
 for item in shape {
 item.draw()
 }
 }
 draw(shape: shape)
 
 func draw1(item: Drawable) {
 item.draw()
 }
 draw1(item: Circle())
 
 // 3. 함수의 리턴형으로 사용 가능
 func createShape(type: String) -> Drawable? {
 switch type {
 case "circle":
 return Circle()
 case "square":
 return Square()
 default:
 return nil
 }
 }
 
 if let shape = createShape(type: "circle") {
 shape.draw()
 }
 
 
 // is연산자
 let circle = Circle()
 
 // 프로토콜 채택 확인
 draw is Drawable
 
 // 구체적인 인스턴스 확인
 shape[0] is Circle
 
 
 // as연산자
 
 // Upcasting
 let newCircle = circle as Drawable
 circle.check()
 //newCircle.check
 
 // Downcasting
 //shape[0].check()
 (shape[0] as? Circle)?.check()
 
 // 프로토콜 다중상속
 protocol A {
 var a: String { get }
 }
 
 protocol B {
 var b: String { get }
 }
 
 protocol Inheritance: A, B {}
 
 struct Example: Inheritance {
 var a = "a"
 var b = "b"
 }
 
 
 // AnyObject: 클래스 전용 프로토콜
 protocol OnlyClass: AnyObject {
 var value: Int { get }
 }
 
 class 클래스: OnlyClass {
 var value = 0
 }
 
 // 클래스가 아닌 유형 '구조체'(는) 클래스 프로토콜 'OnlyClass'을(는) 준수할 수 없습니다
 //struct 구조체: OnlyClass {
 //    var value = 0
 //}
 
 
 // 프로토콜 합성
 var instance1: A & B
 
 instance1 = Example()
 //instance1 = 클래스()  // '클래스' 유형의 값을 '임의 A&B' 유형에 할당할 수 없습니다
 
 // Protocol - 선택적 요구사항
 @objc protocol 프로토콜 {
 @objc optional var 선택적변수: String { get set }
 var 변수: String { get }
 
 @objc optional func 선택적함수()
 func 함수()
 }
 
 class 클래스: 프로토콜 {
 var 변수: String = "변수"
 func 함수() {}
 }
 
 //struct 구조체: 프로토콜 {
 //    var 변수: String = "변수"
 //    func 함수() {}
 //}
 
 protocol 프로토콜 {
 func 프로토콜()
 func 타입()
 }
 
 extension 프로토콜 {
 // Witness Table
 func 프로토콜() { print("요구O: 기본 구현") }
 func 타입() { print("요구O: 기본 구현") }
 
 // 코드에 메모리 주소 직접 삽입
 func 선택() { print("요구X: 기본 구현") }
 }
 
 class 클래스: 프로토콜 {
 func 타입() { print("요구O: 직접 구현") }
 func 선택() { print("요구X: 직접 구현") }
 }
 /**===============================
  [Class Virtual Table]
  func 프로토콜() { print("요구O: 기본 구현") }
  func 타입()       { print("요구O: 직접 구현") }
  func 선택()       { print("요구X: 직접 구현") }
  ================================**/
 
 
 var classInstance1: 프로토콜 = 클래스()
 /**===============================
  [Protocol Witness Table]
  func 프로토콜() { print("요구O: 기본 구현") }
  func 타입()       { print("요구O: 직접 구현") }
  ================================**/
 
 classInstance1.프로토콜()  // 요구O: 기본 구현
 classInstance1.타입()  // 요구O: 직접 구현
 classInstance1.선택()  // 요구X: 기본 구현
 
 var classInstance2: 클래스 = 클래스()
 classInstance2.프로토콜()  // 요구O: 기본 구현
 classInstance2.타입()  // 요구O: 직접 구현
 classInstance2.선택()  // 요구X: 직접 구현
 
 print("---")
 
 struct 구조체: 프로토콜 {
 func 타입() { print("요구O: 직접 구현") }
 func 선택() { print("요구X: 직접 구현") }
 }
 // [구조체 메서드 테이블 없음] 코드에 메모리 주소 직접 삽입
 
 
 var structInstance1: 프로토콜 = 구조체()
 /**===============================
  [Protocol Witness Table]
  func 프로토콜() { print("요구O: 기본 구현") }
  func 타입()       { print("요구O: 직접 구현") }
  ================================**/
 
 structInstance1.프로토콜()  // 요구O: 기본 구현
 structInstance1.타입()  // 요구O: 직접 구현
 structInstance1.선택()  // 요구X: 기본 구현
 
 var structInstance2: 구조체 = 구조체()
 structInstance2.프로토콜()  // 요구O: 기본 구현
 structInstance2.타입()  // 요구O: 직접 구현
 structInstance2.선택()  // 요구X: 직접 구현
 
 // 프로토콜 확장 적용 제한
 protocol 특정프로토콜 {
 var 변수1: String { get }
 }
 
 protocol 프로토콜 {
 func 메서드()
 }
 
 extension 프로토콜 where Self: 특정프로토콜 {
 func 메서드() { print("프로토콜 확장") }
 }
 
 class 클래스: 프로토콜 {
 let 변수1 = "변수1"
 func 메서드() {}
 }
 
 struct 구조체: 특정프로토콜, 프로토콜 {
 let 변수1 = "변수1"
 }
 
 let instance = 구조체()
 instance.메서드()  // 프로토콜 확장
 
 // Method Dispatch
 protocol 프로토콜 {
 func method1()
 func method2()
 }
 
 extension 프로토콜 {
 func method1() { print("[extension protocol] 필수") }
 func method3() { print("[extension protocol] 선택") }  // Direct Dispatch
 }
 
 class 클래스: 프로토콜 {
 func method2() { print("[class] 프로토콜 필수") }
 @objc dynamic func method4() { print("[Objective-C]") }  // Message Dispatch
 }
 /**=====================================================
  [Class Virtual Table]
  func method1() { print("[extension protocol] 필수") }
  func method2() { print("[class] 프로토콜 필수") }
  @objc dynamic func method4() { print("Objective-C") }
  ======================================================**/
 /**=====================================================
  [Protocol Witness Table]
  func method1() { print("[extension protocol] 필수") }
  func method2() { print("[class] 프로토콜 필수") }
  ======================================================**/
 
 class ObjectiveC: 클래스 {}
 /**=====================================================
  [Class Virtual Table]
  super class
  ======================================================**/
 
 class SwiftClass: 클래스 {}
 /**=====================================================
  [Class Virtual Table]
  func method1() { print("[extension protocol] 필수") }
  func method2() { print("[class] 프로토콜 필수") }
  @objc dynamic func method4() { print("Objective-C") }
  ======================================================**/
 
 let instance1: 클래스 = 클래스()
 instance1.method1()  // [extension protocol] 필수
 instance1.method2()  // [class] 프로토콜 필수
 instance1.method3()  // [extension protocol] 선택
 instance1.method4()  // [Objective-C]
 
 let instance2: 프로토콜 = 클래스()
 instance2.method1()  // [extension protocol] 필수
 instance2.method2()  // [class] 프로토콜 필수
 instance2.method3()  // [extension protocol] 선택
 //instance2.method4()
 
 // Nested Type: BlackjackCard 변형
 struct BlackjackCardGame {
 var dealerRoll: Roll
 var playerRoll: Roll
 
 enum Suit: Character {
 case spades = "♠", hearts = "♡", diamonds = "♢", clubs = "♣"
 }
 
 enum Rank: Int {
 case two = 2, three, four, five, six, seven, eight, nine, ten
 case jack = 11, queen, king, ace
 
 struct Values {
 let first: Int, second: Int?
 }
 
 var values: Values {
 switch self {
 case .ace:
 return Values(first: 1, second: 11)
 case .jack, .queen, .king:
 return Values(first: 10, second: nil)
 default:
 return Values(first: self.rawValue, second: nil)
 }
 }
 }
 
 let suit: [Suit] = [.spades, .hearts, .diamonds, .clubs]
 let rank: [Rank] = [.two, .three, .four, .five, .six, .seven, .eight, .nine, .ten, .jack, .queen, .king, .ace]
 var randomSuitD: Suit
 var randomRankD: Rank
 var randomSuitP: Suit
 var randomRankP: Rank
 
 init() {
 self.dealerRoll = Roll()
 self.playerRoll = Roll()
 self.randomSuitD = suit[dealerRoll.randomSuit]
 self.randomRankD = rank[dealerRoll.randomRank]
 self.randomSuitP = suit[playerRoll.randomSuit]
 self.randomRankP = rank[playerRoll.randomRank]
 }
 
 var description: String {
 var dealer = " - dealer: \(randomSuitD.rawValue) \(randomRankD.values.first)"
 if let second = randomRankD.values.second {
 dealer += " 또는 \(second)"
 }
 
 var player = " - player: \(randomSuitP.rawValue) \(randomRankP.values.first)"
 if let second = randomRankP.values.second {
 player += " 또는 \(second)"
 }
 
 return "\(dealer)\n\(player)"
 }
 }
 
 struct Roll {
 var randomSuit = Int.random(in: 0...3)
 var randomRank = Int.random(in: 0...12)
 }
 
 let first = BlackjackCardGame()
 print("[first]\n\(first.description)")
 
 // Nested Type - Keyword
 struct K {
 static let appName = "MyApp"
 
 struct BrandColor {
 static let pink = "BrandPink"
 }
 
 struct BrandFont {
 static let headline = "BrandHeadlineFont"
 }
 }
 
 let headline = K.BrandFont.headline  // BrandHeadlineFont
 print(headline)
 
 // Nested Type - message
 class Message {
 // 설계: 보낸사람, 받는사람, 내용, 보낸시간, 상태
 // 상태
 enum Status: String {
 case sent
 case received
 case read
 }
 
 let sender, reciptien, content: String
 let timeStamp: Date
 var status = Message.Status.sent
 
 init(sender: String, reciptien: String, content: String) {
 self.sender = sender
 self.reciptien = reciptien
 self.content = content
 self.timeStamp = Date()
 }
 
 func sendMessage() -> String {
 return "보낸사람: \(sender)\n받는사람: \(reciptien)\n내용: \(content)\n\(timeStamp)\n\(status.rawValue)"
 }
 
 var statusColor: UIColor {
 switch status {
 case .sent:
 return UIColor(red: 1, green: 0, blue: 0, alpha: 1)
 case .received:
 return UIColor(red: 0, green: 1, blue: 0, alpha: 1)
 case .read:
 return UIColor(red: 0, green: 0, blue: 1, alpha: 1)
 }
 }
 
 func statusColor2() -> UIColor {
 switch status {
 case .sent:
 return UIColor(red: 1, green: 0, blue: 0, alpha: 1)
 case .received:
 return UIColor(red: 0, green: 1, blue: 0, alpha: 1)
 case .read:
 return UIColor(red: 0, green: 0, blue: 1, alpha: 1)
 }
 }
 }
 
 var message = Message(sender: "장수지", reciptien: "누구", content: "안녕")
 print(message.sendMessage())
 print(message.statusColor)
 print(message.statusColor2())
 
 // Nested Type
 struct Abc {
 enum Bbc {
 case aaa, bbb, ccc
 
 
 }
 var ddd: Bbc = .ccc
 
 var word: String {
 switch ddd {
 case .aaa:
 return ""
 default:
 return ""
 }
 }
 }
 
 // 예제 - Self
 protocol Remote {
 //func turnOn() -> String
 func turnON() -> Self
 }
 
 extension String: Remote {
 func turnON() -> String { return "" }
 //func turnON() -> Self { return "" }
 }
 
 // self
 struct StructType1 {
 var insVar: String
 static var typeVar: String = "typeVariable"
 
 // (1) 인스턴스 지칭: 가리키는것 명확하게 구분
 init(insVar: String) {
 self.insVar = insVar
 }
 
 // (3) 타입 지칭: 타입 속성/메서드에서 사용
 static func doPrinting() {
 print(self.typeVar)
 }
 }
 
 struct StructType2 {
 let insVar: String = ""
 
 // (2) 인스턴스 지칭: 새로운 인스턴스로 치환
 mutating func reset() {
 self = StructType2()
 }
 }
 
 // (4) 타입 인스턴스 지칭: 타입 자체 뒤에 사용
 let instance: StructType1.Type = StructType1.self
 instance.typeVar  // typeVariable
 instance.self.typeVar  // typeVariable
 //instance.self.insVar
 Int.self.max  // 9,223,372,036,854,775,807
 
 // Self
 // (3) 채택한 타입 지칭 -> 범용성 증가
 protocol ProtocolType {
 var insVar: Self { get }
 }
 
 // (1) 특정 타입 지칭: 컴파일러가 명확하게 타입 인지 가능할 때 사용
 extension String: ProtocolType {
 // (1) 타입 선언 위치에 사용, (3)
 static var empty: Self = ""
 var insVar: Self {  // var insVar: String
 return "instance variable"
 }
 
 // (2) 특정 타입 지칭: 타입 속성/메서드에서 사용
 static func doEmpty() -> Self {
 return Self.empty
 }
 }
 
 // closure - 함수를 변수에 할당할 수 있다
 let variable = { return "클로저" }
 variable()  // 클로저
 
 func 함수(str: String) { print(str) }
 함수(str: "함수의 실행")  // 함수의 실행
 
 let 상수 = 함수
 상수("상수 실행")  // 상수 실행
 
 func 함수(파라미터: String) -> String {
 return 파라미터
 }
 
 let 클로저 = { (파라미터: String) -> String in
 return 파라미터
 }
 
 let _ = { (파라미터: String) in
 return 파라미터
 }
 
 let _: (String) -> String = { 파라미터 in
 return 파라미터
 }
 
 let _ = { 파라미터 in
 return 파라미터 + " "
 }
 
 let _ = {
 print("() -> ()")
 }
 
 // callback function
 // 본래 함수 정의
 func 본래함수(클로저: () -> ()) {
 print("본래함수 실행")
 클로저()
 }
 
 // 본래 함수 실행
 본래함수(클로저: {
 print("클로저 실행")
 })
 
 // closure
 func 본래함수(a: Int, b: Int, closure: (Int) -> ()) {
 closure(a + b)
 }
 
 본래함수(a: 1, b: 2, closure: { param in
 print(param)
 })  // 3
 
 
 func closureParamFunction(closure: () -> Void) {
 print("프린트 시작")
 closure()
 }
 
 closureParamFunction {
 print("프린트 종료")
 }
 
 closureParamFunction {}
 
 func closureCaseFunction(a: Int, b: Int, closure: (Int) -> Void) {
 let c = a + b
 closure(c)
 }
 
 closureCaseFunction(a: 3, b: 4) { a in
 print(a)
 }  // 7
 
 let closureType1 = { $0 % 2 == 0 }
 
 func multipleTrailingClosure(first: () -> (), second: (Int) -> (String)) {
 first()
 second(0)
 }
 
 multipleTrailingClosure {
 <#code#>
 } second: { <#Int#> in
 <#code#>
 }
 
 // Closure - Capturing Value
 var stored = 0
 
 let closure = { (number: Int) -> Int in
 stored += number
 return stored
 }
 closure(3)  // 3
 closure(4)  // 7
 
 // 중첩 함수
 func calculate(number: Int) -> Int {
 var sum = 0
 
 func square(num: Int) -> Int {
 sum += num * num
 return sum
 }
 
 let result = square(num: number)
 
 return result
 }
 
 calculate(number: 3)  // 9
 calculate(number: 4)  // 16
 
 // 중첩함수 - Capture
 func calculateFunc() -> ((Int) -> Int) {
 var sum = 0
 
 func square(num: Int) -> Int {
 sum += num * num
 return sum
 }
 
 return square
 }
 
 var squareFunc = calculateFunc()
 squareFunc(3)  // 9
 squareFunc(4)  // 25
 
 calculateFunc()(3)  // 9
 calculateFunc()(4)  // 16
 
 let squareFunc2 = squareFunc
 squareFunc2(3)
 
 // @escaping
 var variable: () -> () = { print("value") }
 variable()  // value
 
 func 본래함수(closure: @escaping () -> ()) {
 variable = closure
 }
 
 본래함수 {
 print("closure")
 }
 variable()  // closure
 
 // @autoclosure
 var value = { return 7 }
 value()  // 7
 
 func 함수(closure: @autoclosure @escaping () -> (Int)) {
 value = closure
 if closure() == 0 {
 print("값: 0")
 } else {
 print("값: 0이 아님")
 }
 }
 
 함수(closure: 0)
 value()  // 값: 0
 
 // map
 let array = [1, 2, 3]
 
 let multiplication = array.map { num in
 return "2 * \(num) = \(2 * num)"
 }
 
 print(multiplication)
 // ["2 * 1 = 2", "2 * 2 = 4", "2 * 3 = 6"]
 
 let array = [1, 2, 3]
 
 
 print(array.reduce(100) { $0 + $1 })  // 106
 
 let array = [[1], [1, 2, 3]]
 
 print(array.flatMap{ $0 + [2] })
 
 class Pet {
 var training: (() -> Cat?)?
 
 init(sitting: @escaping () -> Cat?) {
 self.training = sitting
 }
 }
 
 class Cat {
 var name: String?
 }
 
 func sit() -> Cat? {
 let cat = Cat()
 cat.name = "고양이"
 return cat
 }
 
 // 함수 자체?, 함수의 결과값?
 var pet: Pet? = Pet(sitting: sit)
 print(pet?.training?()?.name)  // Optional("고양이")
 
 // 딕셔너리 자체? 키에 대응되는 값?
 class Cats {
 var names: [String: Cat]?
 }
 
 var cat1 = Cat()
 cat1.name = "나비"
 
 var cat2 = Cat()
 cat2.name = "야옹이"
 
 var cats = Cats()
 cats.names = ["cat1": cat1, "cat2": cat2]
 
 print(cats.names?["cat1"]?.name)  // Optional("나비")
 
 class Person {
 var name: String
 unowned var pet: Pet?
 
 init(name: String) {
 self.name = name
 }
 
 deinit {
 print("\(name) 메모리 해제")
 }
 }
 
 class Pet {
 var name: String
 unowned var owner: Person?
 
 init(name: String, owner: Person?) {
 self.name = name
 self.owner = owner
 }
 
 deinit {
 print("\(name) 메모리 해제")
 }
 }
 
 var suji: Person? = Person(name: "수지")
 var cat: Pet? = Pet(name: "고양이", owner: suji)
 suji?.pet = cat
 
 suji = nil
 cat = nil
 
 // 수지 메모리 해제
 // 고양이 메모리 해제
 
 // Value Type 캡처
 var name = "이름"
 
 let valueTypeCapture = {
 print(name)
 }
 valueTypeCapture()  // 이름
 
 name = "수지"
 valueTypeCapture()  // 수지
 
 // Capture List
 var birth = 1996
 
 let captureList = { [birth] in
 print(birth)
 }
 captureList()  // 1996
 
 birth = 2024
 captureList()  // 1996
 
 // Reference Type - Capture vs. CaptureList
 class ReferenceType {
 var num = 0
 }
 
 var x = ReferenceType()
 var y = ReferenceType()
 
 let referenceTypeCapture = { [x] in
 print("x: \(x.num), y: \(y.num)")
 }
 referenceTypeCapture()  // x: 0, y: 0
 
 x.num = 1
 y.num = 1
 referenceTypeCapture()  // x: 1, y: 1
 
 
 // 약한 참조
 let ifStrongReferenceCycle1 = { [weak x] in
 print(x?.num)
 }
 ifStrongReferenceCycle1()  // Optional(1)
 
 // 비소유 참조
 let ifStrongReferenceCycle2 = { [unowned y] in
 print(y.num)
 }
 ifStrongReferenceCycle2()  // 1
 
 
 // CaptureList - Binding
 let captureListBinding = { [new = x] in
 print(new.num)
 }
 captureListBinding()  // 1
 
 class Dog {
 var name = "초코"
 
 var run: (() -> Void)?
 
 func walk() {
 print("\(self.name)가 걷는다.")
 }
 
 func saveClosure() {
 run = { [weak self] in
 print("\(self?.name)가 뛴다.")
 }
 }
 
 deinit {
 print("\(self.name) 메모리 해제")
 }
 }
 
 
 
 
 func doSomething() {
 let choco: Dog? = Dog()
 choco?.saveClosure()       // 강한 참조사이클 일어남 (메모리 누수가 일어남)
 }
 
 
 
 doSomething()
 
 // 강한 참조
 class ViewControllerS: UIViewController {
 var name = "view controller S"
 
 func doSomething() {
 DispatchQueue.global().async {
 sleep(3)
 print("global queue에서 출력: \(self.name)")
 }
 }
 
 deinit {
 print("view controller S 메모리 해제")
 }
 }
 
 func localScopeFunctionS() {
 let vc = ViewControllerS()
 vc.doSomething()
 }
 
 localScopeFunctionS()
 // (3초 sleep)
 // global queue에서 출력: view controller S
 // view controller S 메모리 해제
 
 // 약한 참조
 class ViewControllerW: UIViewController {
 var name = "view controller W"
 
 func doSomething() {
 DispatchQueue.global().async { [weak self] in
 //guard let weakSelf = self else { return }
 sleep(3)
 print("global queue에서 출력: \(self?.name)")
 }
 }
 
 deinit {
 print("view controller W 메모리 해제")
 }
 }
 
 func localScopeFunctionW() {
 let vc = ViewControllerW()
 vc.doSomething()
 }
 
 localScopeFunctionW()
 // view controller W 메모리 해제
 // (3초 sleep)
 // global queue에서 출력: nil
 
 // error handling - ex
 enum SomeError: Error {
 case aError
 case bError
 case cError
 }
 
 func doSomething(num: Int) throws -> Bool {
 if num >= 7 {
 return true
 } else {
 if num < 0 {
 throw SomeError.aError
 }
 return false
 }
 }
 
 // Error Handling
 enum SomeError: Error {
 case negative
 case zero
 case maximum
 }
 
 func doSomething(num: Int) throws -> (String) {
 if num > 99 {
 throw SomeError.maximum
 } else if num == 0 {
 throw SomeError.zero
 } else if num < 0 {
 throw SomeError.negative
 } else {
 return String(num)
 }
 }
 
 // try try? try!
 do {
 let result = try doSomething(num: 7)
 
 if result.count < 2 {
 print("한자리수")
 } else {
 print("두자리수")
 }
 } catch {
 print("음수 or 0 or 100이상")
 }  // 한자리수
 
 let optionalTry: String? = try? doSomething(num: 7)
 print(optionalTry)  // Optional("7")
 
 let forcedTry: String = try! doSomething(num: 7)
 print(forcedTry)  // 7
 
 // catch
 do {
 let result = try doSomething(num: -1)
 print(result)
 } catch SomeError.negative {
 print("음수")
 } catch SomeError.zero {
 print("0")
 } catch SomeError.maximum {
 print("100 이상")
 }  // 음수
 
 
 do {
 let result = try doSomething(num: -1)
 print(result)
 } catch SomeError.maximum {
 print("100 이상")
 } catch {
 print("0 이하")
 }  // 0 이하
 
 do {
 let result = try doSomething(num: -1)
 print(result)
 } catch {
 print(error.localizedDescription)
 // The operation couldn’t be completed. (__lldb_expr_119.SomeError error 0.)
 
 if let error = error as? SomeError {
 switch error {
 case .negative:
 print("음수")
 case .zero:
 print("0")
 case .maximum:
 print("100 이상")
 }
 }
 }  // 음수
 
 enum SomeError: Error {
 case zero
 }
 
 func doSomething(num: Int) throws -> Bool {
 if num == 0 {
 throw SomeError.zero
 } else {
 if num > 0 {
 return true
 } else {
 return false
 }
 }
 }
 
 func errorHandling() {
 do {
 try doSomething(num: 0)
 } catch {
 print("error: 0")
 }
 }
 
 errorHandling()  // error: 0
 
 // 다시 에러 던지기
 func throwingFunc() throws {
 do {
 try doSomething(num: 0)
 }
 }
 
 // 처리
 do {
 try throwingFunc()
 } catch {
 print(error)
 }  // zero
 
 // 에러를 또 다시 던짐
 func rethrowingFunc(callback: (Int) throws -> Bool) rethrows {
 do {
 try callback(0)
 }
 }
 
 do {
 try rethrowingFunc(callback: doSomething)
 } catch {
 print(error)
 }  // zero
 
 
 // 에러를 변환하고 또 다시 던짐
 func rethrowingFunc1(callback: (Int) throws -> Bool) rethrows {
 enum ChangeError: Error {
 case changeZero
 }
 
 do {
 try callback(0)
 } catch {
 throw ChangeError.changeZero
 }
 }
 
 do {
 try rethrowingFunc1(callback: doSomething)
 } catch {
 print(error)
 }  // changeZero
 
 
 // 생성자
 enum FileError: Error {
 case noName
 }
 
 class File {
 var name: String
 
 init(name: String) throws {
 if name.isEmpty {
 throw FileError.noName
 } else {
 self.name = name
 }
 }
 }
 
 do {
 let _ = try File(name: "")
 } catch {
 print(error)
 }  // noName
 
 
 // 재정의
 class Folder: File {
 override init(name: String) throws {
 try super.init(name: name)
 }
 }
 
 do {
 let _ = try Folder(name: "")
 } catch {
 print(error)
 }  // noName
 
 // defer
 func syntax() {
 defer { print(1) }
 print(2)
 defer { print(3) }
 }
 
 syntax()  // 2 3 1
 
 for i in 1...2 {
 defer { print("defer: \(i)")}
 print("for: \(i)")
 }
 // for: 1
 // defer: 1
 // for: 2
 // defer: 2
 
 // networking
 // 1. 요청할 url 생성
 let movieURL = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?&key=d7880335918ccd5da882f8052717058e&targetDt=20210201"
 
 // 2. URL 구조체 생성
 let structURL = URL(string: movieURL)!
 
 // 3. URLSession 생성
 let session = URLSession.shared
 
 // 4. dataTask
 let task = session.dataTask(with: structURL) { data, response, error in
 if error != nil {
 print("error: \(error!)")
 return
 }
 
 guard let safeData = data else { return }
 
 print(String(decoding: safeData, as: UTF8.self))
 }
 
 // 5. 작업 시작
 task.resume()
 
 // 네트워크 통신
 let movieURL = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?&key=d7880335918ccd5da882f8052717058e&targetDt=20210201"
 
 let url = URL(string: movieURL)!
 
 let session = URLSession.shared
 
 let task = session.dataTask(with: url) { (data, response, error) in
 if error != nil {
 print(error!)
 return
 }
 
 guard let safeData = data else {
 return
 }
 
 // 데이터를 그냥 한번 출력해보기
 //print(String(decoding: safeData, as: UTF8.self))
 
 var movieArray = parseJSON1(safeData)
 print(movieArray!)
 
 //    dump(parseJSON1(safeData)!)
 }
 
 task.resume()
 
 
 // ⭐️ 비동기적으로 동작함
 
 
 
 
 // 받아온 데이터를 우리가 쓰기 좋게 변환하는 과정 (분석) ======================================
 
 // 현재의 형태
 func parseJSON1(_ movieData: Data) -> [DailyBoxOfficeList]? {
 
 do {
 // 스위프트5
 // 자동으로 원하는 클래스/구조체 형태로 분석
 // JSONDecoder
 let decoder = JSONDecoder()
 
 let decodedData = try decoder.decode(MovieData.self, from: movieData)
 
 return decodedData.boxOfficeResult.dailyBoxOfficeList
 
 } catch {
 
 return nil
 }
 
 }
 
 // 서버에서 주는 데이터의 형태 ====================================================
 
 struct MovieData: Codable {
 let boxOfficeResult: BoxOfficeResult
 }
 
 // MARK: - BoxOfficeResult
 struct BoxOfficeResult: Codable {
 let dailyBoxOfficeList: [DailyBoxOfficeList]
 }
 
 // MARK: - DailyBoxOfficeList
 struct DailyBoxOfficeList: Codable {
 let rank: String
 let movieNm: String
 let audiCnt: String
 let audiAcc: String
 let openDt: String
 }
 
 // escaping closure
 func originFucn(a: Int, closure: @escaping (Int) -> ()) {
 let result = a + 10
 closure(result)
 }
 
 originFucn(a: 5) { num in
 print(num)
 }
 
 // 동기
 func task1() {
 print("1: 시작")
 sleep(2)
 print("1: 완료")
 }
 
 func task2() {
 print("2: 시작")
 sleep(2)
 print("2: 완료")
 }
 
 task1()
 task2()
 // 1: 시작
 // 1: 완료, 2: 시작
 // 2: 완료
 
 // 비동기
 func task3() {
 DispatchQueue.global().async {
 print("3: 시작")
 sleep(2)
 print("3: 완료")
 }
 }
 
 func task4() {
 DispatchQueue.global().async {
 print("4: 시작")
 sleep(2)
 print("4: 완료")
 }
 }
 
 task3()
 task4()
 // 3: 시작, 4: 시작
 // 4: 완료, 3: 완료
 
 // 직렬큐
 let serial = DispatchQueue(label: "com.inflearn.serial")
 
 func task5() {
 serial.async {
 print("5: 시작")
 sleep(2)
 print("5: 완료")
 }
 }
 
 func task6() {
 serial.async {
 print("6: 시작")
 sleep(2)
 print("6: 완료")
 }
 }
 
 task5()
 task6()
 // 5: 시작
 // 5: 완료, 6: 시작
 // 6: 완료
 
 // 동시큐
 let concurrent = DispatchQueue.global()
 
 concurrent.async {
 print("7: 시작")
 sleep(2)
 print("7: 완료")
 }
 
 concurrent.async {
 print("8: 시작")
 sleep(2)
 print("8: 완료")
 }
 
 // 7: 시작, 8: 시작
 // 8: 완료, 7: 완료
 
 let concurrent = DispatchQueue.global()
 
 func task2() {
 print("2: 시작")
 sleep(2)
 print("2: 완료")
 }
 
 concurrent.async {
 print("7: 시작")
 sleep(2)
 print("7: 완료")
 }
 
 concurrent.async {
 print("8: 시작")
 sleep(2)
 print("8: 완료")
 }
 
 task2()
 
 // 7: 시작, 8: 시작, 2: 시작
 // 2: 완료, 8: 완료, 7: 완료
 
 // 메인큐
 let mainThread = DispatchQueue.main
 
 mainThread.async {
 // 1번 쓰레드에서 작업 진행
 }
 
 // 글로벌큐
 // 품질 높은순
 let userInteractiveQueue = DispatchQueue.global(qos: .userInteractive)
 let userInitiatedQueue = DispatchQueue.global(qos: .userInitiated)
 let defaultQueue = DispatchQueue.global()  // 주로 사용
 let utilityQueue = DispatchQueue.global(qos: .utility)  // 가끔 사용
 let backgroundQueue = DispatchQueue.global(qos: .background)
 let unspecifiedQueue = DispatchQueue.global(qos: .unspecified)
 
 // 커스텀큐(프라이빗큐)
 DispatchQueue(label: <#T##String#>, qos: <#T##DispatchQoS#>, attributes: <#T##DispatchQueue.Attributes#>, autoreleaseFrequency: <#T##DispatchQueue.AutoreleaseFrequency#>, target: <#T##DispatchQueue?#>)
 DispatchQueue(label: "serial")
 DispatchQueue(label: "concurrent", attributes: .concurrent)
 
 // 메인큐
 let imageView: UIImageView? = nil
 let url = URL(string: "https://bit.ly/32ps0DI")!
 
 URLSession.shared.dataTask(with: url) { data, response, error in
 if error != nil { return }
 guard let imageData = data else { return }
 let photo = UIImage(data: imageData)
 
 DispatchQueue.main.async {
 imageView?.image = photo
 }
 }.resume()
 
 // 리턴형 함수
 func getImageFunc(urlString: String) -> UIImage? {
 let url = URL(string: urlString)!
 var picture: UIImage? = nil
 
 URLSession.shared.dataTask(with: url) { data, response, error in
 if error != nil { return }
 guard let imageData = data else { return }
 picture = UIImage(data: imageData)
 }.resume()
 
 return picture
 }
 
 getImageFunc(urlString: "https://bit.ly/32ps0DI")  // nil
 
 // 비동기함수 설계
 func getImage(urlString: String, completionHandler: @escaping (UIImage?) -> ()) {
 let url = URL(string: urlString)!
 
 URLSession.shared.dataTask(with: url) { data, response, error in
 if error != nil { return }
 guard let imageData = data else { return }
 let photo = UIImage(data: imageData)
 
 completionHandler(photo)
 }.resume()
 }
 
 getImage(urlString: "https://bit.ly/32ps0DI") { image in
 image  // 이미지 나옴
 DispatchQueue.main.async {
 imageView?.image = image
 }
 }
 
 // 캡처주의
 class ViewController {
 let name = "뷰컨"
 
 func printing() {
 DispatchQueue.global().async { [weak self] in
 guard let self = self else { return }
 sleep(2)
 print("글로벌큐에서 출력: \(self.name)")
 }
 }
 
 deinit {
 print("\(name) 메모리 해제")
 }
 }
 
 // 이렇게 하면 메모리에서 해제되지 않음
 //let viewController = ViewController()
 //viewController.printing()
 
 func localScopeRun() {
 let vc = ViewController()
 vc.printing()
 }
 
 //localScopeRun()
 // 뷰컨 메모리 해제
 // "글로벌큐에서 출력: 뷰컨" 뜨는건 맥OS 버그
 
 // 동기함수 -> 비동기함수: 동기/비동기 함수 동일한 결과 나오도록 코딩
 // 동기함수
 func syncFunc(name: String) -> String {
 print("syncFunc 시작")
 sleep(2)
 return name
 }
 
 // 비동기함수
 func asyncFunc(name: String, completionHandler: @escaping (String) -> ()) {
 DispatchQueue.global().async {
 print("asyncFunc 시작")
 sleep(2)
 completionHandler(name)
 }
 }
 
 //print(syncFunc(name: "syncFunc"))
 //asyncFunc(name: "asyncFunc") { name in
 //    print(name)
 //}
 // syncFunc 시작 -> (2초후) syncFunc, asyncFunc 시작 -> (2초후) asyncFunc
 
 // 비동기 함수
 let url = URL(string: "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?&key=d7880335918ccd5da882f8052717058e&targetDt=20210201")!
 
 print(1)
 
 URLSession.shared.dataTask(with: url) { data, response, error in
 if error != nil { return }
 guard let safeData = data else { return }
 print(String(decoding: safeData, as: UTF8.self))
 }.resume()
 
 print(2)
 // 1 2 -> 데이터
 
 // async/await
 func asyncFunc(num: Int) async -> Int {
 sleep(2)
 return num * 2
 }
 
 print(await asyncFunc(num: 5))
 
 // thread - safe
 var array = [String]()
 var safeArray = [String]()
 
 for i in 1...10 {
 DispatchQueue.global().async {
 array.append(String(i))
 
 DispatchQueue(label: "serial").async {
 safeArray.append(String(i))
 }
 }
 }
 
 DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
 print("array: \(array)")
 print("safeA: \(safeArray)")
 }
 
 // array: ["1", "4", "5", "6", "7", "8", "9", "10"]
 // safeA: ["1", "4", "3", "10", "6", "2", "5", "8", "7", "9"]
 
 // Generics
 func printing<T>(array: [T]) {
 print(array)
 }
 
 printing(array: [1, 2])  // [1, 2]
 printing(array: ["수", "지"])  // ["수", "지"]
 
 // 구조체, 클래스에서의 제네릭
 struct 구조체<T> {
 var a: T
 var b: T
 }
 
 let stringInstance = 구조체(a: "a", b: "b")
 let intInstance = 구조체(a: 1, b: 2)
 
 // 열거형에서의 제네릭
 enum 열거형<T> {
 case name
 case age
 case info(T)
 }
 
 열거형.info("여자")
 열거형.info(170)
 
 // 구조체의 확장
 extension 구조체 {
 func returnTuple() -> (T, T) {
 return (a, b)
 }
 }
 
 print(stringInstance.returnTuple())  // ("a", "b")
 
 // where절을 통한 제약
 extension 구조체 where T == Int {
 func getIntArray() -> [T] {
 return [a, b]
 }
 }
 
 print(intInstance.getIntArray())  // [1, 2]
 //stringInstance.
 
 // 프로토콜 제약
 func findIndex<T: Equatable>(item: T, array: [T]) -> Int? {
 for(index, value) in array.enumerated() {
 if value == item {
 return index
 }
 }
 return nil
 }
 
 if let index = findIndex(item: 1, array: [1, 2, 3]) {
 print("item과 일치하는 요소의 index: \(index)")
 }
 // item과 일치하는 요소의 index: 0
 
 // 클래스 제약
 class Animal {}
 class Cat: Animal {}
 class Pen {}
 
 func animalClass<T: Animal>(something: T) {}
 
 animalClass(something: Animal())
 animalClass(something: Cat())
 //animalClass(something: Pen())
 
 // 구체/특정화 함수 구현
 func findIndex(item: String, array: [String]) -> Int? {
 for (index, value) in array.enumerated() {
 if item.caseInsensitiveCompare(value) == .orderedSame {
 return index
 }
 }
 return nil
 }
 
 if let index2 = findIndex(item: "suji", array: ["Sujin", "Suji", "ddudi"]) {
 print("문자열 비교:", index2)
 }
 // 문자열 비교: 1
 
 // 프로토콜에서의 제네릭
 protocol Compare {
 associatedtype Element: Equatable
 
 func comparing(something: Element)
 }
 
 struct CompareStruct: Compare {
 typealias Element = String
 
 func comparing(something: String) {
 if something == "수지" {
 print("일치")
 } else {
 print("불일치")
 }
 }
 }
 
 CompareStruct().comparing(something: "수지")  // 일치
 
 // Result Type
 // 에러 정의
 enum SomeError: Error {
 case noName
 case noFile
 }
 
 // Result타입 함수 정의
 func information(name: String) -> Result<String, SomeError> {
 if name.isEmpty {
 return Result.failure(SomeError.noName)
 } else if name == " " {
 return Result.failure(SomeError.noFile)
 } else {
 return Result.success(name)
 }
 }
 
 // 리턴값 받아서
 let result = information(name: "수지")
 
 // 처리
 switch result {
 case .success(let data):
 print("이름:", data)
 case .failure(let error):
 print(error)
 }
 // 이름: 수지
 
 // .get()
 do {
 let data = try result.get()
 print("이름: \(data)")
 } catch {
 print(error)
 }
 // 이름: 수지
 
 
 // 기존 에러 처리 방식
 // throwing함수 정의
 func information2(name: String) throws -> String {
 if name.isEmpty {
 throw SomeError.noName
 } else if name == " " {
 throw SomeError.noFile
 } else {
 return name
 }
 }
 
 // throwing함수 처리
 do {
 let data = try information2(name: "")
 print("이름: \(data)")
 } catch {
 print(error)
 }
 // noName
 
 // Networking - throwing Vs. Result type
 enum NetworkError: Error {
 case sessionError
 case optionalBindingError
 }
 
 // throwing function
 func performRequest(with urlString: String, completion: @escaping (Data?, NetworkError?) -> ()) {
 guard let url = URL(string: urlString) else { return }
 
 URLSession.shared.dataTask(with: url) { data, response, error in
 if error != nil {
 completion(nil, .sessionError)
 return
 }
 
 guard let safeData = data else {
 completion(nil, .optionalBindingError)
 return
 }
 
 completion(safeData, nil)
 }.resume()
 }
 
 performRequest(with: "주소") { data, error in
 if error != nil { print(error!) }
 if let safeData = data { print(safeData) }
 }
 
 
 // Result type
 func performRequest1(with urlString: String, completion: @escaping (Result<Data, NetworkError>) -> ()) {
 guard let url = URL(string: urlString) else { return }
 
 URLSession.shared.dataTask(with: url) { data, response, error in
 if error != nil {
 completion(.failure(.sessionError))
 return
 }
 
 guard let safeData = data else {
 completion(.failure(.optionalBindingError))
 return
 }
 
 completion(.success(safeData))
 }.resume()
 }
 
 performRequest1(with: "주소") { result in
 switch result {
 case .success(let data):
 print(data)
 case .failure(let error):
 print(error)
 }
 }
 
 // Date 구조체
 let now = Date()  // Date 인스턴스 생성
 
 let yesterday = now - 86400
 now.timeIntervalSince(yesterday)  // 86,400 (차이)
 now.distance(to: yesterday)  // -86,400 (거리 - 백터개념)
 
 let tomorrow = Date(timeIntervalSinceNow: 86400)
 now.advanced(by: 86400)  // 내일
 now.addingTimeInterval(3600 * 4)  // 4시간 후
 
 // Swift에 정의된 타임존 확인
 for localName in TimeZone.knownTimeZoneIdentifiers {
 print(localName)
 }
 
 // 현재 설정되어 있는 타임존 확인
 TimeZone.current  // Asia/Seoul (fixed)
 
 // 절대 시점 초기준 Date -> 달력의 요소로 변환
 // 양력(Gregorian calendar): 전 세계 표준 달력
 var calendar = Calendar.current
 
 // 직접 생성
 let calendar1 = Calendar(identifier: .gregorian)
 
 // 유저의 설정대로 생성
 let calendar2 = Calendar.autoupdatingCurrent
 
 
 // 지역 설정
 calendar.locale  // en_001 (fixed)
 calendar.locale = Locale(identifier: "ko_KR")
 
 
 // 타임존 설정
 calendar.timeZone  // Asia/Seoul (fixed)
 calendar.timeZone = TimeZone(identifier: "Asia/Seoul")!
 
 
 // 년/월/일, 시/분/초, 요일
 let now = Date()
 
 let year: Int = calendar.component(.year, from: now)
 let month: Int = calendar.component(.month, from: now)
 let day: Int = calendar.component(.day, from: now)
 
 let hour: Int = calendar.component(.hour, from: now)
 let minute: Int = calendar.component(.minute, from: now)
 let second: Int = calendar.component(.second, from: now)
 
 let weekday: Int = calendar.component(.weekday, from: now)
 // 일요일(1), 월요일(2), 화요일(3), 수요일(4), 목요일(5), 금요일(6), 토요일(7)
 
 
 // 여러 개의 데이터 배열로 한번에 받기
 let today: DateComponents = calendar.dateComponents([.year, .month, .day], from: now)
 // year: 2024 month: 6 day: 19 isLeapMonth: false
 
 print(today.year)  // Optional(2024)
 print(today.month!)  // 6
 
 
 // 활용
 // 요일 추출
 enum Weekday: Int {
 case sunday = 1, monday, tuesday, wednesday, thursday, friday, saturday
 
 static var today: Weekday {
 let weekday = Calendar.current.component(.weekday, from: Date())
 return Weekday(rawValue: weekday)!
 }
 }
 Weekday.today
 
 // 두 날짜 사이
 let startDay = Date()
 let endDate = startDay.addingTimeInterval(3600 * 24 * 7)
 
 let someDays = Calendar.current.dateComponents([.day], from: startDay, to: endDate).day!  // 7
 let someHours = Calendar.current.dateComponents([.hour], from: startDay, to: endDate).hour!  // 168
 
 // Date <-> String
 let dateFormatter = DateFormatter()
 
 // 1. 지역 설정
 dateFormatter.locale = Locale(identifier: "ko_KR")
 
 // 2. 시간대 설정
 dateFormatter.timeZone = TimeZone.current
 
 // 형식 문자열로 설정
 // 1. 날짜 형식 선택
 dateFormatter.dateStyle = .full  // 2024년 6월 19일 수요일
 dateFormatter.dateStyle = .long  // 2024년 6월 19일
 dateFormatter.dateStyle = .medium  // 2024. 6. 19.
 dateFormatter.dateStyle = .short  // 2024. 6. 19.
 dateFormatter.dateStyle = .none
 
 // 2. 시간 형식 선택
 dateFormatter.timeStyle = .full  // 오후 5시 28분 31초 대한민국 표준시
 dateFormatter.timeStyle = .long  // 오후 5시 29분 5초 GMT+9
 dateFormatter.timeStyle = .medium  // 오후 5:29:35
 dateFormatter.timeStyle = .short  // 오후 5:30
 dateFormatter.timeStyle = .none
 
 // 커스텀 형식으로 설정
 dateFormatter.dateFormat = "yyyy년 MM월 dd일 (E)"
 
 // 변환: 시간 + 날짜 -> 문자열
 let today = dateFormatter.string(from: Date())  // 2024년 06월 19일 (수)
 
 // 변환: 문자열 -> Date
 let sometime = dateFormatter.date(from: "2024년 6월 19일 (수)")  // 19 Jun 2024 at 12:00 AM
 
 // 활용
 struct Post {
 var title: String = "제목"
 var description: String = "내용"
 
 private let date = Date()
 
 var dateString: String {
 let formatter = DateFormatter()
 
 formatter.locale = Locale(identifier: "en_001")
 formatter.timeZone = TimeZone.current
 
 formatter.dateStyle = .medium
 formatter.timeStyle = .short
 
 return formatter.string(from: date)
 }
 }
 
 let post = Post()
 post.dateString  // 19 Jun 2024 at 5:43 PM
 
 // DateComponents - 활용
 // 특정 날짜, 시간으로 Date생성
 extension Date {
 init?(y: Int, m: Int, d: Int) {
 var components = DateComponents()
 components.year = y
 components.month = m
 components.day = d
 
 guard let date = Calendar.current.date(from: components) else { return nil }
 
 self = date
 }
 }
 
 let someDate = Date(y: 2020, m: 7, d: 7)
 print(someDate)  // Optional(2020-07-06 15:00:00 +0000)
 
 // Access Control
 // 접근 수준: 타입 >= 타입을 사용하는 속성/메서드
 //open var openVar: String = "public struct String"
 public var publicVar: String = "public struct String"
 internal var internalVar: String = "public struct String"
 
 // 외부에서 읽기만 가능
 class 클래스{
 private var _name = "이름"
 
 var name: String {
 return _name
 }
 
 public private(set) var age = 20
 }
 
 let instance = 클래스()
 instance.name  // 이름
 //instance.name = "쓰기 불가"
 
 instance.age  // 20
 //instance.age = 30
 
 // Access Control
 // Inheritance
 // type 접근제어
 public class PublicA {}
 //open class OpenB: PublicA {}
 // Superclass 'PublicA' of open class must be open
 // open class(B)의 슈퍼클래스(A)는 반드시 open이어야한다
 
 // member 접근제어
 public class A {
 fileprivate func a() {}
 }
 class B: A {
 override func a() {
 super.a()
 }
 }
 
 
 // Extension
 public struct StructA {
 private var a = "private변수"
 }
 
 extension StructA {  // public
 mutating func function() {
 self.a = "접근가능"
 }
 }
 
 // String
 // 문자열도 배열과 같은 하나의 데이터 바구니이지만 인덱스 접근은 불가능
 // 데이터 바구니 - 배열
 let array = [1, 2, 3]
 array[0]  // 1
 
 // 데이터 바구니 - 문자열
 //"문자열"[0]
 
 
 // 의미 글자수 기반
 let 한1 = "\u{D55C}"  // "한"
 let 한2 = "\u{1112}\u{1161}\u{11AB}"  // "ㅎㅏㄴ"
 한1 == 한2  // true
 
 
 let café = "cafe" + "\u{301}"  // café
 
 var string: String = "café"
 string.count  // 4
 
 var nsString: NSString = "café"
 nsString.length  // 5
 
 // Toll-free Bridged
 // String <-> NSString
 nsString = string as NSString
 string = nsString as String
 
 // Toll-free Bridged
 // String <-> NSString
 var string: String = "String"
 let nsString: NSString = string as NSString
 string = nsString as String
 
 // Multiline String Literal
 let linesWithIndentation = """
 마지막 줄의 \"\"\"는 들여쓰기의 기준 역할을 한다
 내부의 줄바꿈이 그대로 출력된다
 내부의 특수문자는 'Raw String방식'으로 입력된다
 """
 print(linesWithIndentation)
 //      마지막 줄의 """는 들여쓰기의 기준 역할을 한다
 // 내부의 줄바꿈이 그대로 출력된다
 // 내부의 특수문자는 'Raw String방식'으로 입력된다
 
 
 // Escape Character Sequence
 print("null문자:\0(null)")
 print("백슬레시:\\")
 print("(수평)탭:\t(tab)")
 print("줄바꿈:\n(개행문자)")
 print("캐리지 리턴:\r(앞줄이동)")
 print("쌍따옴표:\"")
 print("작은따옴표:\'")
 
 
 // Raw String(확장 구분자)
 let rawString1 = #"내부에 문자 '그대로 출력'가능"#
 let rawString2 = #"이스케이프 시퀀스 쓰고싶으면 \#n 중간에 #넣기"#
 let rawString3 = ###"여러개의 #써도 되는데 \###t#의 갯수 맞추기"###
 
 print(rawString1)
 print(rawString2)
 print(rawString3)
 // 내부에 문자 '그대로 출력'가능
 // 이스케이프 시퀀스 쓰고싶으면
 //  중간에 #넣기
 // 여러개의 #써도 되는데     #의 갯수 맞추기
 
 // String Interpolation
 struct Dog {
 var name: String
 }
 
 struct Point {
 var x: Int
 var y: Int
 }
 
 let dog = Dog(name: "초코")
 let point = Point(x: 1, y: 2)
 
 print(dog)  // Dog(name: "초코")
 print("\(point)")  // Point(x: 1, y: 2)
 
 //extension Dog: CustomStringConvertible {
 //    var description: String {
 //        return "Dog 이름은 \(name)"
 //    }
 //}
 
 extension Point: CustomStringConvertible {
 var description: String {
 return "Point (\(x), \(y))"
 }
 }
 
 print(dog)  // Dog 이름은 초코
 print("\(point)")  // Point (1, 2)
 
 extension String.StringInterpolation {
 mutating func appendInterpolation(_ value: Dog) {
 appendInterpolation("Dog: \(value.name)")
 }
 
 mutating func appendInterpolation(_ value: Point, style: NumberFormatter.Style) {
 let formatter = NumberFormatter()
 formatter.numberStyle = style
 
 if let x = formatter.string(for: value.x), let y = formatter.string(for: value.y) {
 appendInterpolation("x: \(x), y: \(y)")
 } else {
 appendInterpolation("Point: x(\(value.x)), y(\(value.y))")
 }
 }
 }
 
 print(dog)  // Dog(name: "초코")
 print("\(point, style: .percent)")  // x: 100%, y: 200%
 
 // String(format:arguments)
 struct Point {
 var x: Double
 var y: Double
 }
 
 extension Point: CustomStringConvertible {
 var description: String {
 return String(format: "(%1$.2f, %2$.2f)", x, y)
 }
 }
 
 let point = Point(x: 1.555, y: 2)
 print(point)  // (1.55, 2.00)
 
 
 let firstName = "수지"
 let lastName = "장"
 
 let korean = "%1$@ %2$@"
 let english = "%2$@ %1$@"
 
 func name(language: String) {
 print(String(format: language, lastName, firstName))
 }
 
 name(language: korean)  // 장 수지
 name(language: english)  // 수지 장
 
 
 // NumberFormatter
 let numberFormatter = NumberFormatter()
 numberFormatter.roundingMode = .halfUp
 numberFormatter.maximumFractionDigits = 3  // 12,345.346
 numberFormatter.minimumFractionDigits = 6  // 12,345.345670
 numberFormatter.numberStyle = .decimal
 
 print(numberFormatter.string(for: 12345.34567)!)
 
 // 문자열의 Substring 타입 = String.SubSequence
 var greeting = "Hello, world!"
 
 let index: String.Index = greeting.firstIndex(of: ",") ?? greeting.endIndex
 
 // 메모리 공간 공유
 let beginnning: String.SubSequence = greeting[..<index]  // Hello
 
 var word1: String.SubSequence = greeting.prefix(5)  // Hello
 var word2: String.SubSequence = greeting.suffix(5)  // orld!
 
 // Hello를 가리킬 수 없게 되니까 서브스트링들은 새로운 메모리 공간 생성
 greeting = "Hi, world!"
 
 beginnning  // Hello (여전히 String.SubSequence타입)
 word1  // Hello
 word2  // orld!  // 이부분은 안바꼈는데도 새로운 메모리 공간을 생성하나?
 
 // 명시적으로 문자열로 변환해서 저장 가능 (서브스트링에서 벗어남)
 let type: String = String(beginnning)
 
 let type2 = beginnning  // 여전히 String.SubSequence타입
 
 // 문자열 다루기: 문자(열) <-> 배열
 var string: String = "Swift"
 
 // 각각 따로따로
 // String → Array<String> ⭐️
 var stringArray: [String] = string.map { chr in String(chr) }  // ["S", "w", "i", "f", "t"]
 stringArray = string.map { String($0) }  // ["S", "w", "i", "f", "t"]
 
 
 // String → Array<Character>
 let characterArray: [Character] = Array(string)  // ["S", "w", "i", "f", "t"]
 // [String.Element] -> typealias Element = Character
 
 
 // Array<String> → String ⭐️
 string = stringArray.joined()  // Swift
 
 
 // Array<Character> → String
 string = String(characterArray)  // Swift
 
 
 // 통째로 String -> Array<String>
 stringArray = Array(arrayLiteral: string)  // ["Swift"]
 
 
 // 활용: 뒤죽박죽 섞기 (문자열의 shuffled / 배열의 shuffled)
 // 문자열.shuffled -> [문자] -> 문자열
 let shuffled: [Character] = string.shuffled()  // ["i", "S", "t", "f", "w"]
 String(string.shuffled())  // fwtiS
 
 // 문자열 -> [문자열].shuffled -> 문자열 ⭐️
 string.map{ String($0) }.shuffled().joined()  // // fwtiS
 
 // 대소문자
 var string = "swift"
 
 // 전체 소문자로 바꾼 문자열 리턴 (원본 유지)
 string.lowercased()  // "swift"
 
 // 전체 대문자로 바꾼 문자열 리턴 (원본 유지)
 string.uppercased()  // "SWIFT"
 
 // 맨 앞글자만 대문자로 바꾼 문자열 리턴 (원본 유지)
 string.capitalized  // "Swift"
 
 print(string)  // swift
 
 
 // Swift는 대소문자 구분
 "apple" == "Apple"  // false
 
 // 대소문자 구분 없이 문자열 비교
 "apple".lowercased() == "Apple".lowercased()  // true
 
 // String property: count, isEmpty
 // 빈 문자
 " ".count  // 1
 " ".isEmpty  // false
 
 // 빈 문자열
 "".count  // 0
 "".isEmpty  // true
 
 
 // 빈 문자열이 nil은 아니다
 // 애초에 타입이 String (String?이 아니어서 nil일 수 없다)
 // Comparing non-optional value of type 'String' to 'nil' always returns false
 // 'String' 유형의 논옵셔널 값을 'nil'과 비교하면 항상 false를 반환
 "" == nil  // false
 
 // <String.Index>
 let string = "String.Index"
 
 // 앞에서부터 셌을때 해당 문자의 인덱스
 let dotIndex = string.firstIndex(of: ".")!
 string[dotIndex]  // .
 
 // 해당 인덱스로부터 몇칸 떨어진 인덱스
 let someIndex = string.index(dotIndex, offsetBy: 1)
 
 // 해당 인덱스 다음의 인덱스
 string[string.index(after: dotIndex)]  // I
 
 // 인덱스가 범위를 벗어나면 에러
 if string.startIndex <= someIndex && someIndex < string.endIndex {
 print(string[someIndex])
 }
 // I
 
 for index in string.indices {
 print("\(index): \(string[index])")
 }
 // Index(_rawBits: 15): S
 // Index(_rawBits: 65799): t
 // Index(_rawBits: 131335): r
 // Index(_rawBits: 196871): i
 // Index(_rawBits: 262407): n
 // Index(_rawBits: 327943): g
 // Index(_rawBits: 393479): .
 // Index(_rawBits: 459015): I
 // Index(_rawBits: 524551): n
 // Index(_rawBits: 590087): d
 // Index(_rawBits: 655623): e
 // Index(_rawBits: 721159): x
 
 // 인덱스의 범위
 let lower = string.index(string.endIndex, offsetBy: -7)
 let upper = string.index(string.endIndex, offsetBy: -2)
 string[lower...upper]  // g.Inde
 
 // 문자열이 해당하는 범위 -> 문자열 인덱스 범위 (옵션: 대소문자 구분X)
 let range = string.range(of: "str", options: .caseInsensitive)!
 string[range]  // Str
 
 // 문자열 인덱스 사이 거리 측정
 print(string.distance(from: lower, to: upper))  // 5
 
 // 삽입(insert), 교체(replace), 추가(append), 삭제(remove)
 var string = "Hello"
 
 // 삽입(insert)
 string.insert("!", at: string.endIndex)  // Hello!
 string.insert(contentsOf: " Swift", at: string.index(before: string.endIndex))  // Hello Swift!
 
 // 교체(replace)
 if let range = string.range(of: "!") {
 string.replaceSubrange(range, with: "~~~")
 }  // Hello Swift~~~
 string.replacingOccurrences(of: "swift", with: "World", options: .caseInsensitive)  // Hello World~~~
 
 // 추가(append)
 string.append("!")  // Hello Swift~~~!
 string.append(contentsOf: " Yeah")  // Hello Swift~~~! Yeah
 
 // 삭제(remove)
 string.remove(at: string.index(string.endIndex, offsetBy: -1))  // h
 print(string)  // Hello Swift~~~! Yea
 var range = string.index(string.startIndex, offsetBy: 15)...string.index(before: string.endIndex)
 string.removeSubrange(range)  // Hello Swift~~~!
 
 
 // 공백 문자열의 인덱스 찾기 -> 그 자리에 super 삽입
 if let firstIndex = string.firstIndex(of: " ") {
 string.insert(contentsOf: " super", at: firstIndex)
 print(string)  // Hello super Swift~~~!
 }
 
 // super 찾아서 삭제
 if let lastIndex = string.lastIndex(of: " ") {
 let range = string.index(lastIndex, offsetBy: -5)...lastIndex
 string.removeSubrange(range)
 print(string)  // Hello Swift~~~!
 }
 
 // 범위에 문자열을 직접적으로 사용해서 교체
 if let range = string.range(of: "~~~!") {
 string.replaceSubrange(range, with: "!")
 print(string)  // Hello Swift!
 }
 
 // 활용
 var string2 = "HelloSwift"
 
 // 원하는 위치에 삽입
 if let stringIndex = string2.firstIndex(of: "S") {
 string2.insert(contentsOf: " ", at: stringIndex)
 print(string2)  // Hello Swift
 }
 
 // 원하는 범위 교체
 if let stringIndex = string2.lastIndex(of: " ") {
 let range = stringIndex...string2.index(before: string2.endIndex)
 string2.replaceSubrange(range, with: " World")
 print(string2)  // Hello World
 }
 
 
 // 원하는 문자열 삭제
 if let range = string2.range(of: "world", options: .caseInsensitive) {
 string2.removeSubrange(range)
 print(string2)  // Hello
 }
 
 // 대소문자 무시하고 비교하는 메서드
 var a = "Swift"
 var b = "swift"
 // 동일
 
 a = "apple"
 b = "bag"
 // 오름차순
 
 a = "bb"
 b = "ba"
 // 내림차순
 
 let result = a.caseInsensitiveCompare(b)  // a -> b
 
 switch result {
 case .orderedAscending:
 print("오름차순: 작은것 -> 큰것 (123/ABC)")
 case .orderedDescending:
 print("내림차순: 큰것 -> 작은것")
 case .orderedSame:
 print("동일")
 }  // 동일
 
 a.caseInsensitiveCompare(b) == ComparisonResult.orderedSame  // false
 
 // 문자열 비교 옵션
 // 발음 구별기호 무시
 "café".compare("cafe", options: .diacriticInsensitive) == .orderedSame  // true
 
 // 글자 넓이 무시
 "ァ".compare("ｧ", options: .widthInsensitive) == .orderedSame  // true
 
 // 강제적 대소문자 구분
 "Hi".compare("hi", options: [.forcedOrdering, .caseInsensitive]) == .orderedAscending  // true
 
 // 숫자 전체 인식해서 비교
 "photo9.jpg".compare("photo10.jpg", options: .numeric) == .orderedAscending  // true
 
 // 글자 그 자체 비교
 "한".compare("ㅎ"+"ㅏ"+"ㄴ", options: .literal) == .orderedSame  // false
 
 // 앞에서부터 범위만큼 일치하는지 비교
 if let _ = "Hello, Swift".range(of: "Hello", options: .anchored) {
 print("접두어 일치")
 }  // 접두어 일치
 
 // 뒤에서부터 범위만큼 일치하는지 비교
 if let _ = "Hello, Swift".range(of: "swift", options: [.anchored, .backwards]) {
 print("접미어 일치")
 }
 
 // 포함
 let string = "Coworker"
 
 // 전체 문자열에서 포함 여부
 string.contains("co")  // false
 string.lowercased().contains("co")  // true
 
 // 접두어에서 포함 여부
 string.hasPrefix("Co")  // true
 
 // 접미어에서 포함 여부
 string.hasSuffix("worker")  // true
 
 
 // 반환
 // 접두어 반환
 string.prefix(3)  // Cow
 
 // 접미어 반환
 string.suffix(1)  // r
 
 // 공통 접두어 반환
 string.commonPrefix(with: "combine", options: .caseInsensitive)  // Co
 
 // 앞에서부터 drop시킨 나머지 반환
 string.dropFirst(2)  // worker
 
 // 뒤에서부터 drop시킨 나머지 반환
 string.dropLast(3)  // Cowor
 
 // 정규식
 let phone = "010.1234-1234"
 let telephoneNumRegex = #"[0-9]{3}[- .]?[0-9]{4}[- .]?[0-9]{4}$"#
 
 if let _ = phone.range(of: telephoneNumRegex, options: .regularExpression) {
 print("유효한 전화번호로 판단")
 }  // 유효한 전화번호로 판단
 
 
 let email = "id@gmail.com"
 let emailRegex = #".*@.*\..*"#
 
 if let newEmail = email.range(of: emailRegex, options: .regularExpression) {
 print("유효한 이메일 범위: \(newEmail)")
 }  // 유효한 이메일 범위: Index(_rawBits: 15)..<Index(_rawBits: 786436)
 
 
 let address = "12345"
 let addressRegex = #"[0-9]{5}"#
 
 if let userAddress = address.range(of: addressRegex, options: .regularExpression) {
 print("유효한 우편번호 범위: \(userAddress)")
 }  // 유효한 우편번호 범위: Index(_rawBits: 15)..<Index(_rawBits: 327687)
 
 // 검색 & 삭제
 let string = "! S+-! wift !"
 
 // 문자열의 앞뒤 다듬기
 string.trimmingCharacters(in: [" ", "!"])  // S+-! wift
 print(string)  // ! S+-! wift !
 
 
 // 원하는 문자열 기준으로 잘라서 배열로 만들기
 // components(separatedBy:)
 let array: [String] = string.components(separatedBy: .symbols)
 print(array)  // ["! S", "-! wift !"]
 array.joined()  // ! S-! wift !
 
 // split(separator:)
 let substringArray: [Substring] = string.split(separator: [" "])
 print(substringArray)  // ["!", "S+-!", "wift", "!"]
 // CharacterSet사용안됨
 
 // split{}
 print("010-1234-1234".split { chr in
 return chr == "-"
 })  // ["010", "1234", "1234"]
 // true인 문자열을 잘라냄
 
 
 // 특정 문자열 검색 - 문자열 인덱스의 범위 활용
 let name = "J Suji"
 
 if let initial = name.rangeOfCharacter(from: .uppercaseLetters) {
 print(initial)  // Index(_rawBits: 15)..<Index(_rawBits: 65541)
 print(name[initial])  // J
 }
 
 // Swift의 숫자 리터럴 표기법
 var num: Int = 25
 
 // 2진법, 8진법, 16진법의 수 직접 쓰는법
 num = 0b00011001
 num = 0o31
 num = 0x19
 
 // 컴퓨터는 숫자 사이의 언더바는 읽지 않음
 num = 1_000_000
 
 // Swift의 정수 타입
 MemoryLayout<Int>.size  // 8 (byte)
 Int.max  // 2^63 - 1 (부호 포함 / 0 포함) 9,223,372,036,854,775,807
 Int.min  // -2^63 (부호 포함 / 0 포함X) -9,223,372,036,854,775,808
 
 MemoryLayout<UInt>.size  // 8
 UInt.max  // 2^64 - 1 (부호 포함X / 0 포함) 18,446,744,073,709,551,615
 UInt.min  // 0
 
 // overflow
 // UInt8: 0 ~ 255
 // 오버플로우 더하기 &+
 let maxNum = UInt8.max  // 255
 maxNum &+ 1  // 0
 // 1111 1111 +1 = (1)0000 0000
 
 // 오버플로우 빼기 &-
 let minNum = UInt8.min  // 0
 minNum &- 1  // 255
 // 0000 0000 -1 = 1을 꿔와서 1111 1111
 
 // Int8: -128 ~ 127
 // 오버플로우 곱하기 &*
 // &* 2 는 비트를 왼쪽으로 한칸 이동
 let num = Int8.max  // 127
 num &* 2  // -2
 // 1111 1111 *2 = 1111 1110 (부호비트 - -> 보수로 계산 -000 0010 = -2
 
 // 단락 평가
 // AND: true && true 일때만 true -> 앞의 표현식이 true 일때만 뒤까지 실행
 // OR: false || false 일때만 false -> 앞의 표현식이 false 일때만 뒤까지 실행
 var trueFunc = 0
 var falseFunc = 0
 
 func trueChecking() -> Bool {
 trueFunc += 1
 return true
 }
 
 func falseChecking() -> Bool {
 falseFunc += 1
 return false
 }
 
 if trueChecking() && falseChecking() || falseChecking() && trueChecking() {}
 print("trueFunc: \(trueFunc), falseFunc: \(falseFunc)")
 // trueFunc: 1, falseFunc: 2
 
 
 // Side-Effect 제거법
 // : 논리와 상관없이 무조건 같은 횟수로 실행된다
 trueFunc = 0
 falseFunc = 0
 
 let trueResult1 = trueChecking()
 let falseResult1 = falseChecking()
 let trueResult2 = trueChecking()
 let falseResult2 = falseChecking()
 
 if trueResult1 && falseResult1 || falseResult2 && trueResult2 {}
 print("trueFunc: \(trueFunc), falseFunc: \(falseFunc)")
 // trueFunc: 2, falseFunc: 2
 
 // 비트 논리 연산자
 let a: UInt8 = 0b0000_1111  // 15
 let b: UInt8 = 0b0011_1100  // 60
 
 print(String(~a, radix: 2))  // 1111_0000 (240)
 print(String(a & b, radix: 2))  // 1100 (12)
 print(String(a | b, radix: 2))  // 11_1111 (63)
 print(String(a ^ b, radix: 2))  // 11_0011 (51)
 
 // 비트 이동 연산자
 let x: UInt8 = 0b0000_0001
 let y: UInt8 = 0b1000_0000
 
 print(String(x << 1, radix: 2))  // 10
 print(String(y >> 1, radix: 2))  // 0100_0000
 
 
 let i: Int8 = 0b00000001
 let j: Int8 = -4  // 1111_1100 (-100)
 
 print(String(i << 6, radix: 2))  // 100_0000
 print(String(i << 7, radix: 2))  // -1000_0000 (오버플로우 -128)
 print(String(i << 8, radix: 2))  // 0 (8이상부터는 전부 0)
 
 print(String(j >> 1, radix: 2))  // -10
 print(String(j >> 2, radix: 2))  // -1 (2이상부터는 전부 -1)
 
 struct Vector2D {
 var x: Int
 var y: Int
 }
 
 // 기본 연산자 직접 구현
 extension Vector2D {
 // 이항 연산자
 static func + (lhs: Vector2D, rhs: Vector2D) -> Vector2D {
 return Vector2D(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
 }
 
 // 단항 연산자
 static prefix func - (vector: Vector2D) -> Vector2D {
 return Vector2D(x: -vector.x, y: -vector.y)
 }
 
 // 복합 할당 연산자
 static func += (lhs: inout Vector2D, rhs: Vector2D) {
 lhs = lhs + rhs
 }
 }
 
 var vector1 = Vector2D(x: 1, y: 2)
 let vector2 = Vector2D(x: 3, y: 4)
 
 vector1 + vector2  // Vector2D(x: 4, y: 6)
 -vector1  // Vector2D(x: -1, y: -2)
 vector1 += vector2
 print(vector1)  // Vector2D(x: 4, y: 6)
 
 
 // 비교 연산자 직접 구현
 extension Vector2D: Equatable, Comparable {
 //    static func == (lhs: Vector2D, rhs: Vector2D) -> Bool {
 //        return (lhs.x == rhs.x) && (lhs.y == rhs.y)
 //    }
 
 static func < (lhs: Vector2D, rhs: Vector2D) -> Bool {
 return (lhs.x * lhs.y) < (rhs.x * rhs.y)
 }
 }
 
 vector1 == vector2  //  false
 vector1 > vector2  // true
 
 
 // 열거형의 연관값
 enum Weekday: Equatable, Comparable {
 case mon(Int)
 case tue(String)
 case wed
 }
 
 Weekday.mon(0) == Weekday.wed  // false
 Weekday.mon(1) == Weekday.mon(1)  // true
 Weekday.tue("A") < Weekday.tue("a")  // true
 
 // 사용자 정의 연산자
 struct Vector2D {
 var x: Int
 var y: Int
 }
 
 precedencegroup MyPrecedence {
 higherThan: AdditionPrecedence
 associativity: left
 }
 
 infix operator **: MyPrecedence
 
 extension Vector2D {
 static func **(lhs: Vector2D, rhs: Vector2D) -> Vector2D {
 return Vector2D(x: lhs.x * rhs.x, y: lhs.y * rhs.y)
 }
 }
 
 let vector1 = Vector2D(x: 1, y: 2)
 let vector2 = Vector2D(x: 3, y: 4)
 print(vector1 ** vector2)  // Vector2D(x: 3, y: 8)
 
 // Memory Safety하지 않음: Single Thread가 하나의 메모리에 동시 접근
 var count = 0
 
 func counting(num: inout Int) {
 num += count
 }
 
 //counting(num: &count)
 // error: Execution was interrupted, reason: signal SIGABRT.
 
 // Equatable Protocol
 // 요구사항: static func == (lhs: Self, rhs: Self) -> Bool {}
 class Info {
 var name = "이름"
 }
 
 let instance1 = Info()
 let instance2 = Info()
 
 //instance1 == instance2
 // error: Binary operator '==' cannot be applied to two 'Info' operands
 
 instance1 === instance2  // false
 
 extension Info: Equatable {
 static func == (lhs: Info, rhs: Info) -> Bool {
 return lhs.name == rhs.name
 }
 }
 
 instance1 == instance2  // true
 instance1 != instance2  // false
 
 // Comparable Protocol
 // 요구사항: static func < (lhs: Self, rhs: Self) -> Bool {}
 struct Animal {
 var age: Int
 }
 
 extension Animal: Comparable {
 static func < (lhs: Animal, rhs: Animal) -> Bool {
 return lhs.age < rhs.age
 }
 }
 
 let dog = Animal(age: 2)
 let cat = Animal(age: 3)
 
 dog <= cat  // true
 
 // Hashable Protocol
 // 요구사항: func hash(into hasher: inout Hasher) { hasher.combine(저장속성) }
 class Id {
 var id: String = "id"
 }
 
 extension Id: Hashable {
 static func == (lhs: Id, rhs: Id) -> Bool {
 return lhs.id == rhs.id
 }
 
 func hash(into hasher: inout Hasher) {
 hasher.combine(id)
 }
 }
 
 let id = Id()
 let idSet: Set = [id]
 
 // CaseIterable Protocol
 enum Rps: CaseIterable {
 case rock
 case scissors
 case paper
 }
 
 let computer = Rps.allCases
 computer.count  // 3
 computer.map { "\($0)" }.joined(separator: " / ")  // "rock / scissors / paper"
 computer.randomElement()  // .paper
 
 // Never Type
 // Nonreturning Method
 // 제어권을 전달하지 않는 다는 것을 명시적으로 표시하기 위해서 Never타입으로 선언
 func nonreturning() -> Never {
 fatalError("강력한 에러 발생")
 }
 
 print("fatalError 발생전")
 //nonreturning()  // error: Execution was interrupted, reason: EXC_BREAKPOINT (code=1, subcode=0x18c985be8).
 print("fatalError 발생후")  // Will never be executed
 
 // fatalError 발생전
 // __lldb_expr_29/Swift.playground:6074: Fatal error: 강력한 에러 발생
 
 
 // 무조건 에러를 던져서 제어권을 catch문에게 넘겨서 처리
 enum SomeError: Error {
 case serverError
 }
 
 func nonreturningThrowing() throws -> Never {
 if true {
 throw SomeError.serverError
 }
 }
 
 do {
 try nonreturningThrowing()
 } catch {
 print("catch문이 제어권을 넘겨받음")
 }
 // catch문이 제어권을 넘겨받음
 
 
 // assert / assertionFailure
 func wrongInput() {
 let input = -1
 assert(input > 0, "조건이 거짓이면 앱종료")
 }
 //wrongInput()  // error: Execution was interrupted, reason: EXC_BREAKPOINT (code=1, subcode=0x18c985be8).
 // __lldb_expr_45/Swift.playground:6107: Assertion failed: 조건이 거짓이면 앱종료
 
 func wrongInput1() {
 let input = -1
 
 if input > 0 {
 // 정상일때 실행
 } else {
 assertionFailure("무조건 앱종료: 항상 거짓인 경우에만 사용")
 }
 }
 //wrongInput1()  // error: Execution was interrupted, reason: EXC_BREAKPOINT (code=1, subcode=0x18c985be8).
 // __lldb_expr_53/Swift.playground:6118: Fatal error: 무조건 앱종료: 항상 거짓인 경우에만 사용
 
 
 // precondition / preconditionFailure
 func updateCheck() {
 let update = false
 precondition(update, "조건이 거짓이면 앱종료")
 }
 //updateCheck()  // error: Execution was interrupted, reason: EXC_BREAKPOINT (code=1, subcode=0x18c985be8).
 // __lldb_expr_61/Swift.playground:6128: Precondition failed: 조건이 거짓이면 앱종료
 
 func updateCheck1() {
 let update = false
 
 if update {
 // 정상 동작
 } else {
 preconditionFailure("무조건 앱 종료")
 }
 }
 //updateCheck1()  // error: Execution was interrupted, reason: EXC_BREAKPOINT (code=1, subcode=0x18c985be8).
 // __lldb_expr_69/Swift.playground:6139: Fatal error: 무조건 앱 종료
 
 // keyPath
 class Shop {
 var shopName: String
 var seller: Seller
 
 init(shopName: String, seller: Seller) {
 self.shopName = shopName
 self.seller = seller
 }
 }
 
 class Seller {
 var information: Information
 init(information: Information) {
 self.information = information
 }
 }
 
 class Information {
 var name: String
 init(name: String) {
 self.name = name
 }
 }
 
 let information1 = Information(name: "점원1")
 let seller1 = Seller(information: information1)
 let shop1 = Shop(shopName: "가게", seller: seller1)
 
 // 경로 지정
 let infoPath = \Shop.seller.information
 
 // 경로 추가
 let namePath = infoPath.appending(path: \.name)
 
 // 속성에 간접적으로 접근
 shop1[keyPath: namePath]  // 점원1
 
 // selector
 class ViewController: UIViewController {
 
 let button = UIButton(type: .custom)
 
 override func viewDidLoad() {
 super.viewDidLoad()
 view.addSubview(button)
 
 // 버튼을 누르면 메모리 주소 90번째를 가리키는 함수를 실행해야돼
 button.addTarget(self, action: #selector(doSomething), for: .touchUpInside)
 }
 
 @objc func doSomething() { print("버튼 눌림") }
 }
 
 // Metatype
 class ClassType {
 static let typeProperty: String = "데이터영역"
 let instanceProperty: String = "힙영역"
 }
 
 let metatype: ClassType.Type
 let typeInstance: ClassType.Type = ClassType.self
 typeInstance.typeProperty
 
 let instance: ClassType = ClassType()
 instance.instanceProperty
 
 
 typealias AnyClass = AnyObject.Type
 
 
 protocol ProtocolType {}
 let metatypeInstance: ProtocolType.Protocol = ProtocolType.self
 
// available 키워드
@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
class 타입 {}

@available(macOS, introduced: 10.0)
let 속성: String

class CustomView {
    @available(iOS, introduced: 10, deprecated: 13, message: "😪")
    func method() {}
    
    @available(iOS, introduced: 10, obsoleted: 13, message: "X")
    func method1() {}
}
CustomView().method() // warning: 'method()' was deprecated in iOS 13: 😪
//CustomView().method1() // error: 'method1()' is unavailable in iOS: X

@available(iOS, deprecated: 11)
func 메서드() {
    guard #available(iOS 13.0, *) else { return }
}
*/
// 클로저: 캡처현상, 캡처리스트
var variable: (() -> Void)?

func function1(nonEscapingClosure: () -> Void) {
    nonEscapingClosure()
}

func function2(escapingClosure: @escaping () -> Void) {
    variable = escapingClosure
}


struct ValueType {
    var x = 0
    
    mutating func structFunction() {
        
        function1(nonEscapingClosure: {
            x = 10
            self.x = 20
        })
        
        function2(escapingClosure: {
//            x = 10
//            self.x = 20
        })
    }
}


class ReferenceType {
    var x = 0
    
    func classFunction() {
        
        function1 {
            x = 10
            self.x = 20
        }
        
        function2 {
//            x = 30
            self.x = 40
        }
        
        function2 { [self] in
            x = 50
            self.x = 60
        }
    }
}

let instance = ReferenceType()
instance.classFunction()
print(instance.x)  // 20
variable?()
print(instance.x)  // 60

// 에러핸들링
// 에러처리 문법 사용하지 않고 nil로도 처리 가능
func divideTwoNum(a: Int, b: Int) -> Int? {
    if b == 0 {
        return nil
    }
    return a / b
}

print(divideTwoNum(a: 10, b: 0))  // nil

// 에러처리 문법
// 1. 에러 정의
enum DivideError: Error {
    case zero
}

// 2. throwing함수 정의: throws / throw
func divideTwoNum1(a: Int, b: Int) throws -> Int {
    if b == 0 {
        throw DivideError.zero
    }
    return a / b
}

// 3. throwing함수 실행
// do-catch / try
do {
    let result = try divideTwoNum1(a: 10, b: 0)
    print(result)
} catch {
    let error = error as! DivideError
    switch error {
    case .zero:
        print("0으로 나눌 수 없습니다.")
    }
}  // 0으로 나눌 수 없습니다.

// try?
let result = try? divideTwoNum1(a: 10, b: 0)
print(result ?? "0으로 나눌 수 없습니다.")  // 0으로 나눌 수 없습니다.

// 에러를 정의(열거형)하지 않고 사용
extension String: Error {}

func divideTwoNum2(a: Int, b: Int) throws -> Int {
    if b == 0 {
        throw "연산 불가"
    }
    return a / b
}

do {
    print(try divideTwoNum2(a: 10, b: 0))
} catch {
    let error = error as! String
    print(error)
}  // 연산 불가

// 함수로 에러 다시 던지기
func rethrowingFunction() throws -> Int {
    return try divideTwoNum1(a: 10, b: 0)
}

do {
    try rethrowingFunction()
} catch {
    let error = error as! DivideError
    switch error {
        case .zero:
        print("0으로 나눌 수 없습니다.")
    }
}  // 0으로 나눌 수 없습니다.

// 함수 내에서 에러처리까지 해서 작업완료
func errorhandling() {
    do {
        let result = try divideTwoNum1(a: 10, b: 0)
        print("몫: ", result)
    } catch {
        let error = error as! DivideError
        switch error {
        case .zero:
            print("연산 불가")
        }
    }
}

errorhandling()  // 연산 불가
