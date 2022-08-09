//
//  AddGarmentViewController.swift
//  LululemonAssignment
//
//  Created by Vivek  on 09/08/2022.
//

import UIKit

class AddGarmentViewController: UIViewController {

    @IBOutlet private weak var garmentTextField: UITextField!
    let viewModel = GarmentViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigation()
        garmentTextField.becomeFirstResponder()
    }
    
    func setUpNavigation() {
        self.title = "Add Garment"
        let saveBtn = UIBarButtonItem.init(title: "Save", style: .done, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem = saveBtn
    }
    
    @objc func saveButtonTapped() {
        if let name = garmentTextField.text {
            viewModel.saveGarment(name: name)
        }
        navigationController?.popViewController(animated: true)
    }
    
}
