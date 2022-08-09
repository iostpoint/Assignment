//
//  MockDatabaseManager.swift
//  LululemonAssignmentTests
//
//  Created by Vivek  on 09/08/2022
//

import Foundation
import CoreData
@testable import LululemonAssignment


class MockDatabaseManager: DatabaseManagerDelegate  {
    
    private var garmentList = [Garment]()
    static let shared = MockDatabaseManager()
    private init(){}
    
    func fetchGarments(sort: NSSortDescriptor) -> [Garment] {
        return garmentList
    }
    
    func saveGarment(name: String) {
        let garment = Garment.init(context: DatabaseManager.shared.context)
        garment.name = name
        garment.creationTime = Date()
        garmentList.append(garment)
    }
    
    func deleteGarment(garment: Garment) {
        var index = -1
        for (i,item) in garmentList.enumerated() {
            if item.creationTime == garment.creationTime {
                index = i
            }
        }
        if index != -1 {
            garmentList.remove(at: index)
        }
    }
    
}
