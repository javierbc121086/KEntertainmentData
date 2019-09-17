//
// Created by Javier Bolaños on 9/12/19.
// Copyright (c) 2019 gipsyhub. All rights reserved.
//

import RPEntertainmentDomain
import CoreData

public class RPETvWrapper: IRPEDataManagerDelegate {
    public typealias T = RPETvModel

    private var entityCoraDataName: String {
        return "RPECDTvEntity"
    }

    public func get(id: Int) -> RPETvModel? {
        if let context = RPEDataManager.Shared.persistentContainer?.viewContext {
            let fetchRequest = NSFetchRequest<RPECDTvEntity>(entityName: self.entityCoraDataName)
            fetchRequest.predicate = NSPredicate(format: "id = %d", id)
            
            do {
                if let coreDataTvEntity = try context.fetch(fetchRequest).first {
                    let model = RPETvModel(
                        id: Int(coreDataTvEntity.id),
                        originalName: coreDataTvEntity.originalName ?? "",
                        genreIds: (coreDataTvEntity.genreIds as? NSSet)?.allObjects as? [Int] ?? [],
                        name: coreDataTvEntity.name ?? "",
                        popularity: coreDataTvEntity.popularity,
                        originCountry: (coreDataTvEntity.originCountry as? NSSet)?.allObjects as? [String] ?? [],
                        voteCount: Int(coreDataTvEntity.voteCount),
                        firstAirDate: coreDataTvEntity.firstAirDate ?? "",
                        backdropPath: coreDataTvEntity.backdropPath ?? "",
                        originalLanguage: coreDataTvEntity.originalLanguage ?? "",
                        voteAverage: coreDataTvEntity.voteAverage,
                        overview: coreDataTvEntity.overview ?? "",
                        posterPath: coreDataTvEntity.posterPath ?? "")
                    
                    return model
                }
            }
            catch let fetchErr {
                print("Failed to update \(entityCoraDataName): \n \(fetchErr.localizedDescription)")
            }
        }

        return nil
    }

    public func getAll() -> [RPETvModel]? {
        var list = [RPETvModel]()

        if let context = RPEDataManager.Shared.persistentContainer?.viewContext {
            let fetchRequest = NSFetchRequest<RPECDTvEntity>(entityName: self.entityCoraDataName)
            
            do {
                let coreDataTvEntity = try context.fetch(fetchRequest)
                
                for tvEntity in coreDataTvEntity {
                    let model = RPETvModel(
                        id: Int(tvEntity.id),
                        originalName: tvEntity.originalName ?? "",
                        genreIds: (tvEntity.genreIds as? NSSet)?.allObjects as? [Int] ?? [],
                        name: tvEntity.name ?? "",
                        popularity: tvEntity.popularity,
                        originCountry: (tvEntity.originCountry as? NSSet)?.allObjects as? [String] ?? [],
                        voteCount: Int(tvEntity.voteCount),
                        firstAirDate: tvEntity.firstAirDate ?? "",
                        backdropPath: tvEntity.backdropPath ?? "",
                        originalLanguage: tvEntity.originalLanguage ?? "",
                        voteAverage: tvEntity.voteAverage,
                        overview: tvEntity.overview ?? "",
                        posterPath: tvEntity.posterPath ?? ""
                    )
                    
                    list.append(model)
                }
            }
            catch let fetchErr {
                print("Failed to fetch \(entityCoraDataName): \n \(fetchErr.localizedDescription)")
            }
        }

        return list
    }

    public func save(model: RPETvModel) {
        let isModified = self.update(model: model)

        if !isModified {
            if let context = RPEDataManager.Shared.persistentContainer?.viewContext {
                if let coreDataTvEntity = NSEntityDescription.insertNewObject(
                        forEntityName: self.entityCoraDataName,
                        into: context
                    ) as? RPECDTvEntity {
                    
                    coreDataTvEntity.id                 = Int32(model.id)
                    coreDataTvEntity.originalName       = model.originalName
                    coreDataTvEntity.genreIds           = NSSet(array: model.genreIds)
                    coreDataTvEntity.name               = model.name
                    coreDataTvEntity.popularity         = model.popularity
                    coreDataTvEntity.originCountry      = NSSet(array: model.originCountry)
                    coreDataTvEntity.voteCount          = Int32(model.voteCount)
                    coreDataTvEntity.firstAirDate       = model.firstAirDate
                    coreDataTvEntity.backdropPath       = model.backdropPath
                    coreDataTvEntity.originalLanguage   = model.originalLanguage
                    coreDataTvEntity.voteAverage        = model.voteAverage
                    coreDataTvEntity.overview           = model.overview
                    coreDataTvEntity.posterPath         = model.posterPath
                    
                    do {
                        try context.save()
                        print("\(entityCoraDataName) saved successfully")
                    }
                    catch let error {
                        print("Failed to create \(entityCoraDataName): \n \(error.localizedDescription)")
                    }
                }
            }
        }
    }

    public func saveAll(list: [RPETvModel]) {
        list.forEach { (model) in
            self.save(model: model)
        }
    }

    public func update(model: RPETvModel) -> Bool {
        var isModifiedModel = false

        if let context = RPEDataManager.Shared.persistentContainer?.viewContext {
            let fetchRequest = NSFetchRequest<RPECDTvEntity>(entityName: self.entityCoraDataName)
            fetchRequest.predicate = NSPredicate(format: "id = %d", model.id)
            
            do {
                if let coreDataTvEntity = try context.fetch(fetchRequest).first {
                    coreDataTvEntity.setValue(Int32(model.id), forKey: "id")
                    coreDataTvEntity.setValue(model.originalName, forKey: "originalName")
                    coreDataTvEntity.setValue(NSSet(array: model.genreIds), forKey: "genreIds")
                    coreDataTvEntity.setValue(model.name, forKey: "name")
                    coreDataTvEntity.setValue(model.popularity, forKey: "popularity")
                    coreDataTvEntity.setValue(NSSet(array: model.originCountry), forKey: "originCountry")
                    coreDataTvEntity.setValue(model.voteCount, forKey: "voteCount")
                    coreDataTvEntity.setValue(model.firstAirDate, forKey: "firstAirDate")
                    coreDataTvEntity.setValue(model.backdropPath, forKey: "backdropPath")
                    coreDataTvEntity.setValue(model.originalLanguage, forKey: "originalLanguage")
                    coreDataTvEntity.setValue(model.voteAverage, forKey: "voteAverage")
                    coreDataTvEntity.setValue(model.overview, forKey: "overview")
                    coreDataTvEntity.setValue(model.posterPath, forKey: "posterPath")
                    
                    try context.save()
                    
                    print("\(entityCoraDataName) update successfully")
                    isModifiedModel = true
                }
            }
            catch let fetchErr {
                print("Failed to update \(entityCoraDataName): \n \(fetchErr.localizedDescription)")
            }
        }

        return isModifiedModel
    }

    public func delete(id: Int) {
        if let context = RPEDataManager.Shared.persistentContainer?.viewContext {
            let fetchRequest = NSFetchRequest<RPECDTvEntity>(entityName: self.entityCoraDataName)
            fetchRequest.predicate = NSPredicate(format: "id = %d", id)
            
            do {
                if let coreDataTvEntity = try context.fetch(fetchRequest).first {
                    context.delete(coreDataTvEntity)
                    try context.save()
                }
            }
            catch let fetchErr {
                print("Failed to update \(entityCoraDataName): \n \(fetchErr.localizedDescription)")
            }
        }
    }

    public func deleteAll() {
        if let context = RPEDataManager.Shared.persistentContainer?.viewContext {
            let fetchRequest = NSFetchRequest<RPECDTvEntity>(entityName: self.entityCoraDataName)
            
            do {
                let coreDataTvEntity = try context.fetch(fetchRequest)
                
                coreDataTvEntity.forEach { (entity) in
                    context.delete(entity)
                }
                
                try context.save()
            }
            catch let fetchErr {
                print("Failed to fetch \(entityCoraDataName): \n \(fetchErr.localizedDescription)")
            }
        }
    }
}
