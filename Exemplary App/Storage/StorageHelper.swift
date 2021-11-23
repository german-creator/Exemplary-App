//
//  StorageHelper.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 21/11/2021.
//

import Foundation
import CoreStore
import SwiftyJSON

enum StorageHelper {
    static func setupStorage() {
        CoreStoreDefaults.dataStack = DataStack(xcodeModelName: "Exemplary_App")
        do {
            try CoreStoreDefaults.dataStack.addStorageAndWait(
                SQLiteStore(
                    fileName: "exemplary.sqlite",
                    localStorageOptions: .allowSynchronousLightweightMigration
                )
            )
        } catch {
            print(error.localizedDescription)
        }
    }
    
    static func fetchObjects<Object: ImportableUniqueObject>() -> [Object] {
        guard let tasks = try? CoreStoreDefaults.dataStack.fetchAll(From<Object>()) else { return [] }
        return tasks
    }
    
    static func storeObject<Object: ImportableUniqueObject & ObjectRepresentation & Hashable>(
        from json: JSON,
        completion: @escaping (_ result: Result<Object, ApiError>) -> Void)
    where Object.ImportSource == JSON {

        CoreStoreDefaults.dataStack.perform(asynchronous: { transaction -> Object in
            if let item = try transaction.importUniqueObject(Into<Object>(), source: json) {
                return item
            } else {
                throw ApiError.init(type: .test)
            }
        }, success: { object in
            if let fetchedObject = CoreStoreDefaults.dataStack.fetchExisting(object) {
                completion(.success(fetchedObject))
            } else {
                completion(.failure(ApiError(type: .test)))
            }
        }, failure: { _ in
            completion(.failure(ApiError(type: .test)))
        })
    }
    
    static func removeObject<Object: ImportableUniqueObject>(type: Object.Type, id: Object.UniqueIDType,
                                                             completion: ((Result<Void, ApiError>) -> Void)? = nil) {
        CoreStoreDefaults.dataStack.perform(asynchronous: { transaction -> Void in
            try transaction.deleteAll(From<Object>().where(format: "\(Object.uniqueIDKeyPath) == %@", id))
        }, success: { _ in
            completion?(.success(()))
        }, failure: { _ in
            completion?(.failure(ApiError(type: .test)))
        })
    }
    
}
