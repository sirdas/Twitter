//
//  TwitterClient.swift
//  Twitter
//
//  Created by Reis Sirdas on 2/15/16.
//  Copyright © 2016 sirdas. All rights reserved.
//

import BDBOAuth1Manager
import UIKit

let twitterConsumerKey = "aCJadExq2mrMRgje6Njx20EPc"
let twitterConsumerSecret = "UPmVOjCFW3ifmPfQPu77pLKywCwmpYBwqPols99FNExspKbeFw"
let twitterBaseURL = NSURL(string: "https://api.twitter.com/")

class TwitterClient: BDBOAuth1SessionManager {
    var loginCompletion: ((user:User?, error: NSError?) -> ())?
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        
        return Static.instance
    }
    
    func homeTimelineWithParams(params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> ()) {
        self.GET("1.1/statuses/home_timeline.json", parameters: params, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
            //                print("home timeline: \(response!)")
            let tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
//            for tweet in tweets {
//                print("text: \(tweet.text), created: \(tweet.createdAt)")
            completion(tweets: tweets, error: nil)
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                print("Error getting home timeline")
    completion(tweets:nil, error: error)
        })
    }
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
        loginCompletion = completion
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            print("Got the request token")
            let authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL!)
            
            }) { (error: NSError!) -> Void in
                print("Failed to get request token")
                self.loginCompletion?(user: nil, error: error)
        }
    }
    
    func openURL(url: NSURL) {
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query), success: { (accessToken: BDBOAuth1Credential!) -> Void in
            print("Got the access token")
            self.requestSerializer.saveAccessToken(accessToken)
            self.GET("1.1/account/verify_credentials.json", parameters: nil, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
                
                if let responseDictionary: NSDictionary = response as? NSDictionary {
                    let user = User(dictionary: responseDictionary as NSDictionary)
//                    print(user.name)
                    User.currentUser = user
                    self.loginCompletion?(user: user, error: nil)
                }
                }, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                    print("Error getting current user")
                    self.loginCompletion?(user: nil, error: error)
            })
            }) { (error: NSError!) -> Void in
                print("Failed to receive access token")
                self.loginCompletion?(user: nil, error: error)
        }
    }
    
    func tweet(params: NSDictionary?) {
        POST("1.1/statuses/update.json", parameters: params, progress: { (progress) -> Void in
            }, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
                
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                
        })
    }
    
    func retweet(id: String) {
        POST("1.1/statuses/retweet/\(id).json", parameters: nil, progress: { (progress) -> Void in
            }, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
                
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                
        })
    }
    
    func like(id: String) {
        POST("1.1/favorites/create.json?id=\(id)", parameters: nil, progress: { (progress) -> Void in
            }, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
        })
    }
    
}
