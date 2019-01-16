//
//  Discrepancia.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 1/16/19.
//  Copyright © 2019 Innnovacis SRL. All rights reserved.
//

import Foundation

class Discrepancia {

    private var idDiscrepancia : String
    private var idOrdenDetalle : String
    private var idBultoOrden : String
    private var valorOrden : String
    private var numeroItem : String
    private var descripcion : String
    private var numeroWaybill : String
    private var comentario : String
    private var unidad : String
    private var cantidad : Int
    private var cantidadPorRecibir : Int
    private var cantidadRecibida : Int
    private var tipoDiscrepancia : String
    private var estadoDiscrepancia : String
    private var centroCosto : String
    private var idProveedor : String
    private var nombreProveedor : String
    private var almacen : String
    
    init() {
        self.idDiscrepancia = VACIO
        self.idOrdenDetalle = VACIO
        self.idBultoOrden = VACIO
        self.valorOrden = VACIO
        self.numeroItem = VACIO
        self.descripcion = VACIO
        self.numeroWaybill = VACIO
        self.comentario = VACIO
        self.unidad = VACIO
        self.cantidad = 0
        self.cantidadPorRecibir = 0
        self.cantidadRecibida = 0
        self.tipoDiscrepancia = VACIO
        self.estadoDiscrepancia = VACIO
        self.centroCosto = VACIO
        self.idProveedor = VACIO
        self.nombreProveedor = VACIO
        self.almacen = VACIO
    }
    
    func setIdDiscrepancia(idDiscrepancia: String) -> Void {
        self.idDiscrepancia = idDiscrepancia
    }
    func getIdDiscrepancia() -> String {
        return self.idDiscrepancia
    }
    
    func setIdOrdenDetalle(idOrdenDetalle: String ) -> Void {
        self.idOrdenDetalle = idOrdenDetalle
    }
    func getIdOrdenDetalle() -> String {
        return self.idOrdenDetalle
    }
    
    func setIdBultoOrden(idBultoOrden: String) -> Void {
        self.idBultoOrden = idBultoOrden
    }
    func getIdBultoOrden() -> String {
        return self.idBultoOrden
    }
    
    func setValorOrden(valorOrden: String) -> Void {
        self.valorOrden = valorOrden
    }
    func getValorOrden() -> String {
        return self.valorOrden
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
    
    func setNumeroWaybill(numeroWaybill : String) -> Void {
        self.numeroWaybill = numeroWaybill
    }
    func getNumeroWaybill() -> String {
        return self.numeroWaybill
    }
    
    func setComentario(comentario: String) -> Void {
        self.comentario = comentario
    }
    func getComentario() -> String {
        return self.comentario
    }
    
    func setUnidad(unidad: String) -> Void {
        self.unidad = unidad
    }
    func getUnidad() -> String {
        return self.unidad
    }
    
    func setCantidad(cantidad: Int) -> Void {
        self.cantidad = cantidad
    }
    func getCantidad() -> Int {
        return self.cantidad
    }
    
    func setCantidadPorRecibir(cantidadPorRecibir: Int) -> Void {
        self.cantidadPorRecibir = cantidadPorRecibir
    }
    func getCantidadPorRecibir() -> Int {
        return self.cantidadPorRecibir
    }
    
    func setCantidadRecibida(cantidadRecibida: Int) -> Void {
        self.cantidadRecibida = cantidadRecibida
    }
    func getCantidadRecibida() -> Int {
        return self.cantidadRecibida
    }
    
    func setTipoDiscrepancia(tipoDiscrepancia: String) -> Void {
        self.tipoDiscrepancia = tipoDiscrepancia
    }
    func getTipoDiscrepancia() -> String {
        return self.tipoDiscrepancia
    }
    
    func setEstadoDiscrepancia(estadoDiscrepancia: String) -> Void {
        self.estadoDiscrepancia = estadoDiscrepancia
    }
    func getEstadoDiscrepancia() -> String {
        return self.estadoDiscrepancia
    }
    
    func setCentroCosto(centroCosto: String) -> Void {
        self.centroCosto = centroCosto
    }
    func getCentroCosto() -> String {
        return self.centroCosto
    }
    
    func setIdProveedor(idProveedor:String) -> Void {
        self.idProveedor = idProveedor
    }
    func getIdProveedor() -> String {
        return self.idProveedor
    }
    
    func setNombreProveedor(nombreProveedor : String) -> Void {
        self.nombreProveedor = nombreProveedor
    }
    func getNombreProveedor() -> String {
        return self.nombreProveedor
    }
    
    func setAlmacen(almacen:String) -> Void {
        self.almacen = almacen
    }
    func getAlmacen() -> String {
        return self.almacen 
    }
}
