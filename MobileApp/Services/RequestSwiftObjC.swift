//
//  RequestSwift.swift
//  MobileApp
//
//  Created by Pedro A. Daza Balaguera on 14/03/17.
//  Copyright © 2017 Old Mutual. All rights reserved.
//

import Foundation
import UIKit

var URLForgetPin = ""
var TOKENFORGOTPASSWORD = ""

//Staging
let BASEURL = "https://staging.mobile.oldmutual.com.co/OM.MobileApi.Public/Api"
let BASEURLCERTIFICACION = "https://staging.mobile.oldmutual.com.co/OM.Certifications.Public/api/"

//produccion
//let BASEURL = "https://mobile.oldmutual.com.co/OM.MobileApi.Public/Api"
//let BASEURLCERTIFICACION = "https://www.oldmutual.com.co/Servicios/OM.Certifications.Public/api/"

//produccion nuevo
//let BASEURL = "https://mobile.oldmutual.com.co/OM.MobileApi.Public_v2.0/Api"
//let BASEURLCERTIFICACION = "https://www.oldmutual.com.co/Servicios/OM.Certifications.Public/api/"

class RequestSwiftObjC: NSObject
{

    //import Alamofire
    
    func postCertificadosOffline(view: UIViewController, numeroDocumento:String, tipoDocumento:String, TipoCertificado: String, IpAddress: String)
    {
        
        let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
        let vcspinner = storyboard.instantiateViewController(withIdentifier: "SpinnerController") as! SpinnerController
        vcspinner.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        view.navigationController?.present(vcspinner, animated: true)
        
        
        let center = NotificationCenter.default
        //var alamoFireManager = SessionManager()
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 400 // seconds
        configuration.timeoutIntervalForResource = 400
        var alamoFireManager = SessionManager(configuration: configuration)
        
        let params:[String:String] = ["IpAddress": IpAddress]
        
        let todoEndpoint: String = BASEURLCERTIFICACION + "/Certifications/post?docNumber=\(numeroDocumento)&docType=\(tipoDocumento)&certificationType=\(TipoCertificado)"
        alamoFireManager.request(todoEndpoint, method: .post, parameters: params, encoding: JSONEncoding.default).responseData { response in
            if let error = response.response?.statusCode{
                
                if error != 200
                {
                    vcspinner.hideSpinner()
                    let alert = UIAlertController(title: "Error", message: "Existe un problema en el servicio en este momento. por favor intentelo mas tarde", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.default, handler: nil))
                    view.present(alert, animated: true, completion: nil)
                    
                }
                else
                {
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
                            
                            let resquestResponse = RestauretPinResposeObject(dic: json!)
                            
                            // Bounce back to the main thread to update the UI
                            DispatchQueue.main.async {
                                
                                let BooleanStatus = ValueJsonBool(dic: json!, key: "Success")
                                if (BooleanStatus!)
                                {
                                    let mensaje = ValueJsonString(dic: json!, key: "Message")
                                    vcspinner.hideSpinner()
                                    let alert = UIAlertController(title: "Información", message: mensaje
                                        , preferredStyle: UIAlertControllerStyle.alert)
                                    alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.default, handler: {(_ action: UIAlertAction) -> Void in
                                        let vc = view.storyboard?.instantiateViewController(withIdentifier: "loginViewControllerIpad")
                                        view.show(vc!, sender: view)
                                        
                                    }))
                                    view.present(alert, animated: true, completion: nil)
                                }
                                else
                                    
                                {
                                    let mensaje = ValueJsonString(dic: json!, key: "Message")
                                    vcspinner.hideSpinner()
                                    let alert = UIAlertController(title: "Apreciado Cliente", message: mensaje, preferredStyle: UIAlertControllerStyle.alert)
                                    alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.default, handler: nil))
                                    view.present(alert, animated: true, completion: nil)
                                }
                            }
                        }
                        
                    }
                }
                
            }
        }
        
    }
    
    func getDataLocations(view: UIViewController)
    {

        let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
        let vcspinner = storyboard.instantiateViewController(withIdentifier: "SpinnerController") as! SpinnerController
       // vcspinner.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
       // view.navigationController?.present(vcspinner, animated: true)
        

        
        
        let todoEndpoint: String = BASEURL + "/Branch"
        request(todoEndpoint)
            .responseData { response in
                vcspinner.hideSpinner()
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
                               // vcspinner.hideSpinner()
                                LOCATIONS = [Locations]()
                                var i = 0;
                                for dic in json!
                                {
                                    
                                    LOCATIONS.append(Locations.init(dic: dic as! NSDictionary))
                                    i = i + 1
                                }
                            }
                        }

                    }
        }

        
                
        
    }
    
    func getAgentes(view: UIViewController, Ok: @escaping (([AgenteResponseObject]) -> Void))
    {
        
        let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
        let vcspinner = storyboard.instantiateViewController(withIdentifier: "SpinnerController") as! SpinnerController
        vcspinner.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        view.navigationController?.present(vcspinner, animated: true)
        
        
        let Auth_header    = [ "Authorization" : "Basic \(TOKEN)" ]

        let todoEndpoint: String = BASEURL + "/Agents?docNumber=\(LOCALCEDULA)&docType=\(LOCALTIPOCEDULA)"
        request(todoEndpoint, headers: Auth_header)
            .responseData { response in
                vcspinner.hideSpinner()
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
                            vcspinner.hideSpinner()
                            var ArrayObjectsResponse = [AgenteResponseObject]()
                            for response in json!
                            {
                                ArrayObjectsResponse.append(AgenteResponseObject(dic: response as! NSDictionary))
                            }
                            
                            Ok(ArrayObjectsResponse)
                        }
                    }
                    
                }
        }
        
        
        
        
    }
    
    func GETForgetPassword(view:UIViewController, DocType:NSString, DocNumber:NSString)
        
    {
        
        let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
        let vcspinner = storyboard.instantiateViewController(withIdentifier: "SpinnerController") as! SpinnerController
        vcspinner.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        view.navigationController?.present(vcspinner, animated: true)
        
        let RequesPass: String = BASEURL + "/Password?docNumber=\(DocNumber)&docType=\(DocType)"
        let todoEndpoint: String = BASEURL + "/SecurePin?docNumber=\(DocNumber)&docType=\(DocType)&ChannelNumber=1.2.3.4&HostName=Mobile&Channel=4&Country=1"
        
        print("Doc: \(RequesPass)")
        
        request(RequesPass)
            .responseData { response in
                if let error = response.response?.statusCode{
                    
                    if error != 200
                    {
                        vcspinner.hideSpinnerCompletion(Ok :{
                        
                            let alert = UIAlertController(title: "Apreciado Cliente", message: "Existe un problema en el servicio en este momento. por favor intentelo mas tarde", preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.default, handler: nil))
                            view.present(alert, animated: true, completion: nil)
                        
                        
                        })
                        
                        
                    }
                    else
                    {
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
                                    let BooleanStatus = ValueJsonBool(dic: json!, key: "Status")
                                    if (!BooleanStatus!)
                                    {
                                        vcspinner.hideSpinnerCompletion(Ok :{
                                        let alert = UIAlertController(title: "Apreciado Cliente", message: ValueJsonString(dic: json!, key: "Message"), preferredStyle: UIAlertControllerStyle.alert)
                                        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.default, handler: nil))
                                        view.present(alert, animated: true, completion: nil)
                                        })
                                        
                                        
                                        
                                    }
                                    else
                                    {
                                        URLForgetPin = todoEndpoint
                                        TOKENFORGOTPASSWORD = ValueJsonString(dic: json!, key: "Message")
                                        vcspinner.hideSpinnerCompletion(Ok :{
                                        var storyboard = UIStoryboard(name: "Authentication", bundle: nil)
                                        if UIDevice.current.userInterfaceIdiom == .pad {
                                            storyboard = UIStoryboard(name: "AuthenticationIpad", bundle: nil)
                                        }
                                        let vc = storyboard.instantiateViewController(withIdentifier: "RestauretPaswordPinController") as! RestauretPaswordPinController
                                        view.navigationController?.pushViewController(vc, animated: true)
                                        })
                                    }
                                }
                            }
                            
                        }
                    }
                    
                    
                    
                }
        }
        
        
        
        
        
        
        
    }
    
    func GETForgetPasswordPin(view:UIViewController, DocType:NSString, DocNumber:NSString)
        
    {

        let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
        let vcspinner = storyboard.instantiateViewController(withIdentifier: "SpinnerController") as! SpinnerController
        vcspinner.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        view.navigationController?.present(vcspinner, animated: true)
        
        let RequesPass: String = BASEURL + "/Password?docNumber=\(DocNumber)&docType=\(DocType)"
        let todoEndpoint: String = BASEURL + "/SecurePin?docNumber=\(DocNumber)&docType=\(DocType)&ChannelNumber=1.2.3.4&HostName=Mobile&Channel=4&Country=1"

        print("Doc: \(RequesPass)")
        
        request(RequesPass)
            .responseData { response in
                if let error = response.response?.statusCode{
                    
                    if error != 200
                    {
                        vcspinner.hideSpinner()
                        let alert = UIAlertController(title: "Apreciado Cliente", message: "Existe un problema en el servicio en este momento. por favor intentelo mas tarde", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.default, handler: nil))
                        view.present(alert, animated: true, completion: nil)
                        
                    }
                    else
                    {
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
                                     let BooleanStatus = ValueJsonBool(dic: json!, key: "Status")
                                    if (BooleanStatus!)
                                    {
                                        TOKENFORGOTPASSWORD = ValueJsonString(dic: json!, key: "Message")
                                        URLForgetPin = todoEndpoint
                                        print("Doc: \(todoEndpoint)")
                                        
                                        request(todoEndpoint)
                                            .responseData { response in
                                                if let error = response.response?.statusCode{
                                                    
                                                    if error != 200
                                                    {
                                                        vcspinner.hideSpinner()
                                                        let alert = UIAlertController(title: "Apreciado Cliente", message: "Existe un problema en el servicio en este momento. por favor intentelo mas tarde", preferredStyle: UIAlertControllerStyle.alert)
                                                        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.default, handler: nil))
                                                        view.present(alert, animated: true, completion: nil)
                                                        
                                                    }
                                                    else
                                                    {
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
                                                                    let resquestResponse = RestauretPinResposeObject(dic: json!)
                                                                    vcspinner.hideSpinner()
                                                                    let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
                                                                    let vc = storyboard.instantiateViewController(withIdentifier: "RestauretPaswordPinController") as! RestauretPaswordPinController
                                                                    vc.rest = resquestResponse
                                                                    view.navigationController?.pushViewController(vc, animated: true)
                                                                }
                                                            }
                                                            
                                                        }
                                                    }
                                                    
                                                    
                                                    
                                                }
                                        }
                                       
                                    
                                   
                                    }
                                    else
                                    {
                                        vcspinner.hideSpinner()
                                        let alert = UIAlertController(title: "Apreciado Cliente", message: "Existe un problema en el servicio en este momento. por favor intentelo mas tarde", preferredStyle: UIAlertControllerStyle.alert)
                                        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.default, handler: nil))
                                        view.present(alert, animated: true, completion: nil)
                                    }
                                }
                            }
                            
                        }
                    }
                    
                    
                    
                }
        }
        
        

        
        
        
        
    }
    
    func GETForgetPasswordPinConMensaje(view:UIViewController)
    {
        let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
        let vcspinner = storyboard.instantiateViewController(withIdentifier: "SpinnerController") as! SpinnerController
        vcspinner.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        view.navigationController?.present(vcspinner, animated: true)
        
        let todoEndpoint: String = URLForgetPin
        
        URLForgetPin = todoEndpoint
        print("Doc: \(todoEndpoint)")
        
        request(todoEndpoint)
            .responseData { response in
                if let error = response.response?.statusCode{
                    
                    if error != 200
                    {
                        vcspinner.hideSpinner()
                        let alert = UIAlertController(title: "Apreciado Cliente", message: "Existe un problema en el servicio en este momento. por favor intentelo mas tarde", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.default, handler: nil))
                        view.present(alert, animated: true, completion: nil)
                        
                    }
                    else
                    {
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
                                
                                let resquestResponse = RestauretPinResposeObject(dic: json!)
                                
                                // Bounce back to the main thread to update the UI
                                DispatchQueue.main.async {
                                    vcspinner.hideSpinner()
                                    let alert = UIAlertController(title: "Información", message: "Se ha enviado un nuevo pin sms", preferredStyle: UIAlertControllerStyle.alert)
                                    alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.default, handler: nil))
                                    view.present(alert, animated: true, completion: nil)
                                }
                            }
                            
                        }
                    }
 
                }
        }
        
        
        
        
    }
    
    func POSTForgetPasswordPin(view:UIViewController, Pin:String)
    {
        let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
        let vcspinner = storyboard.instantiateViewController(withIdentifier: "SpinnerController") as! SpinnerController
        vcspinner.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        view.navigationController?.present(vcspinner, animated: true)
        
        let todoEndpoint: String = URLForgetPin
        
        
        
        
        var request = URLRequest(url: URL(string: todoEndpoint)!)
        request.httpMethod = "POST"
        let postString = "=\(Pin)"
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                vcspinner.hideSpinner()
                let alert = UIAlertController(title: "Apreciado Cliente", message: "Existe un problema en el servicio en este momento. por favor intentelo mas tarde", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.default, handler: nil))
                view.present(alert, animated: true, completion: nil)
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
            
            
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
                    
                    vcspinner.hideSpinner()
                    let rest = RestaurePasswordPinResponseObject(dic: json!)
                    
                    if rest.Response
                    {
                        var storyboard1 = UIStoryboard(name: "Authentication", bundle: nil)
                        
                        if UIDevice.current.userInterfaceIdiom == .pad
                        {
                            storyboard1 = UIStoryboard(name: "AuthenticationIpad", bundle: nil)
                        }

                        let viewController = storyboard1.instantiateViewController(withIdentifier: "ChangePasswordControllerWhithPin") as! ChangePasswordControllerWhithPin
                        
                        view.navigationController!.pushViewController(viewController, animated: true)
                        
                    }
                    else{
                        let alert = UIAlertController(title: "Apreciado Cliente", message: rest.Description, preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.default, handler: nil))
                        view.present(alert, animated: true, completion: nil)
                    }
                    
                    
                }
            }
        }
        task.resume()
        
        
        
        
    }
    
    func POSTForgetPasswordPin(view:UIViewController, Password:UITextField, DeviceNumber:String)
    {
        let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
        let vcspinner = storyboard.instantiateViewController(withIdentifier: "SpinnerController") as! SpinnerController
        vcspinner.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        view.navigationController?.present(vcspinner, animated: true)
        
        let params:[String:String] = ["Token": TOKENFORGOTPASSWORD, "Password":Password.text!,"DeviceNumber":DeviceNumber]
        
        let todoEndpoint: String = BASEURL + "/Password"
        request(todoEndpoint, method: .post, parameters: params, encoding: JSONEncoding.default).responseData { response in
            if let error = response.response?.statusCode{
                
                if error != 200
                {
                    vcspinner.hideSpinner()
                    let alert = UIAlertController(title: "Apreciado Cliente", message: "Existe un problema en el servicio en este momento. por favor intentelo mas tarde", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.default, handler: nil))
                    view.present(alert, animated: true, completion: nil)
                    
                }
                else
                {
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
                            
                            let resquestResponse = RestauretPinResposeObject(dic: json!)
                            
                            // Bounce back to the main thread to update the UI
                            DispatchQueue.main.async {
                                
                                let BooleanStatus = ValueJsonBool(dic: json!, key: "Status")
                                if (BooleanStatus!)
                                {
                                    let mensaje = ValueJsonString(dic: json!, key: "Message")
                                vcspinner.hideSpinner()
                                let alert = UIAlertController(title: "Información", message: "Cambio de contraseña fue exitoso", preferredStyle: UIAlertControllerStyle.alert)
                                alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.default, handler: {(_ action: UIAlertAction) -> Void in
                                    let vc = view.storyboard?.instantiateViewController(withIdentifier: "loginViewControllerIpad")
                                    view.show(vc!, sender: view)
                                    
                                }))
                                view.present(alert, animated: true, completion: nil)
                                }
                                else
                                
                                {
                                    let mensaje = ValueJsonString(dic: json!, key: "Message")
                                    vcspinner.hideSpinner()
                                    let alert = UIAlertController(title: "Apreciado Cliente", message: mensaje, preferredStyle: UIAlertControllerStyle.alert)
                                    alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.default, handler: nil))
                                    view.present(alert, animated: true, completion: nil)
                                }
                            }
                        }
                        
                    }
                }
                
            }
        }
    }
    
    func GetLOCALTIONS() -> [Locations]
    {
        return LOCATIONS
    }
    
    func GetLOCALLOGIN(cedula:String, tipo:String)
    {
        LOCALCEDULA = cedula
        LOCALTIPOCEDULA = tipo
    }
    
    func GetCleanLogin()
    {
        LOCALCEDULA = ""
        LOCALTIPOCEDULA = ""
    }
    
    func GetNumeroDeCedula() -> String
    {
        return LOCALCEDULA
    }

}


extension String: ParameterEncoding {
    
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var request = try urlRequest.asURLRequest()
        request.httpBody = data(using: .utf8, allowLossyConversion: false)
        return request
    }
    
}
let leng = "Esp"
let alMensajeLLenetodosloscampos = (leng == "Esp") ? "Por favor ingrese Tipo y número documento" : "E-mail"
func ShowAlertError(view:UIViewController, Mensaje:String)
{
    let alert = UIAlertController(title: "Error", message: Mensaje, preferredStyle: UIAlertControllerStyle.alert)
    alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.default, handler: nil))
    view.present(alert, animated: true, completion: nil)
}

func ShowAlertInfo(view:UIViewController, Mensaje:String)
{
    let alert = UIAlertController(title: "Informacion", message: Mensaje, preferredStyle: UIAlertControllerStyle.alert)
    alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.default, handler: nil))
    view.present(alert, animated: true, completion: nil)
}
