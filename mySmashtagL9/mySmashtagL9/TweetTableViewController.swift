//
//  TweetTableViewController.swift
//  mySmashtagL9
//
//  Created by chang on 2017/8/11.
//  Copyright © 2017年 chang. All rights reserved.
//

import UIKit
import Twitter


class TweetTableViewController: UITableViewController,UITextFieldDelegate
{

    private var tweets = [Array<Twitter.Tweet>](){
        didSet {
            print(tweets)
        }
    }
    
    var searchText: String? {
        didSet{
            searchTextField.text = searchText
            searchTextField.resignFirstResponder()
            tweets.removeAll()
            tableView.reloadData()
            searchForTweets()
            title = searchText
        }
    }
    
    private func twitterRequest() -> Twitter.Request?
    {
        if let query = searchText, !query.isEmpty {
            return Twitter.Request(search: query, count: 100)
        }
        return nil
    }
    
    private var lastTwitterRequest : Twitter.Request?
    
    private func searchForTweets()
    {
        if let request = twitterRequest(){
            lastTwitterRequest = request
            request.fetchTweets({ [weak self] (newTweets) in
                DispatchQueue.main.async {
                    if request == self?.lastTwitterRequest {
                        self?.tweets.insert(newTweets, at: 0)
                        //如果有新資料，伴隨動畫插入新Section
                        self?.tableView.insertSections([0], with: .fade)
                    }
                }
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //自動列高
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        //searchText = "#stanford"
    }
    //MARK: Search TextField
    @IBOutlet weak var searchTextField: UITextField! {
        didSet{
            searchTextField.delegate = self
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == searchTextField {
            searchText = searchTextField.text
        }
        return true
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return tweets.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweets[section].count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Tweet", for: indexPath)

        let tweet : Tweet = tweets[indexPath.section][indexPath.row]
//        cell.textLabel?.text = tweet.text
//        cell.detailTextLabel?.text = tweet.user.name
        if let tweetCell = cell as? TweetTableViewCell {
            tweetCell.tweet = tweet
        }
        

        return cell
    }


}
