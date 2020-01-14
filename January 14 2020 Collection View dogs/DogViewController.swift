//
//  ViewController.swift
//  January 14 2020 Collection View dogs
//
//  Created by Margiett Gil on 1/14/20.
//  Copyright © 2020 Margiett Gil. All rights reserved.
//

import UIKit
//MARK: As of iOS 13 collection view cell are self-resizing by default
//MARK: In order to not self-resize we have to set "estimate size" frim automatic to none
class DogViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    private var dogImages = [DogImage]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.backgroundColor = .purple
        fetchDogImage()
        collectionView.delegate = self
    }
    
    private func fetchDogImage() {
        DogAPIClient.fetchDogs{ [weak self] (result) in
            switch result {
            case .failure(let appError):
                print("could not fetch dog image error \(appError)")
            case .success(let dogImages):
                self?.dogImages = dogImages
            }
        }
    }


}

extension DogViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dogCell", for: indexPath) as? DogCell else {
            fatalError("could downcast to Dogcell")
            
        }
        let dogImage = dogImages[indexPath.row]
        
        cell.configureCell(with: dogImage)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dogImages.count
    }
}
extension DogViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // CGSize is a tuple of two values
        //MARK: this needs to be a CGFloat so they can add up together
        let interItemSpacing: CGFloat = 10 //this is the space frim left to right
        let maxWidth = UIScreen.main.bounds.size.width // device's width
        let numberOfItems: CGFloat = 3 // items
        
        
        
        let totalSpacing: CGFloat = numberOfItems * interItemSpacing
        
        
        
        let itemWidth: CGFloat = (maxWidth - totalSpacing) / numberOfItems
        
        
        return CGSize(width: itemWidth, height: itemWidth) // this will make it a square 
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
}
