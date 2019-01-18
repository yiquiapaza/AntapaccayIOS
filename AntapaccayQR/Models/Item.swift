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
    private var numeroGuia: String
    private var creadoDeDiscOnsite: Bool
    private var idDiscrepanciaPadre: String
    private var MAL_USO_API_REST: Int
    
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
        self.numeroGuia = VACIO
        self.creadoDeDiscOnsite = false
        self.idDiscrepanciaPadre = VACIO
        self.MAL_USO_API_REST = 0
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
    
    func setNumeroGuia(numeroGuia: String) -> Void {
        self.numeroGuia = numeroGuia
    }
    func getNumeroGuia() -> String {
        return self.numeroGuia
    }
    
    func setCreadoDeDiscOnsite(creadoDeDiscOnsite: Bool) -> Void {
        self.creadoDeDiscOnsite = creadoDeDiscOnsite
    }
    func getCreadoDeDiscOnsite() -> Bool {
        return self.creadoDeDiscOnsite
    }
    
    func setIdDiscrepanciaPadre(idDiscrepanciaPadre:String) -> Void {
        self.idDiscrepanciaPadre = idDiscrepanciaPadre
    }
    func getIdDiscrepanciaPadre() -> String {
        return self.idDiscrepanciaPadre
    }
    
    func setMAL_USO_REST_API(MAL_USO_REST_API: Int) -> Void {
        self.MAL_USO_API_REST = MAL_USO_REST_API
    }
    func getMAL_USO_REST_API() -> Int {
        return self.MAL_USO_API_REST
    }
}
