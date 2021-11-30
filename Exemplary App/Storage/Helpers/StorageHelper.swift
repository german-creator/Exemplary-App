//
//  StorageHelper.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 21/11/2021.
//

import Foundation
import CoreStore

enum StorageHelper {
    static func setupStorage() {
        CoreStoreDefaults.dataStack = DataStack(xcodeModelName: "Exemplary_App")
        do {
            try CoreStoreDefaults.dataStack.addStorageAndWait(SQLiteStore())
        } catch {
            print(error.localizedDescription)
        }
    }
    
    static func fetchObjects<Object: ImportableUniqueObject>() -> [Object] {
        guard let tasks = try? CoreStoreDefaults.dataStack.fetchAll(From<Object>()) else { return [] }
        return tasks
    }
    
    static func storeObject<Object: ImportableUniqueObject & ObjectRepresentation & Hashable>(
        from dicrionary: [String: Any],
        completion: @escaping (_ result: Result<Object, CommonError>) -> Void)
    where Object.ImportSource == [String: Any] {
        
        CoreStoreDefaults.dataStack.perform(asynchronous: { transaction -> Object in
            if let item = try transaction.importUniqueObject(Into<Object>(), source: dicrionary) {
                return item
            } else {
                throw CommonError.init(type: .parce)
            }
        }, success: { object in
            if let fetchedObject = CoreStoreDefaults.dataStack.fetchExisting(object) {
                completion(.success(fetchedObject))
            } else {
                completion(.failure(CommonError(type: .database)))
            }
        }, failure: { _ in
            completion(.failure(CommonError(type: .parce)))
        })
    }
    
    static func removeObject<Object: ImportableUniqueObject>(type: Object.Type, objectId: Object.UniqueIDType,
                                                             completion: ((Result<Void, CommonError>) -> Void)? = nil) {
        CoreStoreDefaults.dataStack.perform(asynchronous: { transaction -> Void in
            try transaction.deleteAll(From<Object>().where(format: "\(Object.uniqueIDKeyPath) == %@", objectId))
        }, success: { _ in
            completion?(.success(()))
        }, failure: { _ in
            completion?(.failure(CommonError(type: .database)))
        })
    }
}
