//
//  singletonClassTests.swift
//  singletonClassTests
//
//  Created by Luis Andres Castillo Hernandez on 11/17/15.
//  Copyright © 2015 devbros. All rights reserved.
//

import XCTest
@testable import singletonClass

class singletonClassTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
//    // Helpers
//    func createUniqueInstance() -> Singleton {
//        return Singleton();
//    }
//    
//    func getSharedInstance() -> Singleton {
//        return Singleton.sharedInstance()
//    }
//    
//    // Tests
//    func testSingletonSharedInstanceCreated() {
//        XCTAssertNotNil(getSharedInstance())
//    }
//    
//    func testSingletonUniqueInstanceCreated() {
//        XCTAssertNotNil(createUniqueInstance())
//    }
//    
//    func testSingletonReturnsSameSharedInstances() {
//        var s1 = getSharedInstance()
//        var s2 = getSharedInstance()
//        XCTAssertEqualObjects(s1, s2)
//    }
//    
//    func testSingletonSharedInstanceSameAsUniqueInstance() {
//        var s1 = getSharedInstance()
//        var s2 = createUniqueInstance()
//        XCTAssertNotEqualObjects(s1, s2)
//    }
//    
//    func testSingletonReturnsSameUniqueInstances() {
//        var s1 = createUniqueInstance()
//        var s2 = createUniqueInstance()
//        XCTAssertNotEqualObjects(s1, s2)
//    }
//    
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
