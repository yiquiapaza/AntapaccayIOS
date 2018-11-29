//
//  Llegada.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 11/29/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import Foundation
class Llegada {
    private var id: String
    private var idTransporte :String
    private var fechaOperacion : Int
    private var tipoOperacion: String
    private var usuarioOperacion: String
    private var ultimaOperacion : Bool
    private var codigoPuntoControl :String
    private var nombrePuntoControl : String
    private var RowVersion: String
    init() {
        self.id = VACIO
        self.idTransporte = VACIO
        self.fechaOperacion = 0
        self.tipoOperacion = VACIO
        self.usuarioOperacion = VACIO
        self.ultimaOperacion = false
        self.codigoPuntoControl = VACIO
        self.nombrePuntoControl = VACIO
        self.RowVersion = VACIO
    }
    
    func setId(id : String) -> Void {
        self.id = id
    }
    func getId() -> String {
        return self.id
    }
    
    func setIdTransporte(idTransporte: String) -> Void {
        self.idTransporte = idTransporte
    }
    func getIdTransporte() -> String {
        return self.idTransporte
    }
    
    func setFechaOperacion(fechaOperacion:Int) -> Void {
        self.fechaOperacion = fechaOperacion
    }
    func getFechaOperacion() -> Int {
        return self.fechaOperacion
    }
    
    func setTipoOperacion(tipoOperacion: String) -> Void {
        self.tipoOperacion = tipoOperacion
    }
    func getTipoOperacion() -> String {
        return self.tipoOperacion
    }
    
    func setUsuarioOperacion(usuarioOperacion : String) -> Void {
        self.usuarioOperacion = usuarioOperacion
    }
    func getUsuarioOperacion() -> String {
        return self.usuarioOperacion
    }
    
    func setUltimaOperacion(ultimaOperacion: Bool) -> Void {
        self.ultimaOperacion = ultimaOperacion
    }
    func getUltimaOperacion() -> Bool {
        return self.ultimaOperacion
    }
    
    func setCodigoPuntoControl(codigoPuntoControl:String) -> Void {
        self.codigoPuntoControl = codigoPuntoControl
    }
    func getCodigoPuntoControl() -> String {
        return self.codigoPuntoControl
    }
    
    func setNombrePuntoControl(nombrePuntoControl:String) -> Void {
        self.nombrePuntoControl = nombrePuntoControl
    }
    func getNombrePuntoControl() -> String {
        return self.nombrePuntoControl
    }
    
    func setRowVersion(RowVersion : String) -> Void {
        self.RowVersion = RowVersion
    }
    func getRowVersion() -> String {
        return self.RowVersion
    }
}
