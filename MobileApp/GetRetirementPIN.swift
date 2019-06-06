//
//  GetContenedorClass.swift
//  agregarlistas
//
//  Created by El oski on 30/01/18.
//  Copyright © 2018 PeriferiaxzvNextU. All rights reserved.
//

import Foundation
import  UIKit

func GetRetirementPIN(controller:UIViewController, numeroDeDocumento:String, tipoDeDocument:String, Ok:@escaping ((RetirementPinObject) -> Void))
{
    
    let ws = Ws()
    ws.getDictionary(view: controller, Ok: {ObjResponse in
        
        let Tetirement = RetirementPinObject(dic: ObjResponse)

        
        Ok(Tetirement)
    }, Error: {errer in
        let alert = UIAlertController(title: "Apreciado Cliente", message: errer, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        controller.present(alert, animated: true, completion: nil)
    },
todoEndpointt: BASEURL + "/SecurePin?docNumber=\(LOCALCEDULA)&docType=\(LOCALTIPOCEDULA)&ChannelNumber=ytyddf&HostName=Mobile&Channel=4&Country=1")
    
}
