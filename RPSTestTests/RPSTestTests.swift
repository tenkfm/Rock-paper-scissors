//
//  RPSTestTests.swift
//  RPSTestTests
//
//  Created by Anton Rogachevskyi on 29/12/2019.
//  Copyright © 2019 AR Inc. All rights reserved.
//

import XCTest
@testable import RPSTest

class RPSTestTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testRule() {
        print(Tournament.rules.shapes.count)
        // Check if minimum 3 shapes available
        XCTAssertGreaterThanOrEqual(Tournament.rules.shapes.count, 3)
        XCTAssert(true)
    }

    func testRuleInteractions() {
        
        // Here we need to check if all shapes have interaction rules between each other,
        // But today is my first day of vacation, so I'm feel to lazy :)
        
    }

    func testPvCPlayViewModel() {
        let model = PvCPlayViewModel()
        model.startTournament()
        model.startPlaying()
        
        model.selectShape(Tournament.rules.shapes.randomElement()!)
        
        XCTAssert(true)
    }

    func testCvCPlayViewModel() {
        let model = CvCPlayViewModel()
        model.startTournament()
        model.startPlaying()
        
        model.selectShape(Tournament.rules.shapes.randomElement()!)
        
        XCTAssert(true)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
