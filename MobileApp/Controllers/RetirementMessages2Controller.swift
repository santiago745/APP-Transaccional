//
//  RetirementMessages2Controller.swift
//  MobileApp
//
//  Created by Periferia on 21/11/17.
//  Copyright © 2017 Old Mutual. All rights reserved.
//

import Foundation
import UIKit
import Firebase
var RETIREMNTMESSANGE2CONTROLL:RetirementMessages2Controller?
class RetirementMessages2Controller: UIViewController, UITableViewDelegate {
    @IBOutlet weak var lbMessages2: UILabel!
    
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
    var MessageInitial = ""
    
    var msg2 = RetirementMessagesObject(dic: ["":""])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
 //       Messages2 = (RETIREMNTMESSANGECONTROLL?.Messages2)!
        
    //    self.lbMessages2.text = Messages2
        MessageInitial = lbMessages2.text!
       // let storyBoard : UIStoryboard = UIStoryboard(name: "Balances", bundle:nil)
     
        if(MessageInitial.isEmpty){
            Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
                AnalyticsParameterItemID: "2" as NSObject,
                AnalyticsParameterItemName: "botón_de_Retiros_dentro_de_un_contrato" as NSObject,
                AnalyticsParameterContentType: "cont" as NSObject
                ])

            getContenedorMessages(controller: self, numeroDeDocumento: "", tipoDeDocument: "", Ok: {rest in
                
                //let msgDisclaimer = RetirementMessages2Controller()
                
               // let resultViewController = storyBoard.instantiateViewController(withIdentifier: "retirementMessages1Controller") as! RetirementMessages1Controller
                
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
                self.lbMessages2.text = rest.DisclaimerAppMobile02
                
                //       RETIREMNTMESSANGE2CONTROLL!.setMensage(retiroMen: rest)
            })
            
        }
        else{
           self.lbMessages2.text = RETIREMNTMESSANGECONTROLL?.Messages2
        }
        RETIREMNTMESSANGE2CONTROLL = self
    }

    
}
