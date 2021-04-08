//
//  Extensions.swift
//  appdev1-pm-tableviewapp
//
//  Created by Chow Kim Foong on 28/9/20.
//  Copyright © 2020 Your Organization. All rights reserved.
//

import UIKit

class Helpers: NSObject
{
    /// Scales an image to fit within a bounds with a size governed by the passed size. Also keeps the aspect ratio.
    /// Switch MIN to MAX for aspect fill instead of fit.
    ///
    /// - returns: a new scaled image.
    static func scaleImageToSize(image: UIImage?, newWidth: CGFloat, newHeight: CGFloat) -> UIImage? {
        guard image != nil else {
            return nil
        }
        var scaledImageRect = CGRect.zero

        let aspectWidth = newWidth/image!.size.width
        let aspectheight = newHeight/image!.size.height

        let aspectRatio = max(aspectWidth, aspectheight)

        scaledImageRect.size.width = image!.size.width * aspectRatio;
        scaledImageRect.size.height = image!.size.height * aspectRatio;
        scaledImageRect.origin.x = (newWidth - scaledImageRect.size.width) / 2.0;
        scaledImageRect.origin.y = (newHeight - scaledImageRect.size.height) / 2.0;

        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image!.draw(in: scaledImageRect)
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return scaledImage!
    }
    
    
    fileprivate static var monitoringScrollView : UIScrollView?
    
    // Sets up the scroll view.
    //
    static func setupScrollView(scrollView: UIScrollView)
    {
        var containerView = scrollView.subviews[0]

        containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        // this is important for scrolling
        containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true

        let notificationCenter = NotificationCenter.default
        
        if monitoringScrollView == nil
        {
            notificationCenter.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil)
            {
                (notification) in

                let info = notification.userInfo!
                let rect: CGRect = info[UIResponder.keyboardFrameBeginUserInfoKey] as! CGRect
                let kbSize = rect.size

                monitoringScrollView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.height, right: 0)

                //print (scrollView)
                //print ("k-show")
            }

            notificationCenter.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil)
            {
                (notification) in
                monitoringScrollView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

                //print (scrollView)
            }
        }
        
        monitoringScrollView = scrollView
    }
    
    
    // Saves an UIImage into JPG into the Documents folder
    //
    static func saveImageToJPG(_ image: UIImage, _ filename:String, _ compressionQuality: CGFloat = 0.7)
    {
        do
        {
            let documentsUrl = FileManager.default.urls(
                for: .documentDirectory,
                in: .userDomainMask).first!

            let imageUrl = documentsUrl.appendingPathComponent(filename)

            try image.jpegData(compressionQuality: compressionQuality)?.write(to: imageUrl)
        }
        catch
        {
        }
    }

    // Saves an UIImage into PNG into the Documents folder
    //
    // (there’s no quality property to set, unlike JPG)
    //
    static func saveImageToPNG(_ image: UIImage, _ filename:String)
    {
        do
        {
            let documentsUrl = FileManager.default.urls(
                for: .documentDirectory,
                in: .userDomainMask).first!

            let imageUrl = documentsUrl.appendingPathComponent(filename)

            try image.pngData()?.write(to: imageUrl)
        }
        catch
        {
        }
    }

    // Loads an image from the Documents folder in your application.
    //
    static func loadImage(fileName: String) -> UIImage?
    {
        let documentsUrl = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask).first!

        let imageUrl = documentsUrl.appendingPathComponent(fileName)
        do {
            let imageData = try Data(contentsOf: imageUrl)
            return UIImage(data: imageData)
        } catch {
            print("Error loading image : \(error)")
        }
        return nil
    }
}
