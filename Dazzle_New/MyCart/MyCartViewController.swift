//
//  MyCartViewController.swift
//  Dazzle
//
//  Created by Sunny on 17/11/24.
//

import UIKit

class MyCartViewController: UIViewController {
    
    @IBOutlet weak var mycartLabel: UILabel!
    
    
    @IBOutlet weak var myorderbutton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var backview: UIView!
    
    
    @IBOutlet weak var subtoLabel: UILabel!
    
    @IBOutlet weak var rsLabel: UILabel!
    
    @IBOutlet weak var checkOutButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
    }
}

extension MyCartViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartTableViewCell", for: indexPath) as! cartTableViewCell
        let cartItem = cartItems[indexPath.row]
        cell.CartImage.image = cartItem.image
        cell.NameLabel.text = cartItem.name
        cell.colorLabel.text = cartItem.color
        cell.typeLabel.text = cartItem.type
        cell.sizeLabel.text = cartItem.size
        cell.rankLabel.text = cartItem.rank
        cell.moneyLabel.text = cartItem.money
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        250
    }
}
