//
//  File.swift
//  Photorama
//
//  Created by Sebastian on 3/11/16.
//  Copyright © 2016 Sebastian. All rights reserved.
//

import UIKit

class PhotoInfoViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    var photo: Photo! {
        
        didSet {
            navigationItem.title = photo.title
        }
    }
    
    var store: PhotoStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        store.fetchImageForPhoto(photo) { (result) -> Void in
            
            switch result {
                
            case let .Success(image):
                
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    self.imageView.image = image
                })
                
            case let .Failure(error):
                
                print("Error fetching image: \(error)")
            }
        }
    }
}
