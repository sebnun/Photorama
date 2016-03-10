//
//  FlickrAPI.swift
//  Photorama
//
//  Created by Sebastian on 3/9/16.
//  Copyright © 2016 Sebastian. All rights reserved.
//

import Foundation

enum Method: String {
    case RecentPhotos = "flickr.photos.getRecent"
}

struct FlickrAPI {
    
    private static let baseURLString = "https://api.flickr.com/services/rest"
    //please get your own key if you're going to use this for more than testing
    private static let APIKey = "a6d819499131071f158fd740860a5a88"
    
    private static func flickrURL(method method: Method, parameters: [String:String]?) -> NSURL {
        
        let components = NSURLComponents(string: baseURLString)!
        var queryItems = [NSURLQueryItem]()
        
        let baseParams = [
            "method": method.rawValue,
            "format": "json",
            "nojsoncallback": "1",
            "api_key": APIKey
        ]
        
        for (key, value) in baseParams {
            
            let item = NSURLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
        
        if let additionalParams = parameters {
            
            for (key, value) in additionalParams {
                
                let item = NSURLQueryItem(name: key, value: value)
                queryItems.append(item)
            }
        }
        
        components.queryItems = queryItems
        
        return components.URL!
    }
    


    
    static func recentPhotosURL() -> NSURL {
        return flickrURL(method: .RecentPhotos,
            parameters: ["extras": "url_h,date_taken"])
    }
    
}

