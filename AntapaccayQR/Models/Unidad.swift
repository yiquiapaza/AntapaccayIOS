//
//  Unidad.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 11/27/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import Foundation

class Unidad  {
    private var id : String
    private var idAlmacenRecepcion :String
    private var numeroPaleta: String
    private var codigo :String
    private var peso:Float
    private var alto:Float
    private var largo:Float
    private var ancho: Float
    private var fragil: Bool
    private var sobredimensionado: Bool
    private var cargaPeligrosa: Bool
    private var importacion : Bool
    private var nacional: Bool
    private var fechaRecepcion: Int
    private var RowVersion: String
    
    
    private var idTransporteConsolidado: String
    private var codigoQR: String
    private var numeroWaybill: String
    private var idDiscrepancia: String
    private var campoDiscrepancia : String
    private var imagenes: String
    
    private var codigoTransportista: String
    private var transportista: String
    
    init() {
        self.id = VACIO
        self.idAlmacenRecepcion = VACIO
        self.numeroPaleta = VACIO
        self.codigo = VACIO
        self.peso = 0.0
        self.alto = 0.0
        self.largo = 0.0
        self.ancho = 0.0
        self.fragil = false
        self.sobredimensionado = false
        self.cargaPeligrosa = false
        self.importacion = false
        self.nacional = false
        self.fechaRecepcion = 0
        self.RowVersion = VACIO
        
        self.idTransporteConsolidado = VACIO
        self.codigoQR = VACIO
        self.numeroWaybill = VACIO
        self.idDiscrepancia = VACIO
        self.campoDiscrepancia = VACIO
        self.imagenes = VACIO
        
        self.codigoTransportista = VACIO
        self.transportista = VACIO
    }
    
    func setId(id : String) -> Void {
        self.id = id
    }
    func getId() -> String {
        return self.id
    }
    
    func setIdAlmacenRecepcion(idAlmacenRecepcion: String) -> Void {
        self.idAlmacenRecepcion = idAlmacenRecepcion
    }
    func getIdAlmacenRecepcion() -> String {
        return self.idAlmacenRecepcion
    }
    
    func setNumeroPaleta(numeroPaleta: String) -> Void {
        self.numeroPaleta = numeroPaleta
    }
    func getNumeroPaleta() -> String {
        return self.numeroPaleta
    }
    
    func setCodigo(codigo:String) -> Void {
        self.codigo = codigo
    }
    func getCodigo() -> String {
        return self.codigo
    }
    
    func setPeso(peso : Float) -> Void {
        self.peso = peso
    }
    func getPeso() -> Float {
        return self.peso
    }
    
    func setAlto(alto: Float) -> Void {
        self.alto = alto
    }
    func getAlto() -> Float {
        return self.alto
    }
    
    func setLargo(largo : Float) -> Void {
        self.largo = largo
    }
    func getLargo() -> Float {
        return self.largo
    }
    
    func setAncho(ancho : Float) -> Void {
        self.ancho = ancho
    }
    func getAncho() -> Float {
        return self.ancho
    }
    
    func setFragil(fragil : Bool) -> Void {
        self.fragil = fragil
    }
    func getFragil() -> Bool {
        return self.fragil
    }
    
    func setSobredimensionado(sobredimensionado : Bool) -> Void {
        self.sobredimensionado = sobredimensionado
    }
    func getSobredimensionado() -> Bool {
        return self.sobredimensionado
    }
    
    func setCargaPeligrosa(cargaPeligrosa : Bool) -> Void {
        self.cargaPeligrosa = cargaPeligrosa
    }
    func getCargaPeligrosa() -> Bool {
        return self.cargaPeligrosa
    }
    
    func setImportacion(importacion: Bool) -> Void {
        self.importacion = importacion
    }
    func getImportacion() -> Bool {
        return self.importacion
    }
    
    func setNacional(nacional : Bool) -> Void {
        self.nacional = nacional
    }
    func getNacional() -> Bool {
        return self.nacional
    }
    
    func setFechaRecepcion(fechaRecepcion: Int) -> Void {
        self.fechaRecepcion = fechaRecepcion
    }
    func getFechaRecepcion() -> Int {
        return self.fechaRecepcion
    }
    
    func setRowVersion  (rowVersion: String ) -> Void{
        self.RowVersion = rowVersion
    }
    func getRowVersion  () ->String {
        return self.RowVersion
    }
    
    func setCodigoTransportista(codigoTransportista : String) -> Void {
        self.codigoTransportista = codigoTransportista
    }
    
    func getCodigoTransportista() -> String {
        return self.codigoTransportista
    }
    
    func setTransportista(transportista: String) -> Void {
        self.transportista = transportista
    }
    func getTransportista() -> String {
        return self.transportista
    }
    
    func setIdTransporteConsolidado(idTransporteConsolidado: String) -> Void {
        self.idTransporteConsolidado = idTransporteConsolidado
    }
    func getIdTransporteConsolidado() -> String {
        return self.idTransporteConsolidado
    }
    
    func setCodigoQR(codigoQR: String) -> Void {
        self.codigoQR = codigoQR
    }
    func getCodigoQR() -> String {
        return self.codigoQR
    }
    
    func setNumeroWaybill(numeroWaybill: String) -> Void {
        self.numeroWaybill = numeroWaybill
    }
    func getNumeroWaybill() -> String {
        return self.numeroWaybill
    }
    
    func setIdDiscrepancia(idDiscrepancia: String) -> Void {
        self.idDiscrepancia = idDiscrepancia
    }
    func getIdDiscrepancia() -> String {
        return self.idDiscrepancia
    }
    
    func setCampoDiscrepancia(campoDiscrepancia: String) -> Void {
        self.campoDiscrepancia = campoDiscrepancia
    }
    func getCampoDiscrepancia() -> String {
        return self.campoDiscrepancia
    }
    
    func setImagenes(imagenes: String) -> Void {
        self.imagenes = imagenes
    }
    func getImagenes() -> String {
        return self.imagenes
    }
}
