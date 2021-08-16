//
//  SavedRouteTableViewCell.swift
//  NavigationApp
//
//  Created by Maksim Semeniuk on 17.08.2021.
//

import UIKit

class SavedRouteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    func setup(with date: String, time: String, distance: String) {
        dateLabel.text = date
        timeLabel.text = time
        distanceLabel.text = distance
    }
}
