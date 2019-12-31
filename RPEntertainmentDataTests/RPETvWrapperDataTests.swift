//
//  RPEntertainmentDataTests
//
//  Created by Javier Bolaños on 12/30/19.
//  Copyright © 2019 Javier Bolaños. All rights reserved.
//

import XCTest
import CoreData
import KEntertainmentDomain
@testable import RPEntertainmentData

class RPETvWrapperDataTests: XCTestCase {
    var modelWrapper: RPETvWrapper?

    override func setUp() {
        self.modelWrapper = RPETvWrapper()
    }

    override func tearDown() {
        self.modelWrapper = nil
    }

    func testSaveMovieDataModel() {
        for index in 1...1000 {
            let tvModel = KTvModel(
                    id: index,
                    originalName: "originalName", 
                    genreIds: [444, 555, 666, 777],
                    name: "name", 
                    popularity: 0.0,
                    originCountry: ["USA", "Japan", "Mexico"], 
                    voteCount: index,
                    firstAirDate: "firstAirDate", 
                    backdropPath: "backdropPath", 
                    originalLanguage: "originalLanguage", 
                    voteAverage: 0.0,
                    overview: "overview", 
                    posterPath: "posterPath")

            self.modelWrapper?.save(model: tvModel)
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
