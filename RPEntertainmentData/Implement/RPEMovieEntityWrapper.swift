//
//  RPEMovieEntityWrapper.swift
//  RPEntertainmentData
//
//  Created by Javier Bolaños on 9/11/19.
//  Copyright © 2019 gipsyhub. All rights reserved.
//

import RPEntertainmentDomain
import CoreData

class RPEMovieWrapperBridge: CustomStringConvertible, IRPEDataManagerDelegate {
    typealias T = RPEMovieModel
    
    private var entityCoraDataName: String {
        return "RPECDMovieEntity"
    }
    
    func get(id: Int) -> RPEMovieModel? {
        return nil
    }
    
    func save(model: RPEMovieModel) {
        if #available(iOS 10.0, *) {
            if let context = RPEDataManager.Shared.persistentContainer?.viewContext {
                if let movieCoreDataEntity = NSEntityDescription.insertNewObject(
                    forEntityName: self.entityCoraDataName,
                    into: context
                    ) as? RPECDMovieEntity {
                    
                    movieCoreDataEntity.id                  = Int32(model.id)
                    movieCoreDataEntity.popularity          = model.popularity
                    movieCoreDataEntity.voteCount           = Int32(model.voteCount)
                    movieCoreDataEntity.video               = model.video
                    movieCoreDataEntity.adult               = model.adult
                    movieCoreDataEntity.originalLanguage    = model.originalLanguage
                    movieCoreDataEntity.originalTitle       = model.originalTitle
                    movieCoreDataEntity.title               = model.title
                    movieCoreDataEntity.voteAverage         = model.voteAverage
                    movieCoreDataEntity.overview            = model.overview
                    movieCoreDataEntity.releaseDate         = model.releaseDate
                    
                    movieCoreDataEntity.backdropPath = model.backdropPath ?? ""
                    movieCoreDataEntity.posterPath = model.posterPath ?? ""
                    
                    do {
                        try context.save()
                        print("RPECDMovieEntity saved succesfuly")
                    }
                    catch let error {
                        print("Failed to create RPECDMovieEntity: \(error.localizedDescription)")
                    }
                }
            }
        }
        else {
            // Fallback on earlier versions
        }
    }
    
    func update(model: RPEMovieModel) {
        
    }
    
    func delete(id: Int) {
        
    }
    
    func getAll() -> [RPEMovieModel]? {
        var list = [RPEMovieModel]()
        
        if #available(iOS 10.0, *) {
            if let context = RPEDataManager.Shared.persistentContainer?.viewContext {
                let fetchRequest = NSFetchRequest<RPECDMovieEntity>(entityName: self.entityCoraDataName)
                
                do {
                    let movieCoreDataEntity = try context.fetch(fetchRequest)
                    
                    for movie in movieCoreDataEntity {
                        let entity = RPEMovieModel(
                            id: Int(movie.id),
                            popularity: movie.popularity,
                            voteCount:  Int(movie.voteCount),
                            video:  movie.video,
                            adult:  movie.adult,
                            originalLanguage:  movie.originalLanguage ?? "",
                            originalTitle:  movie.originalTitle ?? "",
                            genreIds: [],
                            title: movie.title ?? "",
                            voteAverage:  movie.voteAverage,
                            overview:  movie.overview ?? "",
                            releaseDate:  movie.releaseDate ?? "",
                            backdropPath:  movie.backdropPath,
                            posterPath:  movie.posterPath
                        )
                        
                        list.append(entity)
                    }
                }
                catch let fetchErr {
                    print("Failed to fetch RPEMovieEntity:", fetchErr)
                }
            }
        }
        else {
            // Fallback on earlier versions
        }
        
        return list
    }
    
    public var description: String {
        return "RPEMovieEntityWrapper"
    }
}
