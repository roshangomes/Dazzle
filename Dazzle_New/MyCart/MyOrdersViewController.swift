//
//  MyOrdersViewController.swift
//  Dazzle
//
//  Created by Sunny on 18/11/24.
//

import UIKit

class MyOrdersViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
    }
}

extension MyOrdersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myOrders.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myorderTableViewCell", for: indexPath) as! myorderTableViewCell
        let myOrder = myOrders[indexPath.row]
        cell.myImage.image = myOrder.image
        cell.nameLabel.text = myOrder.name
        cell.dateLabel.text = myOrder.date
        cell.moneyLabel.text = myOrder.money
        
        cell.configureStatusAppearance(status: myOrder.status)
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
