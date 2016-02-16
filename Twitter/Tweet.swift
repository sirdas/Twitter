//
//  Tweet.swift
//  Twitter
//
//  Created by Reis Sirdas on 2/15/16.
//  Copyright © 2016 sirdas. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var user: User?
    var text: String?
    var createdAtString: String?
    var createdAt: String?
    
    init(dictionary: NSDictionary) {
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        
        var formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
//        createdAt = formatter.dateFromString(createdAtString!)!
//        
//        formattedDate = formatter.stringFromDate(createdAt)
//        
//        
//        retweetCount = dictionary["retweet_count"] as? Int
//        likeCount = dictionary["favorite_count"] as? Int
//        id = String(dictionary["id"]!)
    }
}
