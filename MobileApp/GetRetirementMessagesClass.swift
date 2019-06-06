//
//  GetRetirementMessagesClass.swift
//  MobileApp
//
//  Created by Periferia on 21/11/17.
//  Copyright © 2017 Old Mutual. All rights reserved.
//

import Foundation
import  UIKit

func getContenedorMessages(controller:UIViewController, numeroDeDocumento:String, tipoDeDocument:String, Ok:@escaping ((RetirementMessagesObject) -> Void))
{
    
    let ws = Ws()
    ws.getDictionary(view: controller, Ok: {ObjResponse in
        
        
        let Tetirement = RetirementMessagesObject(dic: ObjResponse)

        
        Ok(Tetirement)
    }, Error: {errer in
        let alert = UIAlertController(title: "Apreciado Cliente", message: errer, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        controller.present(alert, animated: true, completion: nil)
    }, //todoEndpointt: BASEURL + "/Contracts?docNumber=\(LOCALCEDULA)&docType=\(LOCALTIPOCEDULA)")
    todoEndpointt: BASEURL + "/Messages")
}
