//
//  DatabaseManager.swift
//  LululemonAssignment
//
//  Created by Munro Azumi on 10/16/21.
//

import Foundation
import CoreData
import UIKit

protocol DatabaseManagerDelegate {
    func fetchGarments(sort: NSSortDescriptor) -> [Garment]
    func saveGarment(name: String)
    func deleteGarment(garment: Garment)
}

class DatabaseManager: DatabaseManagerDelegate  {
    
    static let shared = DatabaseManager()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private init(){}
    
    func fetchGarments(sort: NSSortDescriptor) -> [Garment] {
        var garments = [Garment]()
        do {
            let fetchRequest = NSFetchRequest<Garment>.init(entityName: "Garment")
            fetchRequest.sortDescriptors = [sort]
            garments = try self.context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Garments didn't pull thru because \(error)")
        }
        return garments
    }
    
    func saveGarment(name: String) {
        let garment = Garment.init(context: self.context)
        garment.name = name
        garment.creationTime = Date()
        do {
            try self.context.save()
        } catch let error as NSError {
            print("Couldn't save garment because \(error)")
        }
    }
    
    func deleteGarment(garment: Garment) {
        self.context.delete(garment)
        do {
            try self.context.save()
        } catch let error as NSError {
            print("Couldn't delete garment because \(error)")
        }
    }
    
}
