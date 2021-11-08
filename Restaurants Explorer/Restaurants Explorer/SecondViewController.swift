//
//  SecondViewController.swift
//  Restaurants Explorer
//
//  Created by Роман Романишин on 06.11.2021.
//

import UIKit

class SecondViewController: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet var tx: UITextField!

    let animals = ["lion", "Dog","JUDO"]
    var pickerview = UIPickerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib

        pickerview.delegate = self
        pickerview.dataSource = self
        tx.inputView = pickerview
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height, width: view.bounds.width, height: 44))

        var items = [UIBarButtonItem]()


        items.append( UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction)) )
        toolbar.items = items
        tx.inputAccessoryView = toolbar
        
        let label = UILabel()
        label.text = "filter"
        tx.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: tx.safeAreaLayoutGuide.topAnchor),
            label.bottomAnchor.constraint(equalTo: tx.safeAreaLayoutGuide.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: tx.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: tx.trailingAnchor)
        ])
    }
    @objc func doneAction(){

        tx.resignFirstResponder()
        view.endEditing(true)

    }
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return animals.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return  animals[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        tx.text = animals[row]

    }
}
