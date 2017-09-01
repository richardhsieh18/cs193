//
//  ExpressionEditorViewController.swift
//  myFaceitL4
//
//  Created by chang on 2017/9/1.
//  Copyright © 2017年 chang. All rights reserved.
//

import UIKit

class ExpressionEditorViewController: UITableViewController,UITextFieldDelegate {
    
    var name: String {
        return txtName.text ?? ""
    }
    
    private let eyeChoices = [FacialExpression.Eyes.open, .closed, .squinting]
    private let monthChoices = [FacialExpression.Mouth.frown, .smirk, .neutral, .grin , .smile]
    
    var expression : FacialExpression {
        return FacialExpression(
            eyes: eyeChoices[eyeControl?.selectedSegmentIndex ?? 0],
            mouth: monthChoices[monthControl?.selectedSegmentIndex ?? 0]
        )
    }
    
    @IBAction func updateFace() {
        print("\(name)  =   \(expression)")
    }
    
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var eyeControl: UISegmentedControl!
    @IBOutlet weak var monthControl: UISegmentedControl!
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 {
            return tableView.bounds.size.width
        }else{
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
    }
    
    //Textfield Return
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        presentingViewController?.dismiss(animated: true)
    }
}
