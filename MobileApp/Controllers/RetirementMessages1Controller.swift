//
//  RetirementMessages1Controller.swift
//  MobileApp
//
//  Created by Periferia on 21/11/17.
//  Copyright © 2017 Old Mutual. All rights reserved.
//

import Foundation
import UIKit
var RETIREMNTMESSANGECONTROLL:RetirementMessages1Controller?
class RetirementMessages1Controller: UIViewController, UITableViewDelegate {
    @IBOutlet weak var lbMessages1: UILabel!
    
    var Messages1 = ""
    var Messages2 = ""
    var Messages3 = ""
    var Messages4 = ""
    var Messages5 = ""
    var Messages6 = ""
    var Messages7 = ""
    var Messages8 = ""
    var Messages9 = ""
    var Messages10 = ""
    var Messages11 = ""
    var Messages12 = ""
    var Messages13 = ""
    var Messages14 = ""
    var Messages15 = ""
    var Messages16 = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getContenedorMessages(controller: self, numeroDeDocumento: "", tipoDeDocument: "", Ok: {rest in
            
            self.Messages1 = rest.DisclaimerAppMobile01
            self.Messages2 = rest.DisclaimerAppMobile02
            self.Messages3 = rest.DisclaimerAppMobile03
            self.Messages4 = rest.DisclaimerAppMobile04
            self.Messages5 = rest.DisclaimerAppMobile05
            self.Messages6 = rest.DisclaimerAppMobile06
            self.Messages7 = rest.DisclaimerAppMobile07
            self.Messages8 = rest.DisclaimerAppMobile08
            self.Messages9 = rest.DisclaimerAppMobile09
            self.Messages10 = rest.DisclaimerAppMobile10
            self.Messages11 = rest.DisclaimerAppMobile11
            self.Messages12 = rest.DisclaimerAppMobile12
            self.Messages13 = rest.DisclaimerAppMobile13
            self.Messages14 = rest.DisclaimerAppMobile14
            self.Messages15 = rest.DisclaimerAppMobile15
            self.Messages16 = rest.DisclaimerAppMobile16
            self.lbMessages1.text = self.Messages1
            
            
            
    //       RETIREMNTMESSANGE2CONTROLL!.setMensage(retiroMen: rest)
        })
        

        RETIREMNTMESSANGECONTROLL = self
    }


}
