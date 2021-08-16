//
//  SavedRoutesViewController.swift
//  NavigationApp
//
//  Created by Maksim Semeniuk on 17.08.2021.
//

import UIKit

class SavedRoutesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        
    }
    
    private func reload() {
        
    }
    
}

extension SavedRoutesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SavedRouteTableViewCell") as! SavedRouteTableViewCell
        cell.setup(with: "\(Date())", time: "\(indexPath.row*10) min.", distance: "\(indexPath.row*100) meters.")
        return cell
    }
    
    
}
