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
}
