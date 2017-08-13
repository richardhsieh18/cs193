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
        if let context = container?.viewContext {
            let request: NSFetchRequest<TwitterUser> = TwitterUser.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor(key: "handle", ascending: true)]
            request.predicate = NSPredicate(format: "any tweets.text contains[c] %@", mention!)
                    fetchedResultsController = NSFetchedResultsController<TwitterUser>(
                        fetchRequest: request,
                        managedObjectContext: context,
                        sectionNameKeyPath: nil,
                        cacheName: nil
            )
            fetchedResultsController?.delegate = self
            try? fetchedResultsController?.performFetch()
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TwitterUser Cell", for: indexPath)
            if let twitterUser = fetchedResultsController?.object(at: indexPath){
            cell.textLabel?.text = twitterUser.handle
            }
            return cell
        }
}
