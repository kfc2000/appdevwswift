//
//  ViewController.swift
//  appdev2-placesapp
//
//  Created by Chow Kim Foong on 28/3/21.
//

import UIKit

class ViewController: UIViewController,
                      UITableViewDelegate, UITableViewDataSource
 {

    @IBOutlet weak var tableView: UITableView!
    
    // Declare an array of Item objects
    var placeList : [Place] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        // Connect the tableView's delegate and
        // data sources to this ViewController class.
        //
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
          // Reloads the places from the database
          //
          placeList = Place.rows()
          
          // Once we have the latest data from the
          // database, get the tableView to refresh
          // itself.
          //
          tableView.reloadData()
      }


    // This is a function that the UITableViewDataSource
    // should implement. It tells the UITableView how many
    // rows there will be.
    //
    func tableView(_ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int
    {
        return placeList.count
    }

    // This is a function that the UITableViewDataSource
    // must implement. It needs to create / reuse a UITableViewCell
    // and return it to the UITableView to draw on the screen.
    //
    func tableView(_ tableView: UITableView,
        cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        // First we query the table view to see if there are
        // any UITableViewCells that can be reused. iOS will
        // create a new one if there aren't any.
        //
        let cell =
            tableView.dequeueReusableCell(withIdentifier:
            "Cell", for: indexPath)

        // Using the re-used cell, or the newly created
        // cell, we update the text label's text property.
        //
        let p = placeList[indexPath.row]
        cell.textLabel?.text = "\(p.name)"
        cell.detailTextLabel?.text = "\(p.rating) stars"

        // Instructs iOS to load the place's image from the
        // Assets.xcassets file
        //
        //cell.imageView?.image = Helpers.scaleImageToSize(
        //    image: UIImage(named: p.image), newWidth: 55, newHeight: 55)
        cell.imageView?.image = Helpers.scaleImageToSize( image: Helpers.loadImage(fileName: p.image), newWidth: 55, newHeight: 55)

        
        return cell
    }


    
    // This function is triggered when a segue will be triggered.
     override func prepare(for segue: UIStoryboardSegue,
                           sender: Any?)
     {
         if (segue.identifier == "ShowDetails")
         {
             let detailViewController =
                 segue.destination as! DetailViewController

             let selectedIndexPath = self.tableView.indexPathForSelectedRow
             
             if (selectedIndexPath != nil)
             {
                 // Set the place field with the Place
                 // object selected by the user.
                 //
                 let place = placeList[selectedIndexPath!.row]
                 detailViewController.place = place
             }
             
         }
        
         // Here we check for the AddDetails segue,
         // which is triggered by the user clicking on the +
         // button at the top of the navigation bar
         //
         if (segue.identifier == "AddDetails")
         {
             let editViewController = segue.destination as!
                 EditViewController

             let place = Place()
             editViewController.place = place
         }

     }
  

}

