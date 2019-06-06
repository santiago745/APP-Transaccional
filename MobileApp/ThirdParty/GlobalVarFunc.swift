//
//  GlobalVarFunc.swift
//  MobileApp
//
//  Created by Pedro Alonso Daza B on 9/04/17.
//  Copyright © 2017 Old Mutual. All rights reserved.
//

import Foundation
import UIKit

let DOCCODE = ["C", "E", "L", "M", "N", "P", "R", "T"]
let DOCTEXT = ["Cédula de Ciudadanía", "Cédula de Extranjería", "Carnet Minist Relac Exter", "Nit Persona Natural", "Identificación Tributaria", "Pasaporte", "Registro Civil", "Tarjeta Identidad"]
var TOKEN = ""
func CambioFormatoLetras (SCifra: String, MaxLong:String, MinLong:String) -> String
    
{
    print("\(Int64.max)")
    
    var Cifra:Int64 = 0
    
    let sNumerop = SCifra
    
    if sNumerop != ""
        
    {
        
        let num = sNumerop.replacingOccurrences(of: ".", with: "").replacingOccurrences(of: "'", with: "").replacingOccurrences(of: "$", with: "")
        
        //let num = sNumerop.stringByReplacingOccurrencesOfString(".", withString: "").stringByReplacingOccurrencesOfString("'", withString: "").stringByReplacingOccurrencesOfString("$", withString: "")
        
        if let Lnum = Int64(num)
            
        {
            
            Cifra = Lnum
            
            if Cifra > Int64(MaxLong)!
                
            {
                
           //     Cifra =  Int64(MaxLong)!
                
            }
                
            else if Cifra < Int64(MinLong)!
                
            {
                
                Cifra = Int64(MinLong)!
                
            }
            
        }
            
        else
            
        {
            
            return "0"
            
        }
        
    }
        
    else
        
    {
        
        return "0"
        
    }
    
    if Cifra <= 999
        
    {
        
        return "$\(Cifra)"
        
    }
        
    else if Cifra >= 1000 && Cifra <= 999999
        
    {
        
        let mil = Cifra / 1000
        
        let cen = Cifra - (mil * 1000)
        
        var scen = ""
        
        if "\(cen)".characters.count <= 2
            
        {
            
            
            
            if "\(cen)".characters.count == 1
                
            {
                
                scen = "00\(cen)"
                
            }
                
            else if "\(cen)".characters.count == 2
                
            {
                
                scen = "0\(cen)"
                
            }
            
        }
            
        else
            
        {
            
            scen = "\(cen)"
            
        }
        
        return "$\(mil).\(scen)"
        
    }
        
    else if Cifra >= 1000000 && Cifra <= 999999999999
        
    {
        
        let mill = Cifra / 1000000
        
        let mil = (Cifra - (mill * 1000000)) / 1000
        
        var smil = ""
        
        
        
        var scen = ""
        
        if "\(mil)".characters.count <= 2
            
        {
            
            
            
            if "\(mil)".characters.count == 1
                
            {
                
                smil = "00\(mil)"
                
            }
                
            else if "\(mil)".characters.count == 2
                
            {
                
                smil = "0\(mil)"
                
            }
            
        }
            
        else
            
        {
            
            smil = "\(mil)"
            
        }
        
        let cen = Cifra - Int64("\(mill)\(smil)000")!
        
        if "\(cen)".characters.count <= 2
            
        {
            
            
            
            if "\(cen)".characters.count == 1
                
            {
                
                scen = "00\(cen)"
                
            }
                
            else if "\(cen)".characters.count == 2
                
            {
                
                scen = "0\(cen)"
                
            }
            
        }
            
        else
            
        {
            
            scen = "\(cen)"
            
        }
        
        
        
        return "$\(mill).\(smil).\(scen)"
        
    }
        
    else
        
    {
        
        let milll = Cifra / 1000000000
        
        let mill = (Cifra - (milll * 1000000000)) / 1000000
        
        var smill = ""
        
        var smil = ""
        
        var scen = ""
        
        if "\(mill)".characters.count <= 2
            
        {
            
            
            
            if "\(mill)".characters.count == 1
                
            {
                
                smill = "00\(mill)"
                
            }
                
            else if "\(mill)".characters.count == 2
                
            {
                
                smill = "0\(mill)"
                
            }
            
        }
            
        else
            
        {
            
            smill = "\(mill)"
            
        }
        
        let mil = (Cifra - Int64("\(milll)\(smill)000000")!) / 1000
        
        if "\(mil)".characters.count <= 2
            
        {
            
            print("Contador chars milles: \("\(mil)".characters.count)")
            
            
            
            if "\(mil)".characters.count == 1
                
            {
                
                smil = "00\(mil)"
                
            }
                
            else if "\(mil)".characters.count == 2
                
            {
                
                smil = "0\(mil)"
                
            }
                
            else
                
            {
                
                smil = "707"
                
            }
            
        }
            
        else
            
        {
            
            smil = "\(mil)"
            
        }
        
        let cen = Cifra - Int64("\(milll)\(smill)\(smil)000")!
        
        if "\(cen)".characters.count <= 2
            
        {
            
            if "\(cen)".characters.count == 1
                
            {
                
                scen = "00\(cen)"
                
            }
                
            else if "\(cen)".characters.count == 2
                
            {
                
                scen = "0\(cen)"
                
            }
            
        }
            
        else
            
        {
            
            scen = "\(cen)"
            
        }
        
        return "$\(milll).\(smill).\(smil).\(scen)"
        
    }
    
}

func GetCodeList(ListCode: [String], Descripcion: String, ListaDEscripcion: [String]) -> String
{
    var i = 0
    var code = ""
    for description in ListaDEscripcion
    {
        
        if Descripcion == description
        {
            code = ListCode[i]
            break
        }
        i += 1
    }
    
    return code
}
class GlobalVarFunc: NSObject
{
func SetToken(token:String)
{
    TOKEN = token
}
}

var NUMERODECONTRATO = ""
var PRODUCTOCODECONTRATO = ""
var PLANCODECONTRATO = ""
var WITHDRAWALALLOWED = false

