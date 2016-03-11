//
//  PhotosViewController.swift
//  Photorama
//
//  Created by Sebastian on 3/9/16.
//  Copyright © 2016 Sebastian. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet var collectionView: UICollectionView!
    var store: PhotoStore!
    let photoDataSource = PhotoDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = photoDataSource
        collectionView.delegate = self
        
        store.fetchRecentPhotos { (photoResult) -> Void in
            
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                
                switch photoResult {
                case let .Success(photos):
                    print(photos.count)
                    self.photoDataSource.photos = photos
                case let .Failure(error):
                    print("Error fecthing recent photos: \(error)")
                    self.photoDataSource.photos.removeAll()
                }
                
                self.collectionView.reloadSections(NSIndexSet(index: 0))
            })
            
        }
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        
        let photo = photoDataSource.photos[indexPath.row]
        
        store.fetchImageForPhoto(photo) { (result) -> Void in
            
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                
                let photoIndex = self.photoDataSource.photos.indexOf(photo)!
                let photoIndexPath = NSIndexPath(forRow: photoIndex, inSection: 0)
                
                if let cell = self.collectionView.cellForItemAtIndexPath(photoIndexPath) as? PhotoCollectionViewCell {
                    cell.updateWithImage(photo.image)
                }
            })
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowPhoto" {
            if let selectedIndexPath = collectionView.indexPathsForSelectedItems()?.first {
                
                let photo = photoDataSource.photos[selectedIndexPath.row]
                
                let destionationVC = segue.destinationViewController as! PhotoInfoViewController
                destionationVC.photo = photo
                destionationVC.store = store
            }
        }
    }
}
