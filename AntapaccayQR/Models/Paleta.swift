//
//  Paleta.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 11/26/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import Foundation
class Paleta  {
    private var Id:String
    private var IdPaleta: String
    private var IdAlmacenRecepcion:String
    private var AlmacenDestino:String
    private var NumeroBulto: Int
    private var Codigo: String
    private var NombreProveedor: String
    private var NombreAlmacen: String
    private var TipoOrden : String
    private var ValorOrden: String
    private var EstadoBulto: String
    private var Peso: Float
    private var Alto: Float
    private var Ancho: Float
    private var Largo: Float
    private var Fragil: Bool
    private var Sobredimensionado: Bool
    private var CargaPeligrosa: Bool
    private var Importacion: Bool
    private var Nacional : Bool
    private var FechaRecepcion: Int
    private var Transportista: String
    private var Ubicacion : String
    private var General: Bool
    private var Componente : Bool
    private var UnidadCompleta: Bool
    private var RowVersion : String
    
    private var OS : String
    private var PR : String
    private var Plaqueteo: String
    private var CampoID: String
    private var Comentario: String
    private var ComentarioID: String
    private var IdDiscrepancia: String
    private var CampoDiscrepancia: String
    
    init() {
        self.Id = VACIO
        self.IdPaleta = VACIO
        self.IdAlmacenRecepcion = VACIO
        self.NumeroBulto = 0
        self.Codigo = VACIO
        self.NombreProveedor = VACIO
        self.NombreAlmacen = VACIO
        self.TipoOrden = VACIO
        self.ValorOrden = VACIO
        self.EstadoBulto = VACIO
        self.Peso = 0.0
        self.Alto = 0.0
        self.Ancho = 0.0
        self.Largo = 0.0
        self.Fragil = false
        self.Sobredimensionado = false
        self.CargaPeligrosa = false
        self.Importacion = false
        self.Nacional = false
        self.FechaRecepcion = 0
        self.Transportista = VACIO
        self.Ubicacion = VACIO
        self.General = false
        self.Componente = false
        self.UnidadCompleta = false
        self.RowVersion = VACIO
        self.AlmacenDestino = VACIO
        
        self.OS = VACIO
        self.PR = VACIO
        self.Plaqueteo = VACIO
        self.CampoID = VACIO
        self.Comentario = VACIO
        self.ComentarioID = VACIO
        self.IdDiscrepancia = VACIO
        self.CampoDiscrepancia = VACIO
    }
    
    func setId(Id:String) -> Void {
        self.Id = Id
    }
    func getId() -> String {
        return self.Id
    }
    
    func setIdPaleta(IdPaleta: String) -> Void {
        self.IdPaleta = IdPaleta
    }
    func getIdPaleta() -> String {
        return self.IdPaleta
    }
    
    func setIdAlmacenRecepcion(IdAlmacenRecepcion: String) -> Void {
        self.IdAlmacenRecepcion = IdAlmacenRecepcion
    }
    func getIdAlmacenRecepcion() -> String {
        return self.IdAlmacenRecepcion
    }
    
    func setNumeroBulto(numeroBulto: Int) -> Void {
        self.NumeroBulto = numeroBulto
    }
    func getNumeroBulto() -> Int {
        return self.NumeroBulto
    }
    
    func setCodigo(Codigo: String) -> Void {
        self.Codigo = Codigo
    }
    func getCodigo() -> String {
        return self.Codigo
    }
    
    func setNombreProveedor(nombreProveedor:String) -> Void {
        self.NombreProveedor = nombreProveedor
    }
    func getNombreProveedor() -> String {
        return self.NombreProveedor
    }
    
    func setNombreAlmacen(nombreAlmacen: String) -> Void {
        self.NombreAlmacen = nombreAlmacen
    }
    func getNombreAlmacen() -> String {
        return self.NombreAlmacen
    }
    
    func setTipoOrden(tipoOrden: String) -> Void {
        self.TipoOrden = tipoOrden
    }
    func getTipoOrden() -> String {
        return self.TipoOrden
    }
    
    func setValorOrden(valorOrden: String) -> Void {
        self.ValorOrden = valorOrden
    }
    func getValorOrden() -> String {
        return self.ValorOrden
    }
    
    func setEstadoBulto(EstadoBulto: String) -> Void {
        self.EstadoBulto = EstadoBulto
    }
    func getEstadoBulto() -> String {
        return self.EstadoBulto
    }
    
    func setPeso(peso: Float) -> Void {
        self.Peso = peso
    }
    func getPeso() -> Float {
        return self.Peso
    }
    
    func setAlto(alto: Float) -> Void {
        self.Alto = alto
    }
    func getAlto() -> Float {
        return self.Alto
    }
    
    func setAncho(ancho: Float) -> Void {
        self.Ancho = ancho
    }
    func getAncho() -> Float {
        return self.Ancho
    }
    
    func setLargo(largo: Float) -> Void {
        self.Largo = largo
    }
    func getLarog() -> Float {
        return self.Largo
    }
    
    func setFragil(fragil:Bool) -> Void {
        self.Fragil = fragil
    }
    func getFragil() -> Bool {
        return self.Fragil
    }
    
    func setSobredimensionado(sobredimensionado: Bool) -> Void {
        self.Sobredimensionado = sobredimensionado
    }
    func getSobredimensionado() -> Bool {
        return self.Sobredimensionado
    }
    
    func setCargaPeligrosa(cargaPeligrosa: Bool) -> Void {
        self.CargaPeligrosa = cargaPeligrosa
    }
    func getCargaPeligrosa() -> Bool {
        return self.CargaPeligrosa
    }
    
    func setImportacion(importancia: Bool) -> Void {
        self.Importacion = importancia
    }
    func getImportacion() ->  Bool{
        return self.Importacion
    }
    
    func setNacional(nacional: Bool) -> Void {
        self.Nacional = nacional
    }
    func getNacional() -> Bool {
        return self.Nacional
    }
    
    func setFechaRecepcion(fecha: Int) -> Void {
        self.FechaRecepcion = fecha
    }
    func getFechaRecepcion() -> Int {
        return self.FechaRecepcion
    }
    
    func setTransportista(transportista:String) -> Void {
        self.Transportista = transportista
    }
    func getTransportista() -> String {
        return self.Transportista
    }
    
    func setUbicacion(ubicacion: String) -> Void {
        self.Ubicacion = ubicacion
    }
    func getUbicacion() -> String {
        return self.Ubicacion
    }
    
    func setGeneral(general: Bool) -> Void {
        self.General = general
    }
    func getGeneral() -> Bool {
        return self.General
    }
    
    func setComponente(componente:Bool) -> Void {
        self.Componente = componente
    }
    func getComponente() -> Bool {
        return self.Componente
    }
    
    func setUnidadCompleta(unidad: Bool) -> Void {
        self.UnidadCompleta = unidad
    }
    func getUnidadCompleta() -> Bool {
        return self.UnidadCompleta
    }
    
    func setRowVersion(rowVersion: String) -> Void {
        self.RowVersion = rowVersion
    }
    func getRowVersion() -> String {
        return self.RowVersion
    }
    
    func setAlmacenDestino(AlmacenDestino: String) -> Void {
        self.AlmacenDestino = AlmacenDestino
    }
    func getAlmacenDestino() -> String {
        return self.AlmacenDestino
    }
    
    func setOS(OS:String) -> Void {
        self.OS = OS
    }
    func getOS() -> String {
        return self.OS
    }
    
    func setPR(PR:String) -> Void {
        self.PR = PR
    }
    func getPR() -> String {
        return self.PR
    }
    
    func setPlaqueteo(Plaqueteo: String) -> Void {
        self.Plaqueteo = Plaqueteo
    }
    func getPlaqueteo() -> String {
        return self.Plaqueteo
    }
    
    func setCampoID(CampoID: String) -> Void {
        self.CampoID = CampoID
    }
    func getCampoId() -> String {
        return self.CampoID
    }
    
    func setComentario(Comentario:String) -> Void {
        self.Comentario = Comentario
    }
    func getComentario() -> String {
        return self.Comentario
    }
    
    func setComentarioID(ComentarioID:String) -> Void {
        self.ComentarioID = ComentarioID
    }
    func getComentarioID() -> String {
        return self.ComentarioID
    }
    
    func setIdDiscrepancia(IdDiscrepancia: String) -> Void {
        self.IdDiscrepancia = IdDiscrepancia
    }
    func getIdDiscrepancia() -> String {
        return self.IdDiscrepancia
    }
    
    func setCampoDiscrepancia(CampoDiscrepancia: String) -> Void {
        self.CampoDiscrepancia  = CampoDiscrepancia
    }
    func getCampoDiscrepancia() -> String {
        return self.CampoDiscrepancia
    }
}
