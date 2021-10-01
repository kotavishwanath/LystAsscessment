//
//  ViewController.swift
//  LystAssessment
//
//  Created by Vishwanath Kota on 30/09/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var catsCollectionView: UICollectionView!
    var catsParser: Parser?
    
    private let cache = NSCache<NSNumber, UIImage>()
    private let utilityQueue = DispatchQueue.global(qos: .utility)
    
    override func loadView() {
        super.loadView()
        catsParser = Parser()
        catsParser?.vc = self
        catsParser?.getRowsInfoFromAPI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        catsCollectionView.dataSource = self
        catsCollectionView.delegate = self
        catsCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
    }

    // MARK: - Image Loading
    /**
     This function converts the image URL to  an image in the completion handler, and return it on the main thread
     - Parameter imageUrlString: This the URL which we get it from API
     - Returns: An image after converting the URL to image `imageUrlString`.
     */
    private func loadImage(imageUrlString: String, completion: @escaping (UIImage?) -> ()) {
        utilityQueue.async {
            guard let url = URL(string: imageUrlString) else {
                return
            }
            guard let data = try? Data(contentsOf: url) else { return }
            let image = UIImage(data: data)
            
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return catsParser?.catsBreed.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CatCell", for: indexPath) as! CatViewCell
        
        let catBreed = (catsParser?.catsBreed[indexPath.row])!
        
        cell.catBreedLabel.text = catBreed.name
        
        let itemNumber = NSNumber(value: indexPath.item)
        if let cachedImage = self.cache.object(forKey: itemNumber) {
            print("cached image of an item: \(itemNumber)")
            cell.catImageView.image = cachedImage
        } else {
            self.loadImage(imageUrlString: catBreed.image?.url ?? "") { [weak self] (image) in
                guard let self = self, let image = image else { return }
                
                cell.catImageView.image = image

                self.cache.setObject(image, forKey: itemNumber)
            }
        }
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 300)
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let catDetailsVC = self.storyboard?.instantiateViewController(identifier: "CatDetailsViewController") as! CatDetailsViewController
        
        let catBreed = (catsParser?.catsBreed[indexPath.row])!
        catDetailsVC.catsBreed = catBreed
        
        self.navigationController?.pushViewController(catDetailsVC, animated: true)
    }
}
