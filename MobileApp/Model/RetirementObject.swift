//
//  ContenedorSwift.swift
//  agregarlistas
//
//  Created by Periferia on 15/11/17.
//  Copyright © 2017 PeriferiaxzvNextU. All rights reserved.
//

import Foundation

public class RetirementObject:NSObject{

    var Key = ""
    var Caption = ""
    var TotalBalance = ""
    var Products = [RetirementProductsObject]()
    
    
    
    init (dic:NSDictionary)
    {
        Key = ValueJsonString(dic: dic, key: "Key")
        Caption = ValueJsonString(dic: dic, key: "Caption")
        TotalBalance = ValueJsonString(dic: dic, key: "TotalBalance")
        
        if let arrayProducts = ValueJsonArray(dic: dic, key: "Products"){
            
            for productsdic in arrayProducts{
                
                if let dicproducts = productsdic as? NSDictionary{
                    
                    Products.append(RetirementProductsObject(dic : dicproducts))
                }
                
                
            }
            
        }

    }}

