//
//  LululemonAssignmentTests.swift
//  LululemonAssignmentTests
//
//  Created by Vivek  on 09/08/2022.
//

import XCTest
@testable import LululemonAssignment

class LululemonAssignmentTests: XCTestCase {
    
    var viewModel: GarmentViewModel?

    override func setUpWithError() throws {
        viewModel = GarmentViewModel(manager: MockDatabaseManager.shared)
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testSaveGarment() throws {
        viewModel?.saveGarment(name: "Zara cloth")
        viewModel?.fetchGarments()
        let lastIndex = viewModel?.garmentCount ?? 0
        let garmentName = viewModel?.garmentName(index: lastIndex - 1)
        XCTAssertEqual(garmentName, "Zara cloth")
    }

    func testDeleteGarment() throws {
        viewModel?.saveGarment(name: "Zara cloth")
        viewModel?.fetchGarments()
        let arrayCountBeforeDelete = viewModel?.garmentCount ?? 0
        viewModel?.deleteGarment(index: arrayCountBeforeDelete - 1)
        viewModel?.fetchGarments()
        let arrayCount = viewModel?.garmentCount
        XCTAssertEqual(arrayCount, arrayCountBeforeDelete - 1)
    }
    
    func testFetchGarment() throws {
        viewModel?.saveGarment(name: "Zara cloth")
        viewModel?.saveGarment(name: "H&M cloth")
        viewModel?.fetchGarments()
        let arrayCount = viewModel?.garmentCount
        XCTAssertEqual(arrayCount, 2)
    }

}
