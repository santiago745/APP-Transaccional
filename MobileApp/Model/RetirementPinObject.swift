//
//  ContenedorSwift.swift
//  agregarlistas
//
//  Created by Periferia on 15/11/17.
//  Copyright © 2017 PeriferiaxzvNextU. All rights reserved.
//

import Foundation

public class RetirementPinObject:NSObject{
    
    var PinResult = ""
    var Description = ""

    
    
    
    init (dic:NSDictionary)
    {
        PinResult = ValueJsonString(dic: dic, key: "PinResult")
        Description = ValueJsonString(dic: dic, key: "Description")
        
    }}
