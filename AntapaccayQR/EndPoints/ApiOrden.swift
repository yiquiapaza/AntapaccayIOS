//
//  ApiOrden.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 10/31/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import Foundation

import Alamofire

func ObtenerOrdenDet(_parametros: Orden){
    let parametros: Parameters = [
        "valorOrden": _parametros.valorOrden as Any,
        "tipoOrden": _parametros.tipoOrden as Any,
        "idComprador": _parametros.idComprador as Any,
        "codigoDistrito": _parametros.codigoDistrito as Any,
        "priceCode": _parametros.priceCode as Any
    ]
    Alamofire.request(LIST_ORDEN_DET, method: .post,parameters: parametros, encoding: JSONEncoding.default)
        .responseString(){
            response in
            if let jsonData = response.result.value {
                print("JSON: \(jsonData)")
    }
        
    }
}

