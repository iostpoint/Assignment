//
//  GarmentListViewController.swift
//  LululemonAssignment
//
//  Created by Vivek  on 09/08/2022.
//

import UIKit

class GarmentListViewController: UIViewController {

    @IBOutlet weak var garmentsTableView: UITableView!
    @IBOutlet weak var sortSegment: UISegmentedControl!
    let viewModel: GarmentViewModel = GarmentViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        setUpNavigation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
    
    @IBAction func changeSortOrder(_ sender: UISegmentedControl) {
        segmentTapped()
    }
    
    @objc func addButtonTapped() {
        let st = UIStoryboard.init(name: "Main", bundle: nil)
        if let addGarmentVC = st.instantiateViewController(withIdentifier: "AddGarmentViewController") as? AddGarmentViewController {
            navigationController?.pushViewController(addGarmentVC, animated: true)
        }
    }
    
    func setUpNavigation() {
        self.title = "Garment List"
        let addBtn = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addBtn
    }
    
    func segmentTapped() {
        var sortType = SortType.name
        switch sortSegment.selectedSegmentIndex {
        case 1:
            sortType = .creationTime
        default:
            break
        }
        viewModel.sortType = sortType
    }
    
    

}

extension GarmentListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let swipeAction = UIContextualAction(style: .destructive, title: "Delete") { action, view, completionHandler in
            self.viewModel.deleteGarment(index: indexPath.row)
        }
        return UISwipeActionsConfiguration(actions: [swipeAction])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.garmentCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GarmentCell") else {
            fatalError()
        }
        let garmentName = viewModel.garmentName(index: indexPath.row)
        cell.textLabel?.text = garmentName
        return cell
    }
}

extension GarmentListViewController: GarmentViewModelDelegate {
    func update() {
        garmentsTableView.reloadData()
    }
}
