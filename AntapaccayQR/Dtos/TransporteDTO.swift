//
//  TransporteDTO.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 11/15/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import Foundation

class TransporteDTO {
    private var nombreAlmacen:String
    private var nombreTransportista: String
    private var codigoTransportista: String
    init() {
        self.nombreTransportista = VACIO
        self.nombreAlmacen = VACIO
        self.codigoTransportista = VACIO
    }
    func setNombreAlmacen(nombreAlmacen:String) -> Void {
        self.nombreAlmacen = nombreAlmacen
    }
    func getNombreAlmacen() -> String {
        return self.nombreAlmacen
    }
    
    func setNombreTransportista(nombreTransportista: String) -> Void {
        self.nombreTransportista = nombreTransportista
    }
    func getNombreTransportista() -> String {
        return self.nombreTransportista
    }
    
    func setCodigoTransportista(codigoTransportista:String) -> Void {
        self.codigoTransportista = codigoTransportista
    }
    func getCodigoTransportista() -> String {
        return self.codigoTransportista
    }
}
