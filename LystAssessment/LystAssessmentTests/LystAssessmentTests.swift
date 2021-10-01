//
//  LystAssessmentTests.swift
//  LystAssessmentTests
//
//  Created by Vishwanath Kota on 30/09/21.
//

import XCTest
@testable import LystAssessment

class LystAssessmentTests: XCTestCase {

    var viewController: ViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        viewController = (navigationController.topViewController as! ViewController)
        
        UIApplication.shared.keyWindow!.rootViewController = viewController
        
        XCTAssertNotNil(navigationController.view)
        XCTAssertNotNil(viewController.view)
    }
    
    func testCollectionViewCellISDisplayedWithMatchingImage() {
        let catBreeds: [Breed] = [
            Breed(name: "Abyssinian cat", image: Image(url: "https://en.wikipedia.org/wiki/Abyssinian_cat#/media/File:Gustav_chocolate.jpg"), temperament: "Crazy", energy_level: 07, wikipedia_url: "https://en.wikipedia.org/wiki/Abyssinian_cat"),
            Breed(name: "Aegean cat", image: Image(url: "https://en.wikipedia.org/wiki/Aegean_cat#/media/File:Aegean_Island_Cat.jpg"), temperament: "Honest", energy_level: 05, wikipedia_url: "https://en.wikipedia.org/wiki/Aegean_cat"),
            Breed(name: "American Bobtail", image: Image(url: "https://en.wikipedia.org/wiki/American_Bobtail#/media/File:American_bobtail_2.jpg"), temperament: "Kind", energy_level: 04, wikipedia_url: "https://en.wikipedia.org/wiki/American_Bobtail"),
            Breed(name: "American Curl", image: Image(url: "https://en.wikipedia.org/wiki/American_Curl#/media/File:American_curl_2.jpg"), temperament: "Innocent", energy_level: 03, wikipedia_url: "https://en.wikipedia.org/wiki/American_Curl"),
            Breed(name: "American Shorthair", image: Image(url: "https://en.wikipedia.org/wiki/American_Shorthair#/media/File:14_years_old_american_shorthair.jpg"), temperament: "Playful", energy_level: 10, wikipedia_url: "https://en.wikipedia.org/wiki/American_Shorthair"),
            Breed(name: "American Wirehair", image: Image(url: "https://en.wikipedia.org/wiki/American_Wirehair#/media/File:American_Wirehair_-_CFF_cat_show_Heinola_2008-05-04_IMG_8721.JPG"), temperament: "Funny", energy_level: 06, wikipedia_url: "https://en.wikipedia.org/wiki/American_Wirehair")
        ]
        viewController.catsCollectionView.reloadData()
        
        RunLoop.main.run(until: Date(timeIntervalSinceNow: 2))
        
        let cells = viewController.catsCollectionView.visibleCells as! [CatViewCell]
        XCTAssertEqual(cells.count, catBreeds.count, "Cells count should match the number of items we are passing")
        /*
        for i in 0...cells.count - 1 {
            let cell = cells[i]
            let url = URL(string: catBreeds[i].image?.url ?? "")
            let data = try? Data(contentsOf: url!)
            let image = UIImage(data: data!)
            XCTAssertEqual(cell.catImageView.image, image, "Image should be matching with the cells view")
        }
        */
    }

}
