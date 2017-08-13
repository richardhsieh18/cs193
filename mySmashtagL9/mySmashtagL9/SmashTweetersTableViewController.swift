//
//  SmashTweetersTableViewController.swift
//  mySmashtagL9
//
//  Created by chang on 2017/8/13.
//  Copyright © 2017年 chang. All rights reserved.
//

import UIKit
import CoreData

class SmashTweetersTableViewController: FetchResultsTableViewController
{
    var mention : String? {
        didSet {
            updateUI()
        }
    }
    var container : NSPersistentContainer? =
    (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
        { didSet { updateUI() } }
    
    var fetchedResultsController: NSFetchedResultsController<TwitterUser>?
    
    private func updateUI(){

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TwitterUser Cell", for: indexPath)
            if let twitterUser = fetchedResultsController?.object(at: indexPath){
            cell.textLabel?.text = twitterUser.handle
            }
            return cell
        }
}
