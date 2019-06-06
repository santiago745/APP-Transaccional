//
//  RetirementWithdrawalSimulationObject.swift
//  MobileApp
//
//  Created by Periferia on 19/01/18.
//  Copyright © 2018 Old Mutual. All rights reserved.
//

//
//  RetirementFundsAffectedObject.swift
//  MobileApp
//
//  Created by Periferia on 27/11/17.
//  Copyright © 2017 Old Mutual. All rights reserved.
//

import Foundation
import UIKit

class RetirementWithdrawalSimulationObject: NSObject {
    
    var Charges = [RetirementWithdrawalSimulationChargesObject]()
    var ChargesTotal = 0.0
    var Investments = [RetirementWithdrawalInvestmentsObject]()
    var WithdrewCapital = 0.0
    var WithdrewReturn = 0.0
    var WithdrewTotal = 0.0
    
    
    init (dic:NSDictionary)
    {
        
        if let chargesTypes = ValueJsonArray(dic: dic, key: "Charges"){
            
            for chargesdic in chargesTypes{
                
                if let dicwithdrawal = chargesdic as? NSDictionary{
                    
                    Charges.append(RetirementWithdrawalSimulationChargesObject(dic : dicwithdrawal))
                }
                
                
            }
            }
        ChargesTotal = ValueJsonDouble(dic: dic, key: "ChargesTotal")
        
        if let InvestmentsTypes = ValueJsonArray(dic: dic, key: "Investments"){
            
            for Investmentsdic in InvestmentsTypes{
                
                if let dicInvestments = Investmentsdic as? NSDictionary{
                    
                    Investments.append(RetirementWithdrawalInvestmentsObject(dic : dicInvestments))
                }
                
                
            }
        }
        
            
        WithdrewCapital = ValueJsonDouble(dic: dic, key: "WithdrewCapital")
        WithdrewReturn = ValueJsonDouble(dic: dic, key: "WithdrewReturn")
        WithdrewTotal = ValueJsonDouble(dic: dic, key: "WithdrewTotal")
        
    
    
}
}
