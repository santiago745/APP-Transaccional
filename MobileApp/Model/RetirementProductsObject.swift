//
//  ProductsObject.swift
//  agregarlistas
//
//  Created by Periferia on 19/11/17.
//  Copyright © 2017 PeriferiaxzvNextU. All rights reserved.
//

import Foundation
import UIKit

class RetirementProductsObject: NSObject{
    
    var Key = ""
    var Caption = ""
    var TotalBalance = ""
    var Contracts = [RetirementContractsObject]()
    
    init(dic: NSDictionary){
        
        Key = ValueJsonString(dic: dic, key: "Key")
        Caption = ValueJsonString(dic: dic, key: "Caption")
        TotalBalance = ValueJsonString(dic: dic, key: "TotalBalance")
        
        if let arrayContracts = ValueJsonArray(dic: dic, key: "Contracts"){
            
            for contractsdic in arrayContracts{
                
                if let diccontracts = contractsdic as? NSDictionary{
                    
                    Contracts.append(RetirementContractsObject(dic : diccontracts))
                }
                
                
            }
            
        }
        
    }
}
