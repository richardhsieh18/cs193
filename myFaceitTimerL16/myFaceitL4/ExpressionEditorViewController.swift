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
        faceViewController?.expression = expression
    }
    
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var eyeControl: UISegmentedControl!
    @IBOutlet weak var monthControl: UISegmentedControl!
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "Add Emotion", name.isEmpty {
            handleUnnamedFace()
            return false
        }else{
            return super.shouldPerformSegue(withIdentifier: identifier, sender: sender)
        }
    }
    
    private func handleUnnamedFace(){
        let alert = UIAlertController(title: "無效的表情", message: "必須輸入名字", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            self.txtName.text = alert.textFields?.first?.text
            self.performSegue(withIdentifier: "Add Emotion", sender: nil)
        }))
        alert.addTextField(configurationHandler: nil)
        present(alert, animated: true)
    }
    
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
    
    
    //Prepare
    private var faceViewController: BlinkingFaceViewController?
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Embed Face" {
            faceViewController = segue.destination as? BlinkingFaceViewController
            faceViewController?.expression = expression
        }
    }
    
    //1:13
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //如果popover是在navation下的popover，如果知道方向則cancel 按鈕消失
        if let popoverPresentationController = navigationController?.popoverPresentationController{
            if popoverPresentationController.arrowDirection != .unknown {
                    navigationItem.leftBarButtonItem = nil
            }
        }
        //1:11:00這段很重要，autoLayout
        var size = tableView.minimumSize(forSection: 0)
        size.height -= tableView.heightForRow(at: IndexPath(row: 1, section: 0))
        size.height += size.width
        preferredContentSize = size
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        presentingViewController?.dismiss(animated: true)
    }
}
//1:11:00 AutoLayout
extension UITableView {
    func minimumSize(forSection section: Int) -> CGSize {
        var width: CGFloat = 0
        var height: CGFloat = 0
        for row in 0..<numberOfRows(inSection: section){
            let indexPath = IndexPath(row: row, section: section)
            if let cell = cellForRow(at: indexPath) ?? dataSource?.tableView(self, cellForRowAt: indexPath){
                //重點在這 1:15:14
                let cellSize = cell.contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
                width = max(width, cellSize.width)
                height += heightForRow(at: indexPath)
            }
        }
        return CGSize(width: width, height: height)
    }
    
    func heightForRow(at indexPath: IndexPath? = nil) -> CGFloat{
        if indexPath != nil, let height = delegate?.tableView?(self, heightForRowAt: indexPath!){
            return height
        }else{
            return rowHeight
        }
    }
}
