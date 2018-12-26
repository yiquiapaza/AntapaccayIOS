//
//  ItemBulto.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 12/26/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import Foundation

class ItemBulsto {
    private var Id: String
    private var idOrden: String
    private var idOrdenDetalle: String
    private var idBulto: String
    private var idProveedor: String
    private var numeroItem: String
    private var descripcion: String
    private var cantidad: Int
    private var discrepancia : String
    private var descripcionDiscrepancia : String
    private var transportista: String
    private var verificadoAlmacen: Bool
    private var numeroWaybill: String
    private var peso: Double
    private var alto: Double
    private var ancho: Double
    private var largo: Double
    private var numeroGuia: String
    private var RowVersion: String
    
    init() {
        self.Id=VACIO
        self.idOrden=VACIO
        self.idOrdenDetalle=VACIO
        self.idBulto=VACIO
        self.idProveedor=VACIO
        self.numeroItem=VACIO
        self.descripcion=VACIO
        self.cantidad = 0
        self.discrepancia = VACIO
        self.descripcionDiscrepancia = VACIO
        self.transportista = VACIO
        self.verificadoAlmacen = false
        self.numeroWaybill = VACIO
        self.peso = 0.0
        self.alto = 0.0
        self.ancho = 0.0
        self.largo = 0.0
        self.numeroGuia = VACIO
        self.RowVersion = VACIO
    }
    
    func setId(Id:String) -> Void {
        self.Id = Id
    }
    func getId() -> String {
        return self.Id
    }
    
    func setIdOrden(idOrden: String) -> Void {
        self.idOrden = idOrden
    }
    func getIdOrden() -> String {
        return self.idOrden
    }
    
    func setIdOrdenDetalle(idOrdenDetalle: String) -> Void {
        self.idOrdenDetalle = idOrdenDetalle
    }
    func getIdOrdenDetalle() -> String {
        return self.idOrdenDetalle
    }
    
    func setIdBulto(idBulto: String) -> Void {
        self.idBulto = idBulto
    }
    func getIdBulto() -> String {
        return self.idBulto
    }
    
    func setIdProveedor(idProveedor: String) -> Void {
        self.idProveedor = idProveedor
    }
    func getIdProveedor() -> String {
        return self.idProveedor
    }
    
    func setNumeroItem(numeroItem: String) -> Void {
        self.numeroItem = numeroItem
    }
    func getNumeroItem() -> String {
        return self.numeroItem
    }
    
    func setDescripcion(descripcion: String) -> Void {
        self.descripcion = descripcion
    }
    func getDescripcion() -> String {
        return self.descripcion
    }
    
    func setCantidad(cantidad: Int) -> Void {
        self.cantidad = cantidad
    }
    func getCantidad() -> Int {
        return self.cantidad
    }
    
    func setDiscrepancia(discrepancia:String) -> Void {
        self.discrepancia = discrepancia
    }
    func getDiscrepancia() -> String {
        return self.discrepancia
    }
    
    func setDescripcionDiscrepancia(descripcionDiscrepancia: String) -> Void {
        self.descripcionDiscrepancia = descripcionDiscrepancia
    }
    func getDescripcionDiscrepancia() -> String {
        return self.descripcionDiscrepancia
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
    
    func setNumeroWaybill(numeroWaybill:String) -> Void {
        self.numeroWaybill = numeroWaybill
    }
    func getNumeroWaybill() -> String {
        return self.numeroWaybill
    }
    
    func setPeso(peso: Double) -> Void {
        self.peso = peso
    }
    func getPeso() -> Double {
        return self.peso
    }
    
    func setAlto(alto: Double) -> Void {
        self.alto = alto
    }
    func getAlto() -> Double {
        return self.alto
    }
    
    func setAncho(ancho : Double) -> Void {
        self.ancho = ancho
    }
    func getAncho() -> Double {
        return self.ancho
    }
    
    func setLargo(largo: Double) -> Void {
        self.largo = largo
    }
    func getLargo() -> Double {
        return self.largo
    }
    
    func setNumeroGuia(numeroGuia:String) -> Void {
        self.numeroGuia = numeroGuia
    }
    func getNumeroGuia() -> String {
        return self.numeroGuia
    }
    
    func setRowVersion(RowVersion:String) -> Void {
        self.RowVersion = RowVersion
    }
    func getRowVersion() -> String {
        return self.RowVersion
    }
    
}
