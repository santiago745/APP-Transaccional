//
//  RetirementAcountObject.swift
//  MobileApp
//
//  Created by Periferia on 20/11/17.
//  Copyright © 2017 Old Mutual. All rights reserved.
//
import Foundation
import UIKit

public class RetirementAcountObject:NSObject{
    
    var NotAccountsMessage = ""
    var BaknAccounts = [RetirementBaknAccountsObject]()
    
    
    
    init (dic:NSDictionary)
    {
        NotAccountsMessage = ValueJsonString(dic: dic, key: "NotAccountsMessage")

        if let arrayAcount = ValueJsonArray(dic: dic, key: "BaknAccounts"){
            
            for acountdic in arrayAcount{
                
                if let dicacount = acountdic as? NSDictionary{
                    
                    BaknAccounts.append(RetirementBaknAccountsObject(dic : dicacount))
                }
                
                
            }
            
        }
        
    }}
