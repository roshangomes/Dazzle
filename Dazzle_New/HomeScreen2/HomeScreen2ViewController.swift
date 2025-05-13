//
//  HomeScreen2ViewController.swift
//  Dazzle
//
//  Created by Sunny on 16/11/24.
//

import UIKit
import FirebaseFirestore
import SDWebImage

class HomeScreen2ViewController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let viewModel = PostViewModel()
    var posts: [CommunityPost] = []  // Store posts
    
    let viewModel2 = TopPostViewModel()  // ViewModel instance
    
    
    let viewModel3 = TopUserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        //    collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        collectionView.collectionViewLayout = createCompositionalLayout()
        
        fetchPosts()
        fetchTopPosts()
        fetchTopUsers()
    }
    
    func fetchPosts() {
        viewModel.fetchPosts { [weak self] in
            guard let self = self else { return }
            self.posts = self.viewModel.posts  // ✅ Store posts from ViewModel
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()  // ✅ Reload UI
            }
        }
    }
    
    func fetchTopPosts() {
           viewModel2.fetchTopPosts {
               DispatchQueue.main.async {
                   self.collectionView.reloadData()
               }
           }
       }
    
    private func fetchTopUsers() {
            viewModel3.fetchTopUsers { [weak self] in
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            }
        }
    

    
    
    
    
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            if sectionIndex == 0 {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(350))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(350))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 5, bottom: 10, trailing: 5)
                return section
                
                
            }
            else if sectionIndex == 1 {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(45))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(45))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
                return section
            }
            
            else if sectionIndex == 2{
                let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(200), heightDimension: .absolute(250))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(200), heightDimension: .absolute(250))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
                section.interGroupSpacing = 10
                return section
            } else if sectionIndex == 3 {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(45))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(45))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
                return section
            } else if sectionIndex == 4 {
                let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(100), heightDimension: .absolute(167))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(100), heightDimension: .absolute(167))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
                section.interGroupSpacing = 10
                return section
            } else if sectionIndex == 5{
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(45))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(45))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
                return section
            } else {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(120))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(120))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
                section.interGroupSpacing = 10
                return section
            }
        }
        return layout
    }
}
extension HomeScreen2ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return statics.count
        } else if section == 1 {
            return tops.count
        }
        else if section == 2 {
            return viewModel.posts.count
        } else if section == 3 {
            return pops.count
        } else if section == 4 {
            return viewModel3.topUsers.count
        } else if section == 5{
            return leadsB.count
        } else {
            return viewModel2.topThreePosts.count
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StaticCollectionViewCell", for: indexPath) as! StaticCollectionViewCell
            cell.setup(with: statics[indexPath.row])
            return cell
        } else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopLabelCollectionViewCell", for: indexPath) as! TopLabelCollectionViewCell
            cell.setup(with: tops[indexPath.row])
            return cell
        }
        else if indexPath.section == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularCollectionViewCell", for: indexPath) as! PopularCollectionViewCell
            let post = viewModel.posts[indexPath.item]
                    cell.configure(with: post)
                    return cell
            
        } else if indexPath.section == 3{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularLabelCollectionViewCell", for: indexPath) as! PopularLabelCollectionViewCell
            cell.setup(with: pops[indexPath.row])
            return cell
        } else if indexPath.section == 4 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopCollectionViewCell", for: indexPath) as! TopCreatersCollectionViewCell
            let user = viewModel3.topUsers[indexPath.item]
                    cell.setup(with: user)
            return cell
        } else if indexPath.section == 5 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LeaderLabelCollectionViewCell", for: indexPath) as! LeaderLabelCollectionViewCell
            cell.setup(with: leadsB[indexPath.row])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LeaderBoardCollectionViewCell", for: indexPath) as! LeaderBoardCollectionViewCell

                    let post = viewModel2.topThreePosts[indexPath.row]
                    cell.setup(with: post)
                    
                    return cell
        }
    }
    

}
