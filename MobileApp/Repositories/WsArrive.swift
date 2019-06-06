//
//  WsArrive.swift
//  MobileApp
//
//  Created by Periferia on 8/02/18.
//  Copyright © 2018 Old Mutual. All rights reserved.
//

import Foundation
import UIKit

class WsArrive : NSObject
{
    func getArray(view: UIViewController, Ok: @escaping ((NSArray) -> Void),Error : @escaping((String) -> Void), todoEndpointt:(String))
    {
        let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
        let Auth_header    = [ "Authorization" : "Basic \(TOKEN)" ]
        //    let Auth_header    = [ "Authorization" : "Basic eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9hdXRoZW50aWNhdGlvbiI6IlRydWUiLCJuYW1laWQiOiIxMTIyMzMwMDAiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3VzZXJkYXRhIjoiQzExMjIzMzAwMCIsInVuaXF1ZV9uYW1lIjoiQ0xJRU5URTEgUFJVRUJBUzEiLCJlbWFpbCI6Im9tb3V0c3RlZmFuaW5pNUBvbGRtdXR1YWwuY29tLmNvIiwiY2VydHRodW1icHJpbnQiOiI1YjdkYTFhNTUzNGNjOTFhIiwiY2VydHNlcmlhbG51bWJlciI6IjIzNjQ3ODI0IiwiaXNzIjoic2VsZiIsImF1ZCI6Imh0dHA6Ly93d3cub2xkbXV0dWFsLmNvbS5jbyIsImV4cCI6MTUxMDg0NDQwMiwibmJmIjoxNTEwODQzMjAyfQ.oS13R418dCjzqivcgb2WjGQBje9U3Vd4wrZJPBd3SZ8" ]
        
        //   let todoEndpoint: String = "https://190.216.128.52/OM.MobileApi.Public/api/Agents?docNumber=112233000&docType=C"
        //   let todoEndpoint: String = "https://190.216.128.52/OM.MobileApi.Public/api/Contracts?docNumber=70720&docType=E"
        let vcspinner = storyboard.instantiateViewController(withIdentifier: "SpinnerController") as! SpinnerController
        vcspinner.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        view.present(vcspinner, animated: true)
        let todoEndpoint = todoEndpointt
        request(todoEndpoint, headers: Auth_header)
            .responseData { response in
                //             let answerArray = response.response?.statusCode
 //               vcspinner.hideSpinner()
                if response.response?.statusCode == 200{
                    
                    if let data = response.data{
                        
                        let str = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                        var err: NSError?
                        var json:NSArray?// = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves) as? NSDictionary
                        
                        
                        
                        do {
                            json = try JSONSerialization.jsonObject(with: data, options: []) as! NSArray
                            // use anyObj here
                        } catch {
                            //Error( "\(error)")
                            return
                                print("json error: \(error)")
                        }
                        
                        print("error: \(json)")
                        
                        
                        DispatchQueue.global(qos: .userInitiated).async {
                            
                            // Bounce back to the main thread to update the UI
                            DispatchQueue.main.async {
                                Ok(json!)
                                
                            }
                        }}
                    else {
                        
                        let status = response.response?.statusCode
                        
                    }
                    vcspinner.hideSpinner()
                }
                else
                {
                    if let ensaje = response.result.error
                    {
                        Error(ensaje.localizedDescription)
                    }
                    else
                    {
                        Error("En este momento estamos presentando problemas de comunicación. Por favor intente más tarde.")
                        vcspinner.hideSpinner()
                    }
                    
                }
                
                
                
        }
        
        
        
        
    }
}
