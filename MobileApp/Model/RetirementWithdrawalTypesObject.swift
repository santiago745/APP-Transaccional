//
//  RetirementWithdrawalTypesObject.swift
//  MobileApp
//
//  Created by Periferia on 27/11/17.
//  Copyright © 2017 Old Mutual. All rights reserved.
//

import Foundation
import UIKit

class RetirementWithdrawalTypesObject: NSObject {
    
    var TypeWithdrawalTypes = ""
    var DisplayName = ""
    var DisplayNameDescriptor = ""
    var Value = ""
    var DisclaimerMessage = ""
    var FundsAffected = [RetirementFundsAffectedObject]()
    
    
    
    init (dic:NSDictionary)
    {
        TypeWithdrawalTypes = ValueJsonString(dic: dic, key: "Type")
        DisplayName = ValueJsonString(dic: dic, key: "DisplayName")
        DisplayNameDescriptor = ValueJsonString(dic: dic, key: "DisplayNameDescriptor")
        Value = ValueJsonString(dic: dic, key: "Value")
        DisclaimerMessage = ValueJsonString(dic: dic, key: "DisclaimerMessage")
        
        if let arrayFundsAffected = ValueJsonArray(dic: dic, key: "FundsAffected"){
            
            for FundsAffecteddic in arrayFundsAffected{
                
                if let dicFundsAffected = FundsAffecteddic as? NSDictionary{
                    
                    FundsAffected.append(RetirementFundsAffectedObject(dic : dicFundsAffected))
                }
                
                
            }
            
        }
        
    }
    
}
