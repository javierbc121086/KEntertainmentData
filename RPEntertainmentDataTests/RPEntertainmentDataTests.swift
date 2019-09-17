//
//  RPEntertainmentDataTests.swift
//  RPEntertainmentDataTests
//
//  Created by Javier Bolaños on 9/8/19.
//  Copyright © 2019 gipsyhub. All rights reserved.
//

import XCTest
import CoreData
import RPEntertainmentDomain
@testable import RPEntertainmentData

class RPEntertainmentDataTests: XCTestCase {
    
    var modelWrapper: RPEMovieWrapper?

    override func setUp() {
        self.modelWrapper = RPEMovieWrapper()
    }

    override func tearDown() {
        self.modelWrapper = nil
    }

    func testSaveMovieDataModel() {
        for index in 1...1000 {
            let movieModel = RPEMovieModel(
                id: index,
                popularity: Double(index),
                voteCount: index,
                video: false,
                adult: false,
                originalLanguage: "originalLanguage \(index)",
                originalTitle: "originalTitle \(index)",
                genreIds: [100, 200, 300],
                title: "title \(index)",
                voteAverage: Double(index),
                overview: "overview \(index)",
                releaseDate: "releaseDate \(index)",
                backdropPath: "backdropPath \(index)",
                posterPath: "posterPath \(index)"
            )
            
            self.modelWrapper?.save(model: movieModel)
        }
    }
    
    func testGetAllDataMoviesModel() {
        self.modelWrapper?.getAll()?.forEach({ (movieModel) in
            print(movieModel)
        })
    }
    
    func testDeleteAllMoviesSuccess() {
        self.modelWrapper?.deleteAll()
    }
}
