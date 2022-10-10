//
//  CalculatorAppTests.swift
//  CalculatorAppTests
//
//  Created by MinKyeongTae on 2022/10/10.
//

// MARK: 74. Settinig Up Your Project
// Tests 파일에서 테스트코드를 작성하여 Unit Test를 할 수 있다.
// MARK: 75. Writing Your  First Unit Test
// "test_" 를 테스트 함수 앞에 붙히면 테스트 가능 버튼이 좌측에 나타난다.
import XCTest

class CalculatorAppTests: XCTestCase {
  
  func test_AddTwoNumbers() {
    let calculator = Calculator()
    let result = calculator.add(2, 3)
    // XCTAssetEqual을 사용하여 결과값과 예상값이 같은지 확인, 다르면 에러가 발생한다.
    XCTAssertEqual(result, 5)
  }
  
  func test_SubtractNumbers() {
    let calculator = Calculator()
    let result = calculator.subtract(3, 1)
    // test가 실패할 경우 경고문구가 나온다.
    // ex) XCTAssertEqual failed: ("2") is not equal to ("-1")
    XCTAssertEqual(result, 2)
  }
}
