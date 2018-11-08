//
//  Bulto.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 11/8/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import Foundation

class Bulto {
    var idAlmacenRecepcion: String
    var almacenDestino: String
    var nombreProveedor: String
    var nombreAlmacen:String
    var tipoOrden: String
    var valorOrden: String
    var estadoBulto: String
    var peso: String
    var alto: String
    var ancho: String
    var largo: String
    var fragil: Bool
    var sobredimensionamiento: Bool
    var cargaPeligrosa: Bool
    var importacion: Bool
    var nacional: Bool
    var os: String
    var pr: String
    var plaqueteo: String
    var campoID : String
    var comentario: String
    var comentarioID: String
    var fechaRecepcion: Int
    var codigoTransportista: String
    var transportista: String
    var ubicacion: String
    var general : Bool
    var componente: Bool
    var paletaConsolidada: Bool
    var unidadCompleta: Bool
    var id: String
    var rowVersion: String
    
    init() {
        self.idAlmacenRecepcion = VACIO
        self.almacenDestino = VACIO
        self.nombreProveedor = VACIO
        self.nombreAlmacen = VACIO
        self.tipoOrden = VACIO
        self.valorOrden = VACIO
        self.estadoBulto = VACIO
        self.peso = VACIO
        self.alto = VACIO
        self.ancho = VACIO
        self.largo = VACIO
        self.fragil = false
        self.sobredimensionamiento = false
        self.cargaPeligrosa = false
        self.importacion = false
        self.nacional = false
        self.os = VACIO
        self.pr = VACIO
        self.plaqueteo = VACIO
        self.campoID = VACIO
        self.comentario = VACIO
        self.comentarioID = VACIO
        self.fechaRecepcion = 0
        self.codigoTransportista = VACIO
        self.transportista = VACIO
        self.ubicacion = VACIO
        self.general = false
        self.componente = false
        self.paletaConsolidada = false
        self.unidadCompleta = false
        self.id = VACIO
        self.rowVersion = VACIO
    }
    
    func setIdAlmacenRecepcion(idAlmacenRecepcion: String) -> Void {
        self.idAlmacenRecepcion = idAlmacenRecepcion
    }
    func getIdAlmacenRecepcion() -> String {
        return self.idAlmacenRecepcion
    }
    
    func setAlmacenDestino(almacenDestino: String) -> Void {
        self.almacenDestino = almacenDestino
    }
    func getAlmacenDestino() -> String {
        return self.almacenDestino
    }
    
    func setNombreProveedor(nombreProveedor: String) -> Void {
        self.nombreProveedor = nombreProveedor
    }
    func getNombreProveedor() -> String {
        return self.nombreProveedor
    }
    
    func setNombreAlmacen(nombreAlmacen: String) -> Void {
        self.nombreAlmacen = nombreAlmacen
    }
    func getNombreAlmacen() -> String {
        return self.nombreAlmacen
    }
    
    func setTipoOrden(tipoOrden: String) -> Void {
        self.tipoOrden = tipoOrden
    }
    func getTipoOrden() -> String {
        return self.tipoOrden
    }
    
    func setValorOrden(valorOrden: String) -> Void {
        self.valorOrden = valorOrden
    }
    func getValorOrden() -> String {
        return self.valorOrden
    }
    
    func setEstadoBulto(estadoBulto: String) -> Void {
        self.estadoBulto = estadoBulto
    }
    func getEstadoBulto() -> String {
        return self.estadoBulto
    }
    
    func setPeso(peso:String) -> Void {
        self.peso = peso
    }
    func getPeso() -> String {
        return self.peso
    }
    
    func setAlto(alto: String) -> Void {
        self.alto = alto
    }
    func getAlto() -> String {
        return self.alto
    }
    
    func setAncho(ancho:String) -> Void {
        self.ancho = ancho
    }
    func getAncho() -> String {
        return self.ancho
    }
    
    func setLargo(largo: String) -> Void {
        self.largo = largo
    }
    func getLargo() -> String {
        return self.largo
    }
    
    func setFragil(fragil: Bool) -> Void {
        self.fragil = fragil
    }
    func getFragil() -> Bool {
        return self.fragil
    }
    
    func setsobredimensionado(sobredimensionamiento: Bool) -> Void {
        self.sobredimensionamiento = sobredimensionamiento
    }
    func getSobredimensionado() -> Bool {
        return self.sobredimensionamiento
    }
    
    func setCargaPeligrosa(cargaPeligrosa: Bool) -> Void {
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
    
    func setNacional(nacional: Bool) -> Void {
        self.nacional = nacional
    }
    func getNacional() -> Bool {
        return self.nacional
    }
    
    func setOs(os:String) -> Void {
        self.os = os
    }
    func getOs() -> String {
        return self.os
    }
    
    func setPr(pr : String) -> Void {
        self.pr = pr
    }
    func getPr() -> String {
        return self.pr
    }
    
    func setPlaqueteo(plaqueteo: String) -> Void {
        self.plaqueteo = plaqueteo
    }
    func getPlaqueteo() -> String {
        return self.plaqueteo
    }
    
    func setCampoID(campoID: String) -> Void {
        self.campoID = campoID
    }
    func getCampoID() -> String {
        return self.campoID
    }
    
    func setComentario(comentario: String) -> Void {
        self.comentario = comentario
    }
    func getComentario() -> String {
        return self.comentario
    }
    
    func setComentarioID(comentarioID: String) -> Void {
        self.comentarioID = comentarioID
    }
    func getComentarioID() -> String {
        return self.comentarioID
    }
    
    func setFechaRecepcion(fechaRecepcion: Int) -> Void {
        self.fechaRecepcion = fechaRecepcion
    }
    func getFechaRecepcion() -> Int {
        return self.fechaRecepcion
    }
    
    func setTransportista(transportista: String) -> Void {
        self.transportista = transportista
    }
    func getTransportista() -> String {
        return self.transportista
    }
    
    func setUbicacion(ubicacion: String) -> Void {
        self.ubicacion = ubicacion
    }
    func getUbicacion() -> String {
        return self.ubicacion
    }
    
    func setGeneral(general: Bool) -> Void {
        self.general = general
    }
    func getGeneral() -> Bool {
        return self.general
    }
    
    func setComponente(componente: Bool) -> Void {
        self.componente = componente
    }
    func getComponente() -> Bool {
        return self.componente
    }
    
    func setPaletaConsolidada(paletaConsolidada: Bool) -> Void {
        self.paletaConsolidada = paletaConsolidada
    }
    func getPaletaCOnsolidada() -> Bool {
        return self.paletaConsolidada
    }
    
    func setUnidadCompleta(unidadCompleta:Bool ) -> Void {
        self.unidadCompleta = unidadCompleta
    }
    func getUnidadCompleta() -> Bool {
        return self.unidadCompleta
    }
    
    func setId(id: String) -> Void {
        self.id = id
    }
    func getId() -> String {
        return self.id
    }
    
    func setRowVersion(rowVersion: String) -> Void {
        self.rowVersion = rowVersion
    }
    func getRowVersion() -> String {
        return self.rowVersion
    }
    
}
