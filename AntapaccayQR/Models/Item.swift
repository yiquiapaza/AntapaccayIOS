//
//  Item.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 11/6/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import Foundation

class Item {
    private var id:String
    private var rowVersion:String
    private var numeroItem: String
    private var descripcion:String
    private var cantidad: String
    private var idOrdenDetalle: String
    private var idProveedor: String
    private var transportista : String
    private var verificadoAlmacen: Bool
    
    init() {
        self.id = VACIO
        self.numeroItem = VACIO
        self.rowVersion = VACIO
        self.descripcion = VACIO
        self.cantidad = VACIO
        self.idOrdenDetalle = VACIO
        self.idProveedor = VACIO
        self.transportista = VACIO
        self.verificadoAlmacen = false
    }
    
    init(id:String, rowVersion:String, numeroItem:String, descripcion:String, cantidad:String, idOrdenDetalle:String, idProveedor: String, transportista: String, verificadoAlmacen:Bool) {
        self.id = id
        self.numeroItem = numeroItem
        self.rowVersion = rowVersion
        self.descripcion = descripcion
        self.cantidad = cantidad
        self.idOrdenDetalle = idOrdenDetalle
        self.idProveedor = idProveedor
        self.transportista = transportista
        self.verificadoAlmacen = verificadoAlmacen
    }
    
    func setId(id:String) -> Void {
        self.id = id
    }
    func getId() -> String {
        return self.id
    }
    
    func setNumeroItem(numeroItem:String) -> Void {
        self.numeroItem = numeroItem
    }
    func getNumeroItem() -> String {
        return self.numeroItem
    }
    
    func setRowVersion(rowVersion: String) -> Void {
        self.rowVersion = rowVersion
    }
    func getRowVersion() -> String {
        return self.rowVersion
    }
    
    func setDescripcion(descripcion: String) -> Void {
        self.descripcion = descripcion
    }
    func getDescripcion() -> String {
        return self.descripcion
    }
    
    func setCantida(cantidad: String) -> Void {
        self.cantidad = cantidad
    }
    func getCantidad() -> String {
        return self.cantidad
    }
    
    func setIdOrdenDetalle(idOrdenDetalle: String) -> Void {
        self.idOrdenDetalle = idOrdenDetalle
    }
    func getIdOrdenDetalle() -> String {
        return idOrdenDetalle
    }
    
    func setIdProveedor(idProveedor:String) -> Void {
        self.idProveedor = idProveedor
    }
    func getIdProveedor() -> String {
        return self.idProveedor
    }
    
    func setTransportista(transportista: String) -> Void {
        self.transportista = transportista
    }
    func getTransportista() -> String {
        return self.transportista
    }
 
    func setVerificadoAlmacen(verificadoAlmacen: Bool) -> Void {
        self.verificadoAlmacen = verificadoAlmacen
    }
    func getVerificadoAlmacen() -> Bool {
        return self.verificadoAlmacen
    }
    
}
