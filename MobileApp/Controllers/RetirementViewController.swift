//
//  RetirementViewController.swift
//  MobileApp
//
//  Created by Periferia on 24/11/17.
//  Copyright © 2017 Old Mutual. All rights reserved.
//

import Foundation
import UIKit

class RetirementViewController: UIViewController, UITableViewDelegate {
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.performSegue(withIdentifier: "retirementValue", sender: self)
        
        
    }
    
    
}
