//
//  Reporte.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 12/5/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import Foundation
class Reporte {
    private var numeroItem: String
    private var cantidad: String
    private var cantidadPO: String
    private var nombreProveedor: String
    private var descripcion: String
    private var fechaRecepcion: Int
    private var fechaTentativaFin: Int
    private var salidaLima: Int
    private var llegadaAqp: Int
    private var salidaAqp: Int
    private var llegadaMina: Int
    private var estado: Bool
    private var disponibilidad: Bool
    
    init() {
        self.numeroItem = VACIO
        self.cantidad = VACIO
        self.cantidadPO = VACIO
        self.nombreProveedor = VACIO
        self.descripcion = VACIO
        self.fechaRecepcion = 0
        self.fechaTentativaFin = 0
        self.salidaLima = 0
        self.llegadaAqp = 0
        self.salidaAqp = 0
        self.llegadaMina = 0
        self.estado = false
        self.disponibilidad = false
    }
    
    func setNumeroItem(numeroItem: String) -> Void {
        self.numeroItem = numeroItem
    }
    func getNumeroItem() -> String {
        return self.numeroItem
    }
    
    func setCantidad(cantidad: String) -> Void {
        self.cantidad = cantidad
    }
    func getCantidad() -> String {
        return self.cantidad
    }
    
    func setCantidadPO(cantidadPO:String) -> Void {
        self.cantidadPO = cantidadPO
    }
    func getCantidadPO() -> String {
        return self.cantidadPO
    }
    
    func setNombreProveedor(nombreProveedor: String) -> Void {
        self.nombreProveedor = nombreProveedor
    }
    func getNombreProveedor() -> String {
        return self.nombreProveedor
    }
    
    func setDescripcion(descripcion: String) -> Void {
        self.descripcion = descripcion
    }
    func getDescripcion() -> String {
        return self.descripcion
    }
    
    func setFechaRecepcion(fechaRecepcion: Int) -> Void {
        self.fechaRecepcion = fechaRecepcion
    }
    func getFechaRecepcion() -> Int {
        return self.fechaRecepcion
    }
    
    func setFechaTentativaFin(fechaTentativaFin: Int) -> Void {
        self.fechaTentativaFin = fechaTentativaFin
    }
    func getFechaTentativaFin() -> Int {
        return self.fechaTentativaFin
    }
    
    func setSalidaLima(salidaLima: Int) -> Void {
        self.salidaLima = salidaLima
    }
    func getSalidaLima() -> Int {
        return self.salidaLima
    }
    
    func setLlegadaAqp(llegadaAqp: Int) -> Void {
        self.llegadaAqp = llegadaAqp
    }
    func getLlegadaAqp() -> Int {
        return self.llegadaAqp
    }
    
    func setSalidaAqp(salidaAqp: Int) -> Void {
        self.salidaAqp = salidaAqp
    }
    func getSalidaAqp() -> Int {
        return self.salidaAqp
    }
    
    func setLlegadaMina(llegadaMina: Int) -> Void {
        self.llegadaMina = llegadaMina
    }
    func getLlegadaMina() -> Int {
        return self.llegadaMina
    }
    
    func setEstado(estado:Bool) -> Void {
        self.estado = estado
    }
    func getEstado() -> Bool {
        return self.estado
    }
    
    func setDisponibilidad(disponibilidad: Bool) -> Void {
        self.disponibilidad = disponibilidad
    }
    func getDisponibilidad() -> Bool {
        return self.disponibilidad
    }
    
}
