//
//  ControlObject.swift
//  Mi Aguila Ya
//
//  Created by MacUser on 26/04/16.
//  Copyright © 2016 Anthony Pauriche. All rights reserved.
//

import UIKit

func ValueJsonString (dic:NSDictionary, key:String) -> String!
{
    //print("JSON EXPUESTO: \(dic)")
    //NSLog("JSON EXPUESTO: %@ ", "\(dic)")
    if dic.object(forKey: key) == nil || dic.object(forKey: key) is NSNull
    {
        print("NO EXISTE ATRIBUTO: \(key) TIPO: String")
        NSLog("NO EXISTE ATRIBUTO: %@  TIPO: String", "\(key)")
        return ""
        
    }
    else if dic.object(forKey: key) is String
    {
        let objeto = dic.object(forKey: key)
        return dic.object(forKey: key) as! String
    }
    else
    {
        print("NO ATRIBUTO: \(key) TIPO: String")
        NSLog("NO ATRIBUTO: %@  TIPO: String", "\(key)")
        return ""
    }
    
}

func ValueJsonInt (dic:NSDictionary, key:String) -> Int!
{
    //print("JSON EXPUESTO: \(dic)")
    //NSLog("JSON EXPUESTO: %@ ", "\(dic)")
    if dic.object(forKey: key) == nil || dic.object(forKey: key) is NSNull
    {
        print("NO EXISTE ATRIBUTO: \(key) TIPO: Int")
        NSLog("NO EXISTE ATRIBUTO: %@  TIPO: Int", "\(key)")
        return 0
        
    }
    else if dic.object(forKey: key) is Int
    {
        let objeto = dic.object(forKey: key)
        return dic.object(forKey: key) as! Int
    }
    else
    {
        print("NO ATRIBUTO: \(key) TIPO: Int")
        NSLog("NO ATRIBUTO: %@  TIPO: Int", "\(key)")
        return 0
    }
    
}

func ValueJsonInt64 (dic:NSDictionary, key:String) -> UInt64!
{
    //print("JSON EXPUESTO: \(dic)")
    //NSLog("JSON EXPUESTO: %@ ", "\(dic)")
    if dic.object(forKey: key) == nil || dic.object(forKey: key) is NSNull
    {
        print("NO EXISTE ATRIBUTO: \(key) TIPO: UInt64")
        NSLog("NO EXISTE ATRIBUTO: %@  TIPO: UInt64", "\(key)")
        return 0
        
    }
    else if dic.object(forKey: key) is UInt64
    {
        let objeto = dic.object(forKey: key)
        return dic.object(forKey: key) as! UInt64
    }
    else
    {
        print("NO ATRIBUTO: \(key) TIPO: UInt64")
        NSLog("NO ATRIBUTO: %@  TIPO: UInt64", "\(key)")
        return 0
    }
    
}

func ValueJsonCGFloat (dic:NSDictionary, key:String) -> CGFloat!
{
    //print("JSON EXPUESTO: \(dic)")
    //NSLog("JSON EXPUESTO: %@ ", "\(dic)")
    if dic.object(forKey: key) == nil || dic.object(forKey: key) is NSNull
    {
        print("NO EXISTE ATRIBUTO: \(key) TIPO: CGFloat")
        NSLog("NO EXISTE ATRIBUTO: %@  TIPO: CGFloat", "\(key)")
        return 0.0
        
    }
    else if dic.object(forKey: key) is CGFloat
    {
        let objeto = dic.object(forKey: key)
        return dic.object(forKey: key) as! CGFloat
    }
    else
    {
        print("NO ATRIBUTO: \(key) TIPO: CGFloat")
        NSLog("NO ATRIBUTO: %@  TIPO: CGFloat", "\(key)")
        return 0.0
    }
    
}

func ValueJsonDouble (dic:NSDictionary, key:String) -> Double!
{
    
    //print("JSON EXPUESTO: \(dic)")
    //NSLog("JSON EXPUESTO: %@ ", "\(dic)")
    if dic.object(forKey: key) == nil || dic.object(forKey: key) is NSNull
    {
        print("NO EXISTE ATRIBUTO: \(key) TIPO: Double")
        NSLog("NO EXISTE ATRIBUTO: %@  TIPO: Double", "\(key)")
        return 0.0
        
    }
    else if dic.object(forKey: key) is Double
    {
        let objeto = dic.object(forKey: key)
        return dic.object(forKey: key) as! Double
    }
    else
    {
        print("NO ATRIBUTO: \(key) TIPO: Double")
        NSLog("NO ATRIBUTO: %@  TIPO: Double", "\(key)")
        return 0.0
    }
    
}

func ValueJsonBool (dic:NSDictionary, key:String) -> Bool!
{
    
    //print("JSON EXPUESTO: \(dic)")
    //NSLog("JSON EXPUESTO: %@ ", "\(dic)")
    if dic.object(forKey: key) == nil || dic.object(forKey: key) is NSNull
    {
        print("NO EXISTE ATRIBUTO: \(key) TIPO: Bool")
        NSLog("NO EXISTE ATRIBUTO: %@  TIPO: Bool", "\(key)")
        return false
        
    }
    else if dic.object(forKey: key) is Bool
    {
        let objeto = dic.object(forKey: key)
        return dic.object(forKey: key) as! Bool
    }
    else
    {
        print("NO ATRIBUTO: \(key) TIPO: Bool")
        NSLog("NO ATRIBUTO: %@  TIPO: Bool", "\(key)")
        return false
    }
    
}

func ValueJsonDiccionario (dic:NSDictionary, key:String) -> NSDictionary!
{
    
    //print("JSON EXPUESTO: \(dic)")
    //NSLog("JSON EXPUESTO: %@ ", "\(dic)")
    if dic.object(forKey: key) == nil || dic.object(forKey: key) is NSNull
    {
        print("NO EXISTE ATRIBUTO: \(key) TIPO: NSDictionary")
        NSLog("NO EXISTE ATRIBUTO: %@  TIPO: NSDictionary", "\(key)")
        return nil
        
    }
    else if dic.object(forKey: key) is NSDictionary
    {
        let objeto = dic.object(forKey: key)
        return dic.object(forKey: key) as! NSDictionary
    }
    else
    {
        print("NO ATRIBUTO: \(key) TIPO: NSDictionary")
        NSLog("NO ATRIBUTO: %@  TIPO: NSDictionary", "\(key)")
        return nil
    }
    
}

func ValueJsonArray (dic:NSDictionary, key:String) -> NSArray!
{
    
    //print("JSON EXPUESTO: \(dic)")
    //NSLog("JSON EXPUESTO: %@ ", "\(dic)")
    if dic.object(forKey: key) == nil || dic.object(forKey: key) is NSNull
    {
        print("NO EXISTE ATRIBUTO: \(key) TIPO: NSArray")
        NSLog("NO EXISTE ATRIBUTO: %@  TIPO: NSArray", "\(key)")
        return nil
        
    }
    else if dic.object(forKey: key) is NSArray
    {
        let objeto = dic.object(forKey: key)
        return dic.object(forKey: key) as! NSArray
    }
    else
    {
        print("NO ATRIBUTO: \(key) TIPO: NSArray")
        NSLog("NO ATRIBUTO: %@  TIPO: NSArray", "\(key)")
        return nil
    }
    
}

func ValueJsonDate (dic:NSDictionary, key:String) -> NSDate!
{
    
    //print("JSON EXPUESTO: \(dic)")
    //NSLog("JSON EXPUESTO: %@ ", "\(dic)")
    if dic.object(forKey: key) == nil || dic.object(forKey: key) is NSNull
    {
        print("NO EXISTE ATRIBUTO: \(key) TIPO: NSArray")
        NSLog("NO EXISTE ATRIBUTO: %@  TIPO: NSArray", "\(key)")
        return nil
        
    }
    else if dic.object(forKey: key) is NSDate
    {
        let objeto = dic.object(forKey: key)
        return dic.object(forKey: key) as! NSDate
    }
    else
    {
        print("NO ATRIBUTO: \(key) TIPO: NSDate")
        NSLog("NO ATRIBUTO: %@  TIPO: NSDate", "\(key)")
        return nil
    }
    
}

class ControlObject {
    

    
    
    /*func ValueJsonCLLocationDegrees (dic:NSDictionary, key:String) -> CLLocationDegrees!
    {
     
        //print("JSON EXPUESTO: \(dic)")
        //NSLog("JSON EXPUESTO: %@ ", "\(dic)")
        if dic.objectForKey(key) == nil || dic.objectForKey(key) is NSNull
        {
            print("NO EXISTE ATRIBUTO: \(key) TIPO: CLLocationDegrees")
            NSLog("NO EXISTE ATRIBUTO: %@  TIPO: CLLocationDegrees", "\(key)")
            return 0
     
        }
        else if dic.objectForKey(key) is CLLocationDegrees
        {
            let objeto = dic.objectForKey(key)
            return dic.objectForKey(key) as! CLLocationDegrees
        }
        else
        {
            print("NO ATRIBUTO: \(key) TIPO: CLLocationDegrees")
            NSLog("NO ATRIBUTO: %@  TIPO: CLLocationDegrees", "\(key)")
            return 0
        }
        
    }*/
    /*func ValueJsonString (dic:NSDictionary, key:String) -> String!
    {
        //print("JSON EXPUESTO: \(dic)")
        //NSLog("JSON EXPUESTO: %@ ", "\(dic)")
        if dic.objectForKey(key) == nil || dic.objectForKey(key) is NSNull
        {
            print("NO EXISTE ATRIBUTO: \(key) TIPO: String")
            NSLog("NO EXISTE ATRIBUTO: %@  TIPO: String", "\(key)")
            return nil
            
        }
        else if dic.objectForKey(key) is String
        {
            let objeto = dic.objectForKey(key)
            return dic.objectForKey(key) as! String
        }
        else
        {
            print("NO ATRIBUTO: \(key) TIPO: String")
            NSLog("NO ATRIBUTO: %@  TIPO: String", "\(key)")
            return nil
        }
        
    }
    
    func ValueJsonInt (dic:NSDictionary, key:String) -> Int!
    {
        //print("JSON EXPUESTO: \(dic)")
        //NSLog("JSON EXPUESTO: %@ ", "\(dic)")
        if dic.objectForKey(key) == nil || dic.objectForKey(key) is NSNull
        {
            print("NO EXISTE ATRIBUTO: \(key) TIPO: Int")
            NSLog("NO EXISTE ATRIBUTO: %@  TIPO: Int", "\(key)")
            return nil
            
        }
        else if dic.objectForKey(key) is Int
        {
            let objeto = dic.objectForKey(key)
            return dic.objectForKey(key) as! Int
        }
        else
        {
            print("NO ATRIBUTO: \(key) TIPO: Int")
            NSLog("NO ATRIBUTO: %@  TIPO: Int", "\(key)")
            return nil
        }
        
    }
    
    func ValueJsonCGFloat (dic:NSDictionary, key:String) -> CGFloat!
    {
        //print("JSON EXPUESTO: \(dic)")
        //NSLog("JSON EXPUESTO: %@ ", "\(dic)")
        if dic.objectForKey(key) == nil || dic.objectForKey(key) is NSNull
        {
            print("NO EXISTE ATRIBUTO: \(key) TIPO: CGFloat")
            NSLog("NO EXISTE ATRIBUTO: %@  TIPO: CGFloat", "\(key)")
            return nil
            
        }
        else if dic.objectForKey(key) is CGFloat
        {
            let objeto = dic.objectForKey(key)
            return dic.objectForKey(key) as! CGFloat
        }
        else
        {
            print("NO ATRIBUTO: \(key) TIPO: CGFloat")
            NSLog("NO ATRIBUTO: %@  TIPO: CGFloat", "\(key)")
            return nil
        }
        
    }
    
    func ValueJsonDouble (dic:NSDictionary, key:String) -> Double!
    {
        
        //print("JSON EXPUESTO: \(dic)")
        //NSLog("JSON EXPUESTO: %@ ", "\(dic)")
        if dic.objectForKey(key) == nil || dic.objectForKey(key) is NSNull
        {
            print("NO EXISTE ATRIBUTO: \(key) TIPO: Double")
            NSLog("NO EXISTE ATRIBUTO: %@  TIPO: Double", "\(key)")
            return nil
            
        }
        else if dic.objectForKey(key) is Double
        {
            let objeto = dic.objectForKey(key)
            return dic.objectForKey(key) as! Double
        }
        else
        {
            print("NO ATRIBUTO: \(key) TIPO: Double")
            NSLog("NO ATRIBUTO: %@  TIPO: Double", "\(key)")
            return nil
        }
        
    }
    
    func ValueJsonBool (dic:NSDictionary, key:String) -> Bool!
    {
        
        //print("JSON EXPUESTO: \(dic)")
        //NSLog("JSON EXPUESTO: %@ ", "\(dic)")
        if dic.objectForKey(key) == nil || dic.objectForKey(key) is NSNull
        {
            print("NO EXISTE ATRIBUTO: \(key) TIPO: Bool")
            NSLog("NO EXISTE ATRIBUTO: %@  TIPO: Bool", "\(key)")
            return nil
            
        }
        else if dic.objectForKey(key) is Bool
        {
            let objeto = dic.objectForKey(key)
            return dic.objectForKey(key) as! Bool
        }
        else
        {
            print("NO ATRIBUTO: \(key) TIPO: Bool")
            NSLog("NO ATRIBUTO: %@  TIPO: Bool", "\(key)")
            return nil
        }
        
    }
    
    func ValueJsonDiccionario (dic:NSDictionary, key:String) -> NSDictionary!
    {
        
        //print("JSON EXPUESTO: \(dic)")
        //NSLog("JSON EXPUESTO: %@ ", "\(dic)")
        if dic.objectForKey(key) == nil || dic.objectForKey(key) is NSNull
        {
            print("NO EXISTE ATRIBUTO: \(key) TIPO: NSDictionary")
            NSLog("NO EXISTE ATRIBUTO: %@  TIPO: NSDictionary", "\(key)")
            return nil
            
        }
        else if dic.objectForKey(key) is NSDictionary
        {
            let objeto = dic.objectForKey(key)
            return dic.objectForKey(key) as! NSDictionary
        }
        else
        {
            print("NO ATRIBUTO: \(key) TIPO: NSDictionary")
            NSLog("NO ATRIBUTO: %@  TIPO: NSDictionary", "\(key)")
            return nil
        }
        
    }
    
    func ValueJsonArray (dic:NSDictionary, key:String) -> NSArray!
    {
        
        //print("JSON EXPUESTO: \(dic)")
        //NSLog("JSON EXPUESTO: %@ ", "\(dic)")
        if dic.objectForKey(key) == nil || dic.objectForKey(key) is NSNull
        {
            print("NO EXISTE ATRIBUTO: \(key) TIPO: NSArray")
            NSLog("NO EXISTE ATRIBUTO: %@  TIPO: NSArray", "\(key)")
            return nil
            
        }
        else if dic.objectForKey(key) is NSArray
        {
            let objeto = dic.objectForKey(key)
            return dic.objectForKey(key) as! NSArray
        }
        else
        {
            print("NO ATRIBUTO: \(key) TIPO: NSArray")
            NSLog("NO ATRIBUTO: %@  TIPO: NSArray", "\(key)")
            return nil
        }
        
    }
    
    
    func ValueJsonCLLocationDegrees (dic:NSDictionary, key:String) -> CLLocationDegrees!
    {
        
        //print("JSON EXPUESTO: \(dic)")
        //NSLog("JSON EXPUESTO: %@ ", "\(dic)")
        if dic.objectForKey(key) == nil || dic.objectForKey(key) is NSNull
        {
            print("NO EXISTE ATRIBUTO: \(key) TIPO: CLLocationDegrees")
            NSLog("NO EXISTE ATRIBUTO: %@  TIPO: CLLocationDegrees", "\(key)")
            return nil
            
        }
        else if dic.objectForKey(key) is CLLocationDegrees
        {
            let objeto = dic.objectForKey(key)
            return dic.objectForKey(key) as! CLLocationDegrees
        }
        else
        {
            print("NO ATRIBUTO: \(key) TIPO: CLLocationDegrees")
            NSLog("NO ATRIBUTO: %@  TIPO: CLLocationDegrees", "\(key)")
            return nil
        }
        
    }
    func ValidacionTipoObjectCGFloat(Obj:AnyObject) -> CGFloat
    {
        if Obj is String
        {

            if let n = NSNumberFormatter().numberFromString(Obj as! String) {
                return CGFloat(n)
            }
            else
            {
                return 0.0
            }
        }
        else if Obj is Int
        {
            return CGFloat(Obj as! NSNumber)
        }
        else if Obj is Double
        {
            return CGFloat(Obj as! NSNumber)
        }
        else
        {
            return 0.0
        }
    }*/
    
}

