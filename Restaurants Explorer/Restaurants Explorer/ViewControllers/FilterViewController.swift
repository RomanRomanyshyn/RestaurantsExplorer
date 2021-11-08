//
//  FilterViewController.swift
//  Restaurants Explorer
//
//  Created by Роман Романишин on 06.11.2021.
//

import UIKit

final class FilterViewController: UIViewController {
    
    //MARK: - Properties

    @IBOutlet private weak var pickerView: UIPickerView!
    
    weak var delegate: FilterViewControllerDelegate?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.systemBackground
        pickerView.delegate = delegate
        pickerView.dataSource = delegate
        pickerView.reloadAllComponents()
        pickerView.selectRow(delegate?.getCurrentRow() ?? .zero, inComponent: .zero, animated: true)
        
    }
    
    //MARK: - IBActions
    
    @IBAction private func cancelTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func DoneTapped(_ sender: Any) {
        dismiss(animated: true, completion: delegate?.reloadTableView)
    }
}

//MARK: - Protocol Delegate

protocol FilterViewControllerDelegate: UIPickerViewDelegate, UIPickerViewDataSource {
    func reloadTableView()
    func getCurrentRow() -> Int
}
