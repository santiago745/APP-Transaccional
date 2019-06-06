//
//  GetRetirementWithdrawalsClass.swift
//  MobileApp
//
//  Created by Periferia on 27/11/17.
//  Copyright © 2017 Old Mutual. All rights reserved.
//


import Foundation
import  UIKit

func PostRetirementPINSend(controller:UIViewController,numcontracts:Int,withdrawalType:String,ChannelNumber:String,UserId:String,CommentsBody:String,ContractNumberBody:String,DestinationTypeBody:Int,FlagsBody:Int,PlanCodeBody:String,ProductCodeBody:String,ValueBody:String,AccountNumberBody:String,AccountTypeBody:Int,BankIdBody:String,BankNameBody:String,PIN:String, Ok:@escaping ((RetirementPinSendObject) -> Void))
{
    
    let paramsbodyBackAccount:NSDictionary = [
        "AccountNumber":AccountNumberBody,
        "AccountType": AccountTypeBody,
        "BankId": BankIdBody,
        "BankName": BankNameBody
    ]
    
    let ParamsBody:NSDictionary = [
        
        "Comments": CommentsBody,
        "ContractNumber": numcontracts,
        "DestinationType": 1,
        "DocNumber": LOCALCEDULA,
        "DocType": LOCALTIPOCEDULA,
        "Flags": 0,
        "PlanCode": PlanCodeBody,
        "ProductCode": ProductCodeBody,
        "Value": ValueBody,
        "BankAccountInfo":paramsbodyBackAccount
    ]
    
    let ws = Ws()
    ws.postUrlParams(view: controller, Ok: {ObjResponse in
        
        
        let Tetirement = RetirementPinSendObject(dic: ObjResponse)
        
        
        Ok(Tetirement)
        
    },Error: {errer in
        let alert = UIAlertController(title: "Apreciado Cliente", message: errer, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        controller.present(alert, animated: true, completion: nil)
    },
        todoEndpointt: BASEURL + "/Withdrawals?withdrawalType=\(withdrawalType)&contract=\(ContractNumberBody)&pin=\(PIN)&Channel=4&ChannelNumber=\(ChannelNumber)&UserId=\(UserId)",
        
        params: ParamsBody
    )
    
}
