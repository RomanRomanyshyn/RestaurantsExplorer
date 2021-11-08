//
//  VenueCell.swift
//  Restaurants Explorer
//
//  Created by Роман Романишин on 05.11.2021.
//

import UIKit

class VenueCell: UITableViewCell {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var categoryLabel: UILabel!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        nameLabel.isHidden = true
        categoryLabel.isHidden = true
        locationLabel.isHidden = true
    }
    
    func setup(venue: Venue, isExpanded: Bool = false, description: String?) {
        setupNameLabel(venue: venue)
        setupCategoryLabel(venue: venue)
        setupLocationLabel(venue: venue)
        bodyLabel.isHidden = !isExpanded
        bodyLabel.text = description
    }
    
    private func setupNameLabel(venue: Venue) {
        guard let name = venue.name else { return }
        nameLabel.text = name
        nameLabel.isHidden = false
    }
    
    private func setupCategoryLabel(venue: Venue) {
        let categories = venue.categories.compactMap({$0.name}).joined(separator: ", ")
        categoryLabel.text = categories
        categoryLabel.isHidden = false
    }
    
    private func setupLocationLabel(venue: Venue) {
        guard let formattedAdress = venue.location.formattedAddress else { return }
        let location = formattedAdress.reversed().joined(separator: ", ")
        locationLabel.text = location
        locationLabel.isHidden = false
    }
}
