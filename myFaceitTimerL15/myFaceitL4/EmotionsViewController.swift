//
//  EmotionsViewController.swift
//  myFaceitL4
//
//  Created by chang on 2017/8/6.
//  Copyright © 2017年 chang. All rights reserved.
//

import UIKit

class EmotionsViewController: UITableViewController
{
    

    // MARK: - Navigation


    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        //detailviewcontroller加上navigationController後需作的處理
        var destinationViewController = segue.destination
        if let navigationController = destinationViewController as? UINavigationController
        {
            destinationViewController = navigationController.visibleViewController ?? destinationViewController
        }
        
        
        if let faceViewController = destinationViewController as? FaceViewController,
            let cell = sender as? UITableViewCell,
            let indexPath = tableView.indexPath(for: cell)
                {
                    faceViewController.expression = emotionalFaces[indexPath.row].expression
                    //幫detailVC加上Title，使用sender的currentTitle
                    faceViewController.navigationItem.title = emotionalFaces[indexPath.row].name
                    //faceViewController.navigationItem.title = identifier //這樣也可以阿++自己想的
                }

    }
    
    //MARK: UITableviewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emotionalFaces.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Emotion Cell", for: indexPath)
        cell.textLabel?.text = emotionalFaces[indexPath.row].name
        return cell
    }
    
    
//    private let emotionalFaces: Dictionary<String,FacialExpression> = [
//        "sad" : FacialExpression(eyes: .closed, mouth: .frown),
//        "happy" : FacialExpression(eyes: .open, mouth: .smile),
//        "worried" : FacialExpression(eyes: .open, mouth: .smirk)
//    ]

    private var emotionalFaces: [(name: String, expression: FacialExpression)] = [
        ("sad", FacialExpression(eyes: .closed, mouth: .frown)),
        ("happy", FacialExpression(eyes: .open, mouth: .smile)),
        ("worried", FacialExpression(eyes: .open, mouth: .smirk))
    ]

}
