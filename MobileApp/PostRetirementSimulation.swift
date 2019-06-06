//
//  GetRetirementWithdrawalsClass.swift
//  MobileApp
//
//  Created by Periferia on 27/11/17.
//  Copyright © 2017 Old Mutual. All rights reserved.
//


import Foundation
import  UIKit

func PostRetirementSimulation(controller:UIViewController,numcontracts:Int,ChannelNumber:String,UserId:String,CommentsBody:String,ContractNumberBody:String,DestinationTypeBody:Int,FlagsBody:Int,PlanCodeBody:String,ProductCodeBody:String,ValueBody:Double,AccountNumberBody:String,AccountTypeBody:Int,BankIdBody:String,BankNameBody:String, Ok:@escaping ((RetirementWithdrawalSimulationObject) -> Void))
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
    "BankAccountInfo": paramsbodyBackAccount
    ]
    
    let ws = Ws()
    ws.postUrlParams(view: controller, Ok: {ObjResponse in
        
        
        let Tetirement = RetirementWithdrawalSimulationObject(dic: ObjResponse)
        
        
        Ok(Tetirement)
        
        },Error: {errer in
        let alert = UIAlertController(title: "Apreciado Cliente", message: errer, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        controller.present(alert, animated: true, completion: nil)
    },
  //      todoEndpointt: BASEURL + "api/Withdrawals?surveyType=\(surveyType)&surveyAnswer=\(surveyAnswer)&docNumber=\(LOCALCEDULA)&docType=\(LOCALTIPOCEDULA)&product=\(product)&contract=\(numcontracts)&channelNumber=1.2.3.4",
        
        todoEndpointt: BASEURL + "/WithdrawalSimulation?contract=\(ContractNumberBody)&Channel=4&ChannelNumber=\(ChannelNumber)&UserId=\(UserId)",
        
    //    todoEndpointt: BASEURL + "/Withdrawals?docNumber=\(LOCALCEDULA)&docType=\(LOCALTIPOCEDULA)&available=\(available)&withdrawalAmount=\(withdrawalAmount)&contract=\(numcontracts)&product=\(product)&planProduct=\(planProduct)&surrenderType=\(isFullSurrender)",
        
        params: ParamsBody
    )

}
