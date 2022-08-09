//
//  GarmentViewModel.swift
//  LululemonAssignment
//
//  Created by Vivek  on 09/08/2022.
//

import Foundation

enum SortType: String {
    case name = "name"
    case creationTime = "creationTime"
}

protocol GarmentViewModelDelegate: AnyObject {
    func update()
}

class GarmentViewModel {
    
    private var garments = [Garment]()
    var manager: DatabaseManagerDelegate
    
    var sortType: SortType = .name {
        didSet {
            fetchGarments()
        }
    }
    
    weak var delegate: GarmentViewModelDelegate?
    
    init(manager: DatabaseManagerDelegate = DatabaseManager.shared) {
        self.manager = manager
    }
    
    func viewWillAppear() {
        fetchGarments()
        delegate?.update()
    }
    
    func fetchGarments() {
        let sort = NSSortDescriptor(key: sortType.rawValue, ascending: true)
        garments = manager.fetchGarments(sort: sort)
        delegate?.update()
    }
    
    var garmentCount: Int {
        return garments.count
    }
    
    func garmentName(index: Int) -> String {
        return garments[index].name ?? ""
    }
    
    func garmentCreationTime(index: Int) -> Date {
        return garments[index].creationTime ?? Date()
    }
    
    func deleteGarment(index: Int) {
        manager.deleteGarment(garment: garments[index])
        fetchGarments()
        delegate?.update()
    }
    
    func saveGarment(name: String) {
        manager.saveGarment(name: name)
        fetchGarments()
        delegate?.update()
    }
}
