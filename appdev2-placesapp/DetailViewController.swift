//
//  DetailViewController.swift
//  appdev2-placesapp
//
//  Created by Chow Kim Foong on 28/3/21.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var place : Place?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // This function is triggered when the view is about to appear.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameLabel.text = place?.name
        descriptionLabel.text = place?.desc
        //placeImage.image = UIImage(named: (place?.image)!)
        placeImage.image = Helpers.loadImage(fileName: place!.image)
        
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Here we check for the EditDetails segue,
        // which is triggered by the user clicking on the +
        // button at the top of the navigation bar
        //
        if (segue.identifier == "EditDetails")
        {
            let editViewController = segue.destination as! EditViewController
            
            editViewController.place = place
        }
    }

}
