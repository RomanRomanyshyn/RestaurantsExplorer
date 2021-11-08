//
//  ViewController.swift
//  Restaurants Explorer
//
//  Created by Роман Романишин on 05.11.2021.
//

import UIKit
import CoreLocation

struct Contstants {
    static let nameForCell = "VenueCell"
    static let defaultCategory = "All Categories"
}

final class HomeViewController: UIViewController {
    
    //MARK: - Properties
    
    @IBOutlet private weak var tableView: UITableView!
    
    private let locationManager = CLLocationManager()
    
    private var location = CLLocationCoordinate2D() {
        didSet {
            loadVenues(location: location)
        }
    }
    
    private var allVenues: [Venue] = [] {
        didSet {
            chosenVenues = allVenues
            loadCategories()
            DispatchQueue.main.async { [unowned self] in
                self.tableView.reloadData()
            }
        }
    }
    private var chosenVenues = [Venue]()
    private var expandedVenues = [Venue]()
    private var temporaryInfo: (info: String?, indexPath: IndexPath) = (String(), IndexPath()) {
        didSet {
            DispatchQueue.main.async { [unowned self] in
                self.tableView.reloadRows(at: [self.temporaryInfo.indexPath], with: .automatic)
            }
        }
    }
    
    private var allCategories: [Category] = [Category(name: Contstants.defaultCategory, id: Contstants.defaultCategory)]
    private var chosenCategory: (category: Category, row: Int) = (Category(), .zero) {
        didSet {
            switch chosenCategory.category.name {
            case Contstants.defaultCategory:
                chosenVenues = allVenues
            default:
                chosenVenues = allVenues.filter({ $0.categories.contains(chosenCategory.category)})
            }
        }
    }
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLocationManager()
        setupTableView()
        setupNavigationBar()
    }
    
    //MARK: - Setup LocationManager
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    //MARK: - Setup TableView
    
    private func setupTableView() {
        let nib = UINib(nibName: Contstants.nameForCell, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: Contstants.nameForCell)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
    }
    
    //MARK: - Setup NavigationBar
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterTapped))
    }
    
    @objc private func filterTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let filterViewController = storyboard.instantiateViewController(withIdentifier: "FilterViewController") as? FilterViewController else { return }
        
        if let presentationController = filterViewController.presentationController as? UISheetPresentationController {
            presentationController.detents = [.medium()]
        }
        
        filterViewController.delegate = self
        self.present(filterViewController, animated: true)
    }
    
    private func showError(message: String) {
        DispatchQueue.main.async { [unowned self] in
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

//MARK: - Extensions

extension HomeViewController {
    
    private func loadVenues(location: CLLocationCoordinate2D) {
        let request = VenueRequest()
        
        request.loadVenues(location: location) { [unowned self] result in
            switch result {
            case .success(let venues):
                self.allVenues = venues
            case .failure(let error):
                self.showError(message: error.rawValue)
            }
        }
    }
    
    private func loadCategories() {
        allVenues.forEach { venue in
            venue.categories.forEach { category in
                allCategories.contains(category) ? Void() : allCategories.append(category)
            }
        }
    }
}

//MARK: - TableViewDelegate

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let venue = chosenVenues[indexPath.row]
        if let index = self.expandedVenues.firstIndex(where: { $0.id == venue.id}) {
            self.expandedVenues.remove(at: index)
        } else {
            self.expandedVenues.append(venue)
        }
        let request = VenueRequest()
        
        request.loadVenueDescription(venueId: chosenVenues[indexPath.row].id) { [unowned self] result in
            switch result {
            case .success(let venue):
                if venue.description != nil {
                    self.temporaryInfo = (info: venue.description, indexPath: indexPath)
                } else {
                    guard let id = venue.id else { return }
                    self.temporaryInfo = (info: "There isn't any description, but we have an id!\n\(id)", indexPath: indexPath)
                }
            case .failure(let error):
                self.showError(message: error.rawValue)
            }
        }
    }
}

//MARK: - TableViewDataSource

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Contstants.nameForCell, for: indexPath) as? VenueCell else { return UITableViewCell() }
        let venue = chosenVenues[indexPath.row]
        cell.setup(venue: venue, isExpanded: expandedVenues.contains(where: {$0.id == venue.id}), description: temporaryInfo.info)
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chosenVenues.count
    }
}

//MARK: - CLLocationManagerDelegate

extension HomeViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        self.location = location.coordinate
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        showError(message: error.localizedDescription)
    }
}

//MARK: - PickerViewDelegate

extension HomeViewController: UIPickerViewDelegate {
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//MARK: - PickerViewDataSource

extension HomeViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return allCategories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return allCategories[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        chosenCategory = (category: allCategories[row], row: row)
    }
}

//MARK: - FilterViewControllerDelegate

extension HomeViewController: FilterViewControllerDelegate {
    func reloadTableView() {
        expandedVenues = []
        tableView.reloadData()
    }
    
    func getCurrentRow() -> Int {
        let currentRow = chosenCategory.row
        return currentRow
    }
}
