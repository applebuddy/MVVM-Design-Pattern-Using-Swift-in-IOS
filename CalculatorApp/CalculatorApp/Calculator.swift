//
//  Calculator.swift
//  CalculatorApp
//
//  Created by MinKyeongTae on 2022/10/10.
//

import Foundation

// Unit test에 사용할 메서드를 테스트하기 위해서는 Target Membership에 CalculatorAppTests 체크박스를 활성화 시켜 준다.
// 혹은 @testable import 를 활용한다.
class Calculator {
  func add(_ a: Int, _ b: Int) -> Int {
    return a + b
  }
  
  func subtract(_ a: Int, _ b: Int) -> Int {
    return a - b
  }
}
