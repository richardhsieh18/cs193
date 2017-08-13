//
//  TwitterUser.swift
//  mySmashtagL9
//
//  Created by chang on 2017/8/13.
//  Copyright © 2017年 chang. All rights reserved.
//

import UIKit
import CoreData
import Twitter

class TwitterUser: NSManagedObject
{
    static func findOrCreateTweetUser(matching twitterInfo: Twitter.User, in context: NSManagedObjectContext) throws -> TwitterUser
    {
        let request: NSFetchRequest<TwitterUser> = TwitterUser.fetchRequest()
        request.predicate = NSPredicate(format: " handle = %@" , twitterInfo.screenName)
        
        do {
            let matches = try context.fetch(request)
            if matches.count > 0 {
                assert(matches.count == 1, "Tweet.findOrCreateTweet -- database inconsistency")
                return matches[0]
            }
        }catch{
            throw error
        }
        
        let twitterUser = TwitterUser(context: context)
        twitterUser.handle = twitterInfo.screenName
        twitterUser.name = twitterInfo.name
        return twitterUser
    }
    

}
