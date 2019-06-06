//
//  GetUtilObjects.swift
//  MobileApp
//
//  Created by Pedro A. Daza Balaguera on 3/04/17.
//  Copyright © 2017 Old Mutual. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import MapKit

public class GetUtilObjects : NSObject
{
    func GetRoteDirections(LocationStart: CLLocationCoordinate2D, LocationEnd: CLLocationCoordinate2D)
    {
        let BASEURL = "https://maps.googleapis.com/maps/api/directions/json?origin=\(LocationStart.latitude),\(LocationStart.longitude)&destination=\(LocationEnd.latitude),\(LocationEnd.longitude)&sensor=false&mode=driving&alternatives=true&key=AIzaSyDzO6dLNxnCGkEd5-wiecx4TmgT0F9n7xk"
        //import Alamofire
        
        /*let geodesic = MKGeodesicPolyline(coordinates: LocationStart, count: 2)
        map.add(geodesic)*/
        
        request(BASEURL)
            .responseData { response in

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
                    
                    print("json: \(json)")
                    
                    
                    DispatchQueue.global(qos: .userInitiated).async {
                        
                        // Bounce back to the main thread to update the UI
                        DispatchQueue.main.async {

                            let UserInfo = ["SDEcode": self.GetDrawPath(dic: json!)]
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "DrawRute"), object: nil, userInfo: UserInfo)
                        }
                    }
                    
                }
        }
    }
    
    func GetDrawPath(dic:NSDictionary) -> NSString
    {

        
        let RouteArray = ValueJsonArray(dic: dic, key: "routes");
        if RouteArray!.count >= 1
        {
        if let Routes = RouteArray?[0]
        {
            let overviewPolylines = ValueJsonDiccionario(dic: Routes as! NSDictionary, key: "overview_polyline")
            
            let encodedString = ValueJsonString(dic: overviewPolylines!, key: "points")

            
            return encodedString! as NSString;
            
            
        }
        else
        {
            return "";
        }
        }
        else
        {
            return "";
        }
        
    }
    
    func GetContrato(number:String, productCode:String, planCode:String, WithdrawalsAllowed:Bool)
    {
        NUMERODECONTRATO = number
        PRODUCTOCODECONTRATO = productCode
        PLANCODECONTRATO = planCode
        WITHDRAWALALLOWED = WithdrawalsAllowed
        
    }
    
    
 
}
