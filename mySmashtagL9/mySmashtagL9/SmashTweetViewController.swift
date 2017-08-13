//
//  SmashTweetViewController.swift
//  mySmashtagL9
//
//  Created by chang on 2017/8/13.
//  Copyright © 2017年 chang. All rights reserved.
//

import UIKit
import Twitter
import CoreData

class SmashTweetViewController: TweetTableViewController
{
    var container : NSPersistentContainer? =
        (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    
    override func insertTweets(_ newTweets: [Twitter.Tweet]) {
        super.insertTweets(newTweets)
        updateDatabase(with: newTweets)
    }
    
    private func updateDatabase(with tweets: [Twitter.Tweet])
    {
        //這不在MainThread裡
        container?.performBackgroundTask{ [weak self] (context) in
            for twitterInfo in tweets{
                _ = try? Tweet.findOrCreateTweet(matching: twitterInfo, in: context)
            }
            try? context.save()
            self?.printDatabaseStatistics()
        }

    }
    private func printDatabaseStatistics() {
        if let context = container?.viewContext{
            context.perform {
                //原本不在mainThread，放在perfom裡讓他在mainThread執行
                if Thread.isMainThread{
                    print("on main thread")
                }else{
                    print("off main thread")
                }
                let  request: NSFetchRequest<Tweet> = Tweet.fetchRequest()
                if let tweetCount = (try? context.fetch(request))?.count{
                    print("\(tweetCount) tweets")
                }
                if let tweeterCount = try? context.count(for: TwitterUser.fetchRequest())
                {
                    print("\(tweeterCount) Twitter users")
                }
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Tweerters Mentioning Search Term" {
            if let tweetersTVC = segue.destination as? SmashTweetersTableViewController {
                tweetersTVC.mention = searchText
                tweetersTVC.container = container
            }
        }
    }
}
