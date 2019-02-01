//
//  OrdenDetalle.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 11/2/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import Foundation

class OrdenDetalle {
    private var _id :String
    private var _idProveedor: String
    private var _valorOrden: String
    private var _numeroItem: String
    private var _tipoOrden: String
    private var _distrito: String
    private var _almacen: String
    private var _unidad: String
    private var _partNumber: String
    private var _descripcion: String
    private var _nombreProveedor: String
    private var _cantidadPO: Float
    private var _pr: String
    private var _recibido: Int
    private var _cantidadRecibida: Int
    
    private var _centroCosto : String
    private var _cantidadPorRecibir : Int
    
    private var _numeroGuia: String
    private var _almacenDestino : String
    
    private var _rowVersion: String
    private var _disponibilidad: Int
    
    private var _cantidadX : Int
    private var _cantodadY : Int
    private var _cantidadZ : Int
    
    
    private var cantidadDiscrepancia: Int
    private var creadoDeDiscOnsite: String
    private var idDiscrepanciaPadre: String
    
    init() {
        self._id = ""
        self._idProveedor = ""
        self._valorOrden = ""
        self._numeroItem = ""
        self._tipoOrden = ""
        self._distrito = ""
        self._almacen = ""
        self._unidad = ""
        self._partNumber = ""
        self._descripcion = ""
        self._nombreProveedor = ""
        self._cantidadPO = 0.0
        self._pr = ""
        self._recibido = 0
        self._cantidadRecibida = 0
        self._rowVersion = ""
        self._disponibilidad = 0
        self._centroCosto = VACIO
        self._cantidadPorRecibir = 0
        self._numeroGuia = VACIO
        self._almacenDestino = VACIO
        
        self._cantidadX = 0
        self._cantodadY = 0
        self._cantidadZ = 0
        
        
        self.cantidadDiscrepancia = 0
        self.creadoDeDiscOnsite = VACIO
        self.idDiscrepanciaPadre = VACIO
        
    }
    
    func setId(id:String) -> Void {
        self._id = id
    }
    func getId() -> String {
        return self._id
    }
    
    func setIdProveedor(idProveedor: String) -> Void {
        self._idProveedor = idProveedor
    }
    func getIdProveedor() -> String {
        return self._idProveedor
    }
    
    func setValorOrden(valoProveedor:String) -> Void {
        self._valorOrden = valoProveedor
    }
    func getValorOrden() -> String {
        return self._valorOrden
    }
    
    func setNumeroItem(numeroItem: String) -> Void {
        self._numeroItem = numeroItem
    }
    func getNumeroItem() -> String {
        return self._numeroItem
    }
    
    func setTipoOrden(tipoOrden: String) -> Void {
        self._tipoOrden = tipoOrden
    }
    func getTipoOrden() -> String {
        return self._tipoOrden
    }
    
    func setDistrito(distrito: String) -> Void {
        self._distrito = distrito
    }
    func getDistrito() -> String {
        return self._distrito
    }
    
    func setAlmacen(almacen: String) -> Void {
        self._almacen = almacen
    }
    func getAlmace() -> String {
        return self._almacen
    }
    
    func setUnidad(unidad: String) -> Void {
        self._unidad = unidad
    }
    func getUnidad() -> String {
        return self._unidad
    }
    
    func setPartNumber(partNamber: String) -> Void {
        self._partNumber = partNamber
    }
    func getPartNumber() -> String {
        return self._partNumber
    }
    
    func setDescripcion(descripcion: String) -> Void {
        self._descripcion = descripcion
    }
    
    func getDescripcion() -> String {
        return self._descripcion
    }
    
    func setNombreProoveedor(nombreProveedor: String) -> Void {
        self._nombreProveedor = nombreProveedor
    }
    func getNombreProveedor() -> String {
        return self._nombreProveedor
    }
    
    func setCantidadPO(cantidadPO: Float) -> Void {
        self._cantidadPO = cantidadPO
    }
    func getCantidadPO() -> Float {
        return self._cantidadPO
    }
    
    func setPR(pr:String) -> Void {
        self._pr = pr
    }
    func getPR() -> String {
        return self._pr
    }
    
    func setRecibido(recibido: Int) -> Void {
        self._recibido = recibido
    }
    func getRecibido() -> Int {
        return self._recibido
    }
    
    func setCantidadRecibida(cantidadRecibida: Int) -> Void {
        self._cantidadRecibida = cantidadRecibida
    }
    func getCantidaRecibida() -> Int {
        return self._cantidadRecibida
    }
    
    func setRowVersion(rowVersion: String) -> Void {
        self._rowVersion = rowVersion
    }
    func getRowVersion() -> String {
        return self._rowVersion
    }
    
    func setDisponibilidad(disponibilidad: Int)-> Void{
        self._disponibilidad = disponibilidad
    }
    func getDisponibilidad() -> Int {
        return self._disponibilidad
    }
    
    func setCentroCosto(centroCosto: String) -> Void {
        self._centroCosto = centroCosto
    }
    func getCentroCosto() -> String {
        return self._centroCosto
    }
    
    func setCantidadPorRecibir(cantidadPorRecibir:Int) -> Void {
        self._cantidadPorRecibir = cantidadPorRecibir
    }
    func getCantidadPorRecibir() -> Int {
        return self._cantidadPorRecibir
    }
    
    func setNumeroGuia(numeroGuia: String) -> Void {
        self._numeroGuia = numeroGuia
    }
    func getNumeroGuia() -> String {
        return self._numeroGuia
    }
    
    func setAlmaceDestino(almacenDestino:String) -> Void {
        self._almacenDestino = almacenDestino
    }
    func getAlmacenDestino() -> String {
        return self._almacenDestino
    }
    
    func setCantidadX(cantidaX: Int) -> Void {
        self._cantidadX = cantidaX
    }
    func getCantidadX() -> Int {
        return self._cantidadX
    }
    
    func setCantidadY(cantidadY: Int) -> Void {
        self._cantodadY = cantidadY
    }
    func getCantidadY() -> Int {
        return self._cantodadY
    }
    
    func setCantidadZ(cantidadZ: Int) -> Void {
        self._cantidadZ = cantidadZ
    }
    func getCantidadZ() -> Int {
        return self._cantidadZ
    }
    
    func setCantidadDiscrepancia(cantidadDiscrepancia:Int) -> Void {
        self.cantidadDiscrepancia = cantidadDiscrepancia
    }
    func getCantidadDiscrepancia() -> Int {
        return self.cantidadDiscrepancia
    }
    
    func setCreadoDeDiscOnsite(creadoDeDiscOnsite: String) -> Void {
        self.creadoDeDiscOnsite = creadoDeDiscOnsite
    }
    func getCreadoDeDiscOnsite() -> String {
        return self.creadoDeDiscOnsite
    }
    
    func setIdDiscrepanciaPadre(idDiscrepanciaPadre: String) -> Void {
        self.idDiscrepanciaPadre = idDiscrepanciaPadre
    }
    func getIdDiscrepanciaPadre() -> String {
        return self.idDiscrepanciaPadre
    }
}
