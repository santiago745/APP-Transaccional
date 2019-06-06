//
//  Ws.swift
//  agregarlistas
//
//  Created by Periferia on 15/11/17.
//  Copyright © 2017 PeriferiaxzvNextU. All rights reserved.
//

import Foundation
import UIKit
//import Alamofire

class Ws: NSObject
{
    
    func getDictionary(view: UIViewController, Ok: @escaping ((NSDictionary) -> Void),Error : @escaping((String) -> Void), todoEndpointt:(String))
    {
        
           let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
        
        //    let Auth_header    = [ "Authorization" : "Basic eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9hdXRoZW50aWNhdGlvbiI6IlRydWUiLCJuYW1laWQiOiIxMTIyMzMwMDAiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3VzZXJkYXRhIjoiQzExMjIzMzAwMCIsInVuaXF1ZV9uYW1lIjoiQ0xJRU5URTEgUFJVRUJBUzEiLCJlbWFpbCI6Im9tb3V0c3RlZmFuaW5pNUBvbGRtdXR1YWwuY29tLmNvIiwiY2VydHRodW1icHJpbnQiOiI1YjdkYTFhNTUzNGNjOTFhIiwiY2VydHNlcmlhbG51bWJlciI6IjIzNjQ3ODI0IiwiaXNzIjoic2VsZiIsImF1ZCI6Imh0dHA6Ly93d3cub2xkbXV0dWFsLmNvbS5jbyIsImV4cCI6MTUxMDg0NDQwMiwibmJmIjoxNTEwODQzMjAyfQ.oS13R418dCjzqivcgb2WjGQBje9U3Vd4wrZJPBd3SZ8" ]
        
        //   let todoEndpoint: String = "https://190.216.128.52/OM.MobileApi.Public/api/Agents?docNumber=112233000&docType=C"
        //   let todoEndpoint: String = "https://190.216.128.52/OM.MobileApi.Public/api/Contracts?docNumber=70720&docType=E"
        let Auth_header    = [ "Authorization" : "Basic \(TOKEN)" ]
        
        let todoEndpoint = todoEndpointt
        request(todoEndpoint, headers: Auth_header)
            .responseData { response in
 //               let answer = response.response?.statusCode
                if response.response?.statusCode == 200{
                    
                    if let data = response.data{
                        
                        let str = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                        var err: NSError?
                        var json:NSDictionary?// = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves) as? NSDictionary
                        
                        do {
                            json = try JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
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
                        
                    }
                    
                }
                
                
                
        }
        
        
        
        
    }
    
    func getString(view: UIViewController, Ok: @escaping ((String) -> Void),Error : @escaping((String) -> Void), todoEndpointt:(String))
    {
        
        let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
        let Auth_header    = [ "Authorization" : "Basic \(TOKEN)" ]
        
        //    let Auth_header    = [ "Authorization" : "Basic eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9hdXRoZW50aWNhdGlvbiI6IlRydWUiLCJuYW1laWQiOiIxMTIyMzMwMDAiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3VzZXJkYXRhIjoiQzExMjIzMzAwMCIsInVuaXF1ZV9uYW1lIjoiQ0xJRU5URTEgUFJVRUJBUzEiLCJlbWFpbCI6Im9tb3V0c3RlZmFuaW5pNUBvbGRtdXR1YWwuY29tLmNvIiwiY2VydHRodW1icHJpbnQiOiI1YjdkYTFhNTUzNGNjOTFhIiwiY2VydHNlcmlhbG51bWJlciI6IjIzNjQ3ODI0IiwiaXNzIjoic2VsZiIsImF1ZCI6Imh0dHA6Ly93d3cub2xkbXV0dWFsLmNvbS5jbyIsImV4cCI6MTUxMDg0NDQwMiwibmJmIjoxNTEwODQzMjAyfQ.oS13R418dCjzqivcgb2WjGQBje9U3Vd4wrZJPBd3SZ8" ]
        
        //   let todoEndpoint: String = "https://190.216.128.52/OM.MobileApi.Public/api/Agents?docNumber=112233000&docType=C"
        //   let todoEndpoint: String = "https://190.216.128.52/OM.MobileApi.Public/api/Contracts?docNumber=70720&docType=E"
               let vcspinnerString = storyboard.instantiateViewController(withIdentifier: "SpinnerController") as! SpinnerController
               vcspinnerString.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                view.navigationController?.present(vcspinnerString, animated: true)
        let todoEndpoint = todoEndpointt
        
        request(todoEndpoint, headers: Auth_header)
            .responseData { response in
                let answer = response.response?.statusCode
                            vcspinnerString.hideSpinner()
                if response.response?.statusCode == 200{
                    
                    if let data = response.data{
                        
                        let str = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                        var err: NSError?
                        var json:NSString?// = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves) as? NSDictionary
                       vcspinnerString.hideSpinner()
                        
                        
                        do {
                            json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
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
                                
                                
                                Ok(str as! String)
                                

                            }
                        }}
                    else {
                        
                        let status = response.response?.statusCode
                        vcspinnerString.hideSpinner()
                    }
                    //
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
                    }
                    
                }
                
                
                
        }
        
        
        
        
    }
    func postUrlParams (view: UIViewController, Ok: @escaping ((NSDictionary) -> Void),Error : @escaping((String) -> Void), todoEndpointt:(String),params:NSDictionary)
        
    {
        let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
        
        let vcspinnerString = storyboard.instantiateViewController(withIdentifier: "SpinnerController") as! SpinnerController
        vcspinnerString.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        view.navigationController?.present(vcspinnerString, animated: true)
        print("Parametros: \(params)")
        
                let Auth_header    = [ "Authorization" : "Basic \(TOKEN)" ]
        
        request(todoEndpointt, method: .post, parameters: params as! [String : AnyObject], encoding: URLEncoding.default,headers: Auth_header)
            .responseData {response in
                
                if let err = response.result.error {
                    print("error code: \(err.localizedDescription)")
                    print("error: \(err.localizedDescription)")
                    Error( "En el momento la aplicación no está disponible intente más tarde")
                    
                }
                else
                {
                    
                    if let data = response.data{
                        
                        let str = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                        print("jsonn: \(str)")
                        var err: NSError?
                        var json:NSDictionary?// = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves) as? NSDictionary
                        
                        vcspinnerString.hideSpinner()
                        
                        do {
                            json = try JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
                            // use anyObj here
                        } catch {
                            Error( "\(error)")
                            print("json error: \(error)")
                            return
                        }
                        print("error: \(json)")
                        
                        DispatchQueue.main.async() {
                            
                            if json != nil
                            {
                                Ok(json!)
                            }
                            else
                            {
                                Error("Error de codificacion")
                            }
                            
                        }
                    }
                    
                    
                }
        }
        
    }
    func postUrlParamsNoBody (view: UIViewController, Ok: @escaping ((NSDictionary) -> Void),Error : @escaping((String) -> Void), todoEndpointt:(String),params:NSDictionary)
        
    {
        
            let Auth_header    = [ "Authorization" : "Basic \(TOKEN)" ]
        
        let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
        
        let vcspinnerString = storyboard.instantiateViewController(withIdentifier: "SpinnerController") as! SpinnerController
        vcspinnerString.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        //view.present(vcspinnerString, animated: true)
        
        print("Parametros: \(params)")
        request(todoEndpointt, method: .post, parameters: ["1":"2"], encoding: URLEncoding.default,headers: Auth_header)
            .responseData {response in
                vcspinnerString.hideSpinner()
                if let err = response.result.error {
                    print("error code: \(err.localizedDescription)")
                    print("error: \(err.localizedDescription)")
                    Error( "En el momento la aplicación no está disponible intente más tarde")
                        
                }
                else
                {
                    
                    if let data = response.data{
                        
                        let errorstatus = response.response?.statusCode
                        let str = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                        print("jsonn: \(str)")
                        var err: NSError?
                        var json:NSDictionary?// = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves) as? NSDictionary
                        
                        vcspinnerString.hideSpinner()
                        
                        do {
                            json = try JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
                            // use anyObj here
                        } catch {
                            Error( "\(error)")
                            print("json error: \(error)")
                            return
                        }
                        print("error: \(json)")
                        
                        DispatchQueue.main.async() {
                            
                            if json != nil
                            {
                                Ok(json!)
                            }
                            else
                            {
                                Error("Error de codificacion")
                            }
                            
                        }
                    }
                    else{
                        vcspinnerString.hideSpinner()
                    }
                    
                    
                }
        }
        
    }

}
