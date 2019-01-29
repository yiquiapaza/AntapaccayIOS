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
    private var MAL_USO_API_REST_idDiscrepancia : String
    private var MAL_USO_API_REST_idOrdenDetalle : String
    private var MAL_USO_API_REST_numeroItem : String
    private var MAL_USO_API_REST_comentario : String
    private var MAL_USO_API_REST_unidad : String
    private var MAL_USO_API_REST_nombreProveedor : String
    private var MAL_USO_API_REST_cantidadPorRecibir : Int
    private var MAL_USO_API_REST_cantidadRecibida : Int
    
    private var MAL_USO_API_REST_CANTIDAD : Int
    
    
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
        self.MAL_USO_API_REST_idDiscrepancia = VACIO
        self.MAL_USO_API_REST_idOrdenDetalle = VACIO
        self.MAL_USO_API_REST_numeroItem = VACIO
        self.MAL_USO_API_REST_comentario = VACIO
        self.MAL_USO_API_REST_unidad = VACIO
        self.MAL_USO_API_REST_nombreProveedor = VACIO
        self.MAL_USO_API_REST_cantidadPorRecibir = 0
        self.MAL_USO_API_REST_cantidadRecibida = 0
        self.MAL_USO_API_REST_CANTIDAD = 0
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
    
    func setMAL_USO_API_REST_idDiscrepancia(MAL_USO_API_REST_idDiscrepancia:String) -> Void {
        self.MAL_USO_API_REST_idDiscrepancia = MAL_USO_API_REST_idDiscrepancia
    }
    func getMAL_USO_API_REST_idDiscrepancia() -> String {
        return self.MAL_USO_API_REST_idDiscrepancia
    }
    
    func setMAL_USO_API_REST_idOrdenDetalle(MAL_USO_API_REST_idOrdenDetalle : String) -> Void {
        self.MAL_USO_API_REST_idOrdenDetalle = MAL_USO_API_REST_idOrdenDetalle
    }
    func getMAL_USO_API_REST_idOrdenDetalle() -> String {
        return self.MAL_USO_API_REST_idOrdenDetalle
    }
    
    func setMAL_USO_API_REST_numeroItem(MAL_USO_API_REST_numeroItem:String) -> Void {
        self.MAL_USO_API_REST_numeroItem = MAL_USO_API_REST_numeroItem
    }
    func getMAL_USO_API_REST_numeroItem() -> String {
        return self.MAL_USO_API_REST_numeroItem
    }
    
    func setMAL_USO_API_REST_comentario(MAL_USO_API_REST_comentario:String) -> Void {
        self.MAL_USO_API_REST_comentario = MAL_USO_API_REST_comentario
    }
    func getMAL_USO_API_REST_comentario() -> String {
        return self.MAL_USO_API_REST_comentario
    }
    
    func setMAL_USO_API_REST_unidad(MAL_USO_API_REST_unidad: String) -> Void {
        self.MAL_USO_API_REST_unidad = MAL_USO_API_REST_unidad
    }
    func getMAL_USO_API_REST_unidad() -> String {
        return self.MAL_USO_API_REST_unidad
    }
    
    func setMAL_USO_API_REST_cantidadPorRecibir(MAL_USO_API_REST_cantidadPorRecibir:Int) -> Void {
        self.MAL_USO_API_REST_cantidadPorRecibir = MAL_USO_API_REST_cantidadPorRecibir
    }
    func getMAL_USO_API_REST_cantidadPorRecibir() -> Int {
        return self.MAL_USO_API_REST_cantidadPorRecibir
    }
    
    func setMAL_USPO_API_REST_cantidadRecibida(MAL_USP_API_REST_cantidadRecibida: Int) -> Void {
        self.MAL_USO_API_REST_cantidadRecibida = MAL_USP_API_REST_cantidadRecibida
    }
    func getMAL_USO_API_REST_cantidadRecibida() -> Int {
        return self.MAL_USO_API_REST_cantidadRecibida
    }
    
    func setMAL_USO_API_REST_nombreProveedor(MAL_USO_API_REST_nombreProveedor:String) -> Void {
        self.MAL_USO_API_REST_nombreProveedor = MAL_USO_API_REST_nombreProveedor
    }
    func getMAL_USO_API_REST_nombreProveedor() -> String {
        return self.MAL_USO_API_REST_nombreProveedor
    }
}
