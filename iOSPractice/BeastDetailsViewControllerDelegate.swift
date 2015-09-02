//
//  BeastDetailsViewControllerDelegate.swift
//  iOSPractice
//
//  Created by Wei Chung Chuo on 8/14/15.
//  Copyright © 2015 Wei Chung Chuo. All rights reserved.
//

import UIKit

protocol BeastDetailsViewControllerDelegate: class {
    func beastDetailsViewController(controller: BeastDetailsViewController, didFinishAddingBeast beast: String)
    func beastDetailsViewController(controller: BeastDetailsViewController, didFinishEditingBeast beast: Beast)
}



