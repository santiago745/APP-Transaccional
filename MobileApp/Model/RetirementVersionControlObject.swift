//
//  ContenedorSwift.swift
//  agregarlistas
//
//  Created by Periferia on 15/11/17.
//  Copyright © 2017 PeriferiaxzvNextU. All rights reserved.
//

import Foundation

public class RetirementVersionControlObject:NSObject{
    
    var versionApp = ""
    var Message = ""
    
    
    init (dic:NSDictionary)
    {
        versionApp = ValueJsonString(dic: dic, key: "version")
        Message = ValueJsonString(dic: dic, key: "Message")
    }}
