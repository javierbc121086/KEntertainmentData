//
//  RPEntertainmentDataTests.swift
//  RPEntertainmentDataTests
//
//  Created by Javier Bolaños on 9/8/19.
//  Copyright © 2019 gipsyhub. All rights reserved.
//

import XCTest
@testable import RPEntertainmentData

class RPEntertainmentDataTests: XCTestCase {

    override func setUp() {
        
    }

    override func tearDown() {
        
    }

    func testSaveMovieDataModel() {
        RPEDataManager.shared.createMovie(firstname: "John", lastname:    "Doe", age: 35)
        RPEDataManager.shared.createMovie(firstname: "Liam", lastname: "Croft", age: 27)
        RPEDataManager.shared.createMovie(firstname: "Oliver", lastname: "Twist", age: 15)
        RPEDataManager.shared.createMovie(firstname: "Luke", lastname: "Skywalker", age: 70)
    }
    
    func testgetMovieDataModel() {
        RPEDataManager.shared.fetchMovie()
    }
}
