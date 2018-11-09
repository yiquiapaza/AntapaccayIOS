//
//  OrdenDTO.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 11/9/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import Foundation

class OrdenDTO {
    private var tipoOrden:String
    private var valorOrden: String
    init() {
        self.tipoOrden = ""
        self.valorOrden = ""
    }
    func setTipoOrden(tipoOrden: String) -> Void {
        self.tipoOrden = tipoOrden
    }
    func getTipoOrden() -> String {
        return self.tipoOrden
    }
    
    func setValorOrden(valorOrden: String) -> Void {
        self.valorOrden = valorOrden
    }
    func getValorOrden() -> String {
        return self.valorOrden
    }
}
