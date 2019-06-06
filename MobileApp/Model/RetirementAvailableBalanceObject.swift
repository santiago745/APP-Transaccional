//
//  RetirementAvailableBalanceObject.swift
//  MobileApp
//
//  Created by Periferia on 21/11/17.
//  Copyright © 2017 Old Mutual. All rights reserved.
//

import Foundation
import UIKit

class RetirementAvailableBalanceObject: NSObject {
    
    var Message:String?
    
    var Value = 0.0
    
    var Charges = [RetirementBalanceChargesObject]()

    
    init (dic:NSDictionary)
    {
         Message = ValueJsonString(dic: dic, key: "Message")
        
         Value = ValueJsonDouble(dic: dic, key: "Value")
        
        if let arraybalance = ValueJsonArray(dic: dic, key: "Charges"){
            
            for contractsdic in arraybalance{
                
                if let diccontracts = contractsdic as? NSDictionary{
                    
                    Charges.append(RetirementBalanceChargesObject(dic : diccontracts))
                }
                
                
            }
            
        }
        
    }
    
}
