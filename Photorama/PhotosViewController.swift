//
//  PhotosViewController.swift
//  Photorama
//
//  Created by Sebastian on 3/9/16.
//  Copyright © 2016 Sebastian. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    var store: PhotoStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        store.fetchRecentPhotos { (photoResult) -> Void in
            
            switch photoResult {
                
            case let .Success(photos):
                print(photos.count)
                
                if let firstPhoto = photos.first {
                    self.store.fetchImageForPhoto(firstPhoto, completion: { (imageResult) -> Void in
                        
                        switch imageResult {
                        case let .Success(image):
                            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                                self.imageView.image = image
                            })
                            
                        case let .Failure(error):
                            print("Error downloading image: \(error)")
                        }
                        
                    })
                }
                
            case let .Failure(error):
                print(error)
                
            }
        }
    }
}
