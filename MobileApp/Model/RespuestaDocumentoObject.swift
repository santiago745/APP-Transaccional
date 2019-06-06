//
//  RespuestaDocumentoObject.swift
//  simulador
//
//  Created by Pedro Daza on 9/05/17.
//  Copyright © 2017 Pedro Daza. All rights reserved.
//

import Foundation
import UIKit

class RespuestaDocumentoObject :NSObject
{
    var Numero = ""
    var Nombre1 = ""
    var Nombre2 = ""
    var Apellido1 = ""
    var Apellido2 = ""
    var FechaNacimiento = ""
    var RH = ""
    
    init (dic:NSDictionary)
    {

        Numero = ValueJsonString(dic:dic, key: "Numero")
        Nombre1 = ValueJsonString(dic:dic, key: "Nombre1")
        Nombre2 = ValueJsonString(dic:dic, key: "Nombre2")
        Apellido1 = ValueJsonString(dic:dic, key: "Apellido1")
        Apellido2 = ValueJsonString(dic:dic, key: "Apellido2")
        FechaNacimiento = ValueJsonString(dic:dic, key: "FechaNacimiento")
        RH = ValueJsonString(dic:dic, key: "RH")

    }
    
}
