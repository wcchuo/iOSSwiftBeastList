//
//  BeastDetailsViewController.swift
//  iOSPractice
//
//  Created by Wei Chung Chuo on 8/14/15.
//  Copyright © 2015 Wei Chung Chuo. All rights reserved.
//

import UIKit

class BeastDetailsViewController: UITableViewController {
    weak var cancelButtonDelegate: CancelButtonDelegate?
    weak var delegate: BeastDetailsViewControllerDelegate?
    var beastToEdit: Beast?

    @IBOutlet weak var newBeastTextField: UITextField!
    
    @IBAction func cancelBarButtonPressed(sender: UIBarButtonItem) {
        cancelButtonDelegate?.cancelButtonPressedFrom(self)
    }
    
    @IBAction func doneBarButtonPressed(sender: UIBarButtonItem) {
          if let beast = beastToEdit {
              beast.objective = newBeastTextField.text!
              delegate?.beastDetailsViewController(self, didFinishEditingBeast: beast)
          } else {
            let beast = Beast(obj: newBeastTextField.text!, beastedCheck: "No")
            delegate?.beastDetailsViewController(self, didFinishAddingBeast: beast.objective)
          }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newBeastTextField.text = beastToEdit?.objective
    }
    
}
