//
//  DataPersistenceManager.swift
//  Netflix Clone
//
//  Created by Jonathan Andryana on 09/01/23.
//

import Foundation
import CoreData
import UIKit

class DataPersistenceManager {
    
    enum DatabaseError: Error {
        case failedToSaveData
        case failedToFetchData
        case failedToDeleteData
    }
    
    static let shared = DataPersistenceManager()
    
    func saveUserWith(model: User, completion: @escaping (Result<Void, Error>) -> Void ) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let user = UserProfile(context: context)
        
        user.id = Int64(model.id)
        user.username = model.username
        user.email = model.email
        user.role = model.role
        user.password = model.password
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(DatabaseError.failedToSaveData))
        }
            
        
    }
//
    func fetchingUsersFromDatabase(completion: @escaping (Result<[UserProfile], Error>)-> Void) {

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }

        let context = appDelegate.persistentContainer.viewContext

        let request: NSFetchRequest<UserProfile>

        request = UserProfile.fetchRequest()

        do {

            let users = try context.fetch(request)
            completion(.success(users))

        } catch {
            completion(.failure(DatabaseError.failedToFetchData))
        }
    }


    func deleteUserWith(model: UserProfile, completion: @escaping (Result<Void, Error>)-> Void) {

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }

        let context = appDelegate.persistentContainer.viewContext

        context.delete(model)

        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(DatabaseError.failedToDeleteData))
        }

    }
    
}
