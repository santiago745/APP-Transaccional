//
//  RetirementMessagesObject.swift
//  MobileApp
//
//  Created by Periferia on 21/11/17.
//  Copyright © 2017 Old Mutual. All rights reserved.
//
import Foundation
import UIKit

public class RetirementMessagesObject:NSObject{
    
    var DisclaimerAppMobile01 = ""
    var DisclaimerAppMobile02 = ""
    var DisclaimerAppMobile03 = ""
    var DisclaimerAppMobile04 = ""
    var DisclaimerAppMobile05 = ""
    var DisclaimerAppMobile06 = ""
    var DisclaimerAppMobile07 = ""
    var DisclaimerAppMobile08 = ""
    var DisclaimerAppMobile09 = ""
    var DisclaimerAppMobile10 = ""
    var DisclaimerAppMobile11 = ""
    var DisclaimerAppMobile12 = ""
    var DisclaimerAppMobile13 = ""
    var DisclaimerAppMobile14 = ""
    var DisclaimerAppMobile15 = ""
    var DisclaimerAppMobile16 = ""
    
    
    init (dic:NSDictionary)
    {
        DisclaimerAppMobile01 = ValueJsonString(dic: dic, key: "DisclaimerAppMobile01")
        DisclaimerAppMobile02 = ValueJsonString(dic: dic, key: "DisclaimerAppMobile02")
        DisclaimerAppMobile03 = ValueJsonString(dic: dic, key: "DisclaimerAppMobile03")
        DisclaimerAppMobile04 = ValueJsonString(dic: dic, key: "DisclaimerAppMobile04")
        DisclaimerAppMobile05 = ValueJsonString(dic: dic, key: "DisclaimerAppMobile05")
        DisclaimerAppMobile06 = ValueJsonString(dic: dic, key: "DisclaimerAppMobile06")
        DisclaimerAppMobile07 = ValueJsonString(dic: dic, key: "DisclaimerAppMobile07")
        DisclaimerAppMobile08 = ValueJsonString(dic: dic, key: "DisclaimerAppMobile08")
        DisclaimerAppMobile09 = ValueJsonString(dic: dic, key: "DisclaimerAppMobile09")
        DisclaimerAppMobile10 = ValueJsonString(dic: dic, key: "DisclaimerAppMobile10")
        DisclaimerAppMobile11 = ValueJsonString(dic: dic, key: "DisclaimerAppMobile11")
        DisclaimerAppMobile12 = ValueJsonString(dic: dic, key: "DisclaimerAppMobile12")
        DisclaimerAppMobile13 = ValueJsonString(dic: dic, key: "DisclaimerAppMobile13")
        DisclaimerAppMobile14 = ValueJsonString(dic: dic, key: "DisclaimerAppMobile14")
        DisclaimerAppMobile15 = ValueJsonString(dic: dic, key: "DisclaimerAppMobile15")
        DisclaimerAppMobile16 = ValueJsonString(dic: dic, key: "DisclaimerAppMobile16")
    }}
