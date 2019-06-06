//
//  SpinnerController.swift
//  MobileApp
//
//  Created by Pedro A. Daza Balaguera on 27/03/17.
//  Copyright © 2017 Old Mutual. All rights reserved.
//

import Foundation
import UIKit

class SpinnerController : UIViewController
{
    
    @IBOutlet weak var vBack: UIView!
    @IBOutlet weak var sppCargando: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sppCargando.startAnimating()
        vBack.layer.cornerRadius = 5.0
        
    }
    
    func hideSpinner()
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    func hideSpinnerCompletion(Ok :@escaping (() -> Void))
    {
        self.dismiss(animated: true, completion:
            {
                Ok()
        })
    }
}
