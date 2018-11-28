//
//  Registro.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 11/28/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import Foundation

class Registro {
    private var id : String
    private var idPuntoPartida : String
    private var codigoDestino : String
    private var numeroTransporte : Int
    private var codigo : String
    private var nombrePuntoPartida :String
    private var nombreDestino : String
    private var codigoVehiculo: String
    private var codigoConfiguracionTracto : String
    private var configuracionTracto :String
    private var placaRemolque : String
    private var codigoTipoRemolque : String
    private var tipoRemolque : String
    private var codigoConductor : String
    private var nombreConductor : String
    private var servicioExpreso : Bool
    private var precio : Float
    private var estadoTransporte: String
    private var codigoConfiguracionRemolque : String
    private var configuracionRemolque : String
    private var fechaInicio : Int
    private var fechaFin : Int
    private var fechaTentativaFin : Int
    private var totalPaletas : Int
    private var guiaTransportista : Bool
    private var guiaAntapaccay : Bool
    private var codigoTransportista : String
    private var transportista : String
    private var RowVersion : String
    
    init() {
        self.id = VACIO
        self.idPuntoPartida = VACIO
        self.codigoDestino = VACIO
        self.numeroTransporte = 0
        self.codigo = VACIO
        self.nombrePuntoPartida = VACIO
        self.nombreDestino = VACIO
        self.codigoVehiculo = VACIO
        self.codigoConfiguracionTracto = VACIO
        self.configuracionTracto = VACIO
        self.placaRemolque = VACIO
        self.codigoTipoRemolque = VACIO
        self.tipoRemolque = VACIO
        self.codigoConductor = VACIO
        self.nombreConductor = VACIO
        self.servicioExpreso = false
        self.precio = 0.0
        self.estadoTransporte = VACIO
        self.codigoConfiguracionRemolque = VACIO
        self.configuracionRemolque = VACIO
        self.fechaInicio  = 0
        self.fechaFin = 0
        self.fechaTentativaFin = 0
        self.totalPaletas  = 0
        self.guiaTransportista = false
        self.guiaAntapaccay = false
        self.codigoTransportista = VACIO
        self.transportista = VACIO
        self.RowVersion = VACIO
    }
    
    func setId(id: String) -> Void {
        self.id = id
    }
    func getId() -> String {
        return self.id
    }
    
    func setIdPuntoPartida(idPuntoPartida: String) -> Void{
        self.idPuntoPartida = idPuntoPartida
    }
    func getIdPuntoPartida() -> String {
        return self.idPuntoPartida
    }
    
    func setCodigoDestino(codigoDestino: String) -> Void {
        self.codigoDestino = codigoDestino
    }
    func getCodigoDestino() -> String {
        return self.codigoDestino
    }
    
    func setNumeroTransporte(numeroTransporte: Int) -> Void {
        self.numeroTransporte = numeroTransporte
    }
    func getNumeroTransporte() -> Int {
        return self.numeroTransporte
    }
    
    func setCodigo(codigo : String) -> Void {
        self.codigo = codigo
    }
    func getCodigo() -> String {
        return self.codigo
    }
    
    func setNombrePuntoPartida(nombrePuntoPartida : String) -> Void {
        self.nombrePuntoPartida = nombrePuntoPartida
    }
    func getNombrePuntoPartida() -> String {
        return self.nombrePuntoPartida
    }
    
    func setNombreDestino(nombreDestino:String) -> Void {
        self.nombreDestino = nombreDestino
    }
    func getNombreDestino() -> String {
        return self.nombreDestino
    }
    
    func setCodigoVehiculo(codigoVehiculo : String) -> Void {
        self.codigoVehiculo = codigoVehiculo
    }
    func getCodigoVehiculo() -> String {
        return self.codigoVehiculo
    }
    
    func setCodigoConfiguracionTracto(codigoConfiguracionTracto :String) -> Void {
        self.codigoConfiguracionTracto = codigoConfiguracionTracto
    }
    func getCodigoConfiguracionTracto() -> String {
        return self.codigoConfiguracionTracto
    }
    
    func setConfiguracionTracto(configuracionTracto :String) -> Void {
        self.configuracionTracto = configuracionTracto
    }
    func getConfiguracionTracto() -> String {
        return self.configuracionTracto
    }
    
    func setPlacaRemolque(placaRemolque :String) -> Void {
        self.placaRemolque = placaRemolque
    }
    func getPlacaRemolque() -> String {
        return self.placaRemolque
    }
    
    func setCodigoTipoRemolque(codigoTipoRemolque : String) -> Void {
        self.codigoTipoRemolque = codigoTipoRemolque
    }
    func getCodigoTipoRemolque() -> String {
        return self.codigoTipoRemolque
    }
    
    func setTipoRemolque(tipoRemolque:String) -> Void {
        self.tipoRemolque = tipoRemolque
    }
    func getTipoRemolque() -> String {
        return self.tipoRemolque
    }
    
    func setCodigoConductor(codigoConductor : String) -> Void {
        self.codigoConductor = codigoConductor
    }
    func getCodigoConductor() -> String {
        return self.codigoConductor
    }
    
    func setNombreConductor(nombreConductor:String) -> Void {
        self.nombreConductor = nombreConductor
    }
    func getNombreConductor() -> String {
        return self.nombreConductor
    }
    
    func setServicioExpreso(servicioExpreso:Bool) -> Void {
        self.servicioExpreso = servicioExpreso
    }
    func getServicioExpreso() -> Bool {
        return self.servicioExpreso
    }
    
    func setPrecio(precio:Float) -> Void {
        self.precio = precio
    }
    func getPrecio() -> Float {
        return self.precio
    }
    
    func setEstadoTransporte(estadoTransporte :String) -> Void {
        self.estadoTransporte = estadoTransporte
    }
    func getEstadoTransporte() -> String {
        return self.estadoTransporte
    }
    
    func setCodigoConfiguracionRemolque(codigoConfiguracionRemolque : String) -> Void {
        self.codigoConfiguracionRemolque = codigoConfiguracionRemolque
    }
    func getCodigoConfiguracionRemolque() -> String {
        return self.codigoConfiguracionRemolque
    }
    
    func setConfiguracionRemolque (configuracionRemolque:String ) ->Void{
        self.configuracionRemolque = configuracionRemolque
    }
    func getConfiguracionRemolque() -> String {
        return self.configuracionRemolque
    }
    
    func setFechaInicio(fechaInicio:Int) -> Void {
        self.fechaInicio = fechaInicio
    }
    func getFechaInicio() -> Int {
        return self.fechaInicio
    }
    
    func setFechaFin(fechaFin : Int) -> Void {
        self.fechaFin = fechaFin
    }
    func getFechaFin() -> Int {
        return self.fechaFin
    }
    
    func setFechaTentativaFin(fechaTentativaFin :Int) -> Void {
        self.fechaTentativaFin = fechaTentativaFin
    }
    func getFechaTentativaFin() -> Int {
        return self.fechaTentativaFin
    }
    
    func setTotalPaletas(totalPaletas : Int) -> Void {
        self.totalPaletas = totalPaletas
    }
    func getTotalPaletas() -> Int {
        return self.totalPaletas
    }
    
    func setGuiaTransportista(guiaTransportista : Bool) -> Void {
        self.guiaTransportista = guiaTransportista
    }
    func getGuiaTransportista() -> Bool {
        return self.guiaTransportista
    }
    
    func setGuiaAntapaccay(guiaAntapaccay:Bool) -> Void {
        self.guiaAntapaccay = guiaAntapaccay
    }
    func getGuiaAntapaccay() -> Bool {
        return self.guiaAntapaccay
    }
    
    func setCodigoTransportista(codigoTransportista : String) -> Void {
        self.codigoTransportista = codigoTransportista
    }
    func getCodigoTransportista() -> String {
        return self.codigoTransportista
    }
    
    func setTransportista(transportista : String) -> Void {
        self.transportista = transportista
    }
    func getTransportista() -> String {
        return self.transportista
    }
    
    func setRowVersion(RowVersion:String) -> Void {
        self.RowVersion = RowVersion
    }
    func getRowVersion() -> String {
        return self.RowVersion
    }
}
