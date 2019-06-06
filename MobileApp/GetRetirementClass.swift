//
//  GetContenedorClass.swift
//  agregarlistas
//
//  Created by Periferia on 15/11/17.
//  Copyright © 2017 PeriferiaxzvNextU. All rights reserved.
//

import Foundation
import  UIKit

func getContenedor(controller:UIViewController, numeroDeDocumento:String, tipoDeDocument:String, Ok:@escaping (([RetirementObject]) -> Void))
{
    
    let ws = WsArrive()
    ws.getArray(view: controller, Ok: {array in
        
        
        var ArrayObjectsResponse = [RetirementObject]()
        for response in array
        {
            ArrayObjectsResponse.append(RetirementObject(dic: response as! NSDictionary))
        }
        Ok(ArrayObjectsResponse)
    }, Error: {errer in
        let alert = UIAlertController(title: "Apreciado Cliente", message: errer, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        controller.present(alert, animated: true, completion: nil)
    }, todoEndpointt: BASEURL + "/Contracts?docNumber=\(LOCALCEDULA)&docType=\(LOCALTIPOCEDULA)")
}


