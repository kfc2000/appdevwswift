//
//  EditViewController.swift
//  appdev2-placesapp
//
//  Created by Chow Kim Foong on 28/3/21.
//

import UIKit

class EditViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //@IBOutlet weak var imageTextField: UITextField!
    @IBOutlet weak var selectPictureButton: UIButton!
    
    @IBOutlet weak var takePictureButton: UIButton!
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var ratingTextField: UITextField!
    
    @IBOutlet weak var descTextView: UITextView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var place: Place?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        Helpers.setupScrollView(scrollView: self.scrollView)
        // We check if this device has a camera
        //
         
        if !(UIImagePickerController.isSourceTypeAvailable(
        .camera))
        {
        // If not, we will just hide the takePicture button
         
        //
        takePictureButton.isHidden = true
         
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //imageTextField.text = "\(place!.image)"
        placeImage.image = Helpers.loadImage(fileName: place!.image)
        nameTextField.text = "\(place!.name)"
        ratingTextField.text = "\(place!.rating)"
        descTextView.text = "\(place!.desc)"
    }

    @IBAction func selectPictureButtonPressed(_ sender: Any) {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        // Setting this to true allows the user to crop and scale // the image to a square after the image is selected.
        //
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true)
    }
    @IBAction func takePictureButtonPressed(_ sender: Any) {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        // Setting this to true allows the user to crop and scale // the image to a square after the photo is taken.
        //
        picker.allowsEditing = true
        picker.sourceType = .camera
        self.present(picker, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func saveButtonPressed(_ sender: Any) {
        //place!.image = imageTextField.text ?? ""
        place!.name = nameTextField.text ?? ""
        place!.rating = Int(ratingTextField.text ?? "") ?? 0
        place!.desc = descTextView.text

        // Save the place into the database
        //
        place!.save()
        
        // Bring the user back to the previous screen.
        //
        self.navigationController?.popViewController(animated: true)


    }
    // This function is called after the user took the picture, // or selected a picture from the photo library.
    // When that happens, we simply assign the image binary, // represented by UIImage, into the imageView we created. //
    // iOS doesn’t close the picker controller
    // automatically, so we have to do this ourselves by calling // dismissViewControllerAnimated.
    //
    func imagePickerController(_ picker: UIImagePickerController,
    didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
    var chosenImage : UIImage = info[.originalImage] as! UIImage
    
    if picker.allowsEditing
    {
        chosenImage = info[.editedImage] as! UIImage
    }
    // Displays the image in our UI.
    //
    self.placeImage!.image = chosenImage
    
    // Save this image into a random file name
    // after the user has selected it.
     
    //
    if place!.image == ""
     
    {
    place!.image = NSUUID().uuidString + ".png"
     
    }
    Helpers.saveImageToPNG(placeImage.image!, place!.image)
    
    // This closes the picker
    //
    picker.dismiss(animated: true)
    }
}
