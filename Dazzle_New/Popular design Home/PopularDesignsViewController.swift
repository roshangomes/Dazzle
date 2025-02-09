//
//  ViewController.swift
//  Dazzle
//
//  Created by Steve on 02/11/24.
//

import UIKit

class PopularDesignsViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate {
    var datamodel: Datamodel! = Datamodel()
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        Datamodel.sampleDesigns.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DesignCell", for: indexPath)
        
        if let designCell = cell as? PopularDesignCollectionViewCell {
            let design = Datamodel.sampleDesigns[indexPath.row]
            designCell.designImageView.image = UIImage(named: design.imageName)
            designCell.titleLabel.text = design.title
            designCell.creatorLabel.text = design.creatorUsername
            //designCell.priceLabel.text = "₹ \(design.price)"
            
            // Configure label properties for better fit
            designCell.titleLabel.numberOfLines = 2
            designCell.titleLabel.lineBreakMode = .byWordWrapping
            designCell.titleLabel.adjustsFontSizeToFitWidth = true
            designCell.titleLabel.minimumScaleFactor = 0.5
        }
        
        // Additional styling for the cell
        cell.layer.cornerRadius = 10
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.2
        cell.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.layer.shadowRadius = 4
        cell.layer.masksToBounds = false
        
        return cell
    }

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    func generateLayout() -> UICollectionViewLayout {
        // Define the item size and layout
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(270))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Set spacing between items in the same row
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        // Define the group to hold two items side by side (one row)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(250))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // Define the section with the group, allowing for scrolling and spacing between rows
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        // Return the compositional layout
        return UICollectionViewCompositionalLayout(section: section)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // Set up the collection view layout (if needed)
        collectionView.setCollectionViewLayout(generateLayout(), animated: true)
    }}
