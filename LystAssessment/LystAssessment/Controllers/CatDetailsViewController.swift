//
//  CatDetailsViewController.swift
//  LystAssessment
//
//  Created by Vishwanath Kota on 30/09/21.
//
// It is used to display all the details of the selected cat

import UIKit

class CatDetailsViewController: UIViewController {

    /// Outlet of UI elements
    @IBOutlet weak var catImageView: UIImageView!
    @IBOutlet weak var temperamentLabel: UILabel!
    @IBOutlet weak var energyLevelLabel: UILabel!
    @IBOutlet weak var wikiURLButton: UIButton!
    
    /// Capturing the cats information
    var catsBreed : Breed?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    /// Updating the UI elements with the actual data and if no data is present I am setting it to default values
    func updateUI() {
        temperamentLabel.text = catsBreed?.temperament ?? "None"
        let url = URL(string: catsBreed?.image?.url ?? "")
        let data = try? Data(contentsOf: url!) 
        catImageView.image = UIImage(data: data!)
        energyLevelLabel.text = "\(catsBreed?.energy_level ?? 0)"
        wikiURLButton.setTitle(catsBreed?.wikipedia_url ?? "Url Not found", for: .normal)
    }
    
    /// When clicked on this button, I am navigating it to safari and open the given URL
    @IBAction func wikiURLButtonAction(_ sender: Any) {
        if let url = URL(string: (catsBreed?.wikipedia_url)!) {
            UIApplication.shared.open(url)
        }
    }
}
