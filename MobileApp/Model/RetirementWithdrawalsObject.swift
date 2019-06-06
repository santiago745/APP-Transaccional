//
//  RetirementWithdrawalsObject.swift
//  MobileApp
//
//  Created by Periferia on 27/11/17.
//  Copyright © 2017 Old Mutual. All rights reserved.
//

import Foundation
import UIKit

class RetirementWithdrawalsObject: NSObject {
    
    var Message = ""
    var FundDistribution = [RetirementFundsAffectedObject]()
    
    
    
    init (dic:NSDictionary)
    {

        Message = ValueJsonString(dic: dic, key: "Message")
      
        if let arrayWithdrawalTypes = ValueJsonArray(dic: dic, key: "FundDistribution"){
            
            for withdrawaldic in arrayWithdrawalTypes{
                
                if let dicwithdrawal = withdrawaldic as? NSDictionary{
                    
                    FundDistribution.append(RetirementFundsAffectedObject(dic : dicwithdrawal))
                }
                
                
            }
            
        }
        
        
    }
    
}
