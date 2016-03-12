//
//  Photo.swift
//  Photorama
//
//  Created by Sebastian on 3/12/16.
//  Copyright © 2016 Sebastian. All rights reserved.
//

import UIKit
import CoreData


class Photo: NSManagedObject {

// Insert code here to add functionality to your managed object subclass

    var image: UIImage?
    
    //called when objects are added to the db
    override func awakeFromInsert() {
        title = ""
        photoID = ""
        remoteURL = NSURL()
        photoKey = NSUUID().UUIDString
        dateTaken = NSDate()
    }
    
}
