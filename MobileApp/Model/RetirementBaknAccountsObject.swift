//
//  RetirementBaknAccountsObject.swift
//  MobileApp
//
//  Created by Periferia on 20/11/17.
//  Copyright © 2017 Old Mutual. All rights reserved.
//
import Foundation
import UIKit

public class RetirementBaknAccountsObject:NSObject{
    
    var Number = ""
    var TypeAcount = 0
    var TypeName = ""
    var BankId = ""
    var BankName = ""
    var CityName = ""
    var Status = 0
    var OwnerName = ""
    var OwnerLastName = ""
    var OwnerDocNumber = ""
    var OwnerDocType = ""
    var OwnerTypeId = 0
    
    
    
    init (dic:NSDictionary)
    {
        Number = ValueJsonString(dic: dic, key: "Number")
        TypeAcount = ValueJsonInt(dic: dic, key: "Type")
        TypeName = ValueJsonString(dic: dic, key: "TypeName")
        BankId = ValueJsonString(dic: dic, key: "BankId")
        BankName = ValueJsonString(dic: dic, key: "BankName")
        CityName = ValueJsonString(dic: dic, key: "CityName")
        Status = ValueJsonInt(dic: dic, key: "Status")
        OwnerName = ValueJsonString(dic: dic, key: "OwnerName")
        OwnerLastName = ValueJsonString(dic: dic, key: "OwnerLastName")
        OwnerDocNumber = ValueJsonString(dic: dic, key: "OwnerDocNumber")
        OwnerDocType = ValueJsonString(dic: dic, key: "OwnerDocType")
        OwnerTypeId = ValueJsonInt(dic: dic, key: "OwnerTypeId")
 
        
    }}
