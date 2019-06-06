//
//  ContractsObject.swift
//  agregarlistas
//
//  Created by Periferia on 19/11/17.
//  Copyright © 2017 PeriferiaxzvNextU. All rights reserved.
//

import Foundation
import UIKit

class RetirementContractsObject:NSObject{
    
    var Number = ""
    var ProductCode = ""
    var PlanCode = ""
    var WithdrawalsAllowed = true
    var Fields = [RetirementFieldsObject]()
    
    init(dic: NSDictionary){
        
        Number = ValueJsonString(dic: dic, key: "Number")
        ProductCode = ValueJsonString(dic: dic, key: "ProductCode")
        PlanCode = ValueJsonString(dic: dic, key: "PlanCode")
        WithdrawalsAllowed = ValueJsonBool(dic: dic, key: "WithdrawalsAllowed")
        
        if let arrayField = ValueJsonArray(dic: dic, key: "Fields")
        {
            for fielddic in arrayField
            {
                if let dicfield = fielddic as? NSDictionary
                {
                    Fields.append(RetirementFieldsObject(dic: dicfield))
                }
            }
            
        }
        
    }
}
