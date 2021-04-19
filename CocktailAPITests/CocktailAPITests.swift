//
//  CocktailAPITests.swift
//  CocktailAPITests
//
//  Created by Hyeontae on 2021/04/15.
//

import XCTest
import Moya
@testable import CocktailMaster

class CocktailAPITests: XCTestCase {
    
    let cocktailProvider = CocktailProvider(plugins: [NetworkLoggerPlugin()])

    // TODO: Mock Data
    func testList() {
        let expectation = XCTestExpectation()
        cocktailProvider.cocktailList("a")
            .do(onDispose: {
                expectation.fulfill()
            })
            .subscribe { list in
                print("good")
//                print(list)
            } onError: { err in
                print("error testList")
                XCTFail()
                print(err)
            }
            
        wait(for: [expectation], timeout: .init(3))
    }
    
    func testDetail() {
        let expectation = XCTestExpectation()
        
        cocktailProvider.cocktailDetail("11007")
            .do(onDispose: {
                expectation.fulfill()
            })
            .subscribe { detail in
                print("good")
                print(detail)
            } onError: { err in
                print("error testDetail")
                XCTFail()
                print(err)
            }
            
        wait(for: [expectation], timeout: .init(3))
    }
}
