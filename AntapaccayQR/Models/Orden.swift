//
//  Orden.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 10/31/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import Foundation
class Orden {
    private var _valorOrden: String!
    private var _tipoOrden: String!
    private var _idComprador: String!
    private var _codigoDistrito: String!
    private var _priceCode: String!
    
    init() {
        self._valorOrden = ""
        self._tipoOrden = ""
        self._idComprador = ""
        self._codigoDistrito = ""
        self._priceCode = ""
    }
    
    init(_valorOrden: String, _tipoOrden: String, _idComprador: String ,_codigoDistrito: String, _priceCode: String) {
        self._valorOrden = _valorOrden
        self._tipoOrden = _tipoOrden
        self._idComprador = _idComprador
        self._codigoDistrito = _codigoDistrito
        self._priceCode = _priceCode
    }
    
    func setIdComprador(idComprador: String){
        _idComprador = idComprador
    }
    func getIdCmprador() -> String {
        return _idComprador
    }
    
    func setValorOrden(valorOrden: String) -> Void {
        _valorOrden = valorOrden
    }
    func getValorOrden() -> String {
        return _valorOrden
    }
    
    func setTipoOrden(tipoOrden:String)-> Void {
        _tipoOrden = tipoOrden
    }
    func getTipoOrden()->String {
        return _tipoOrden
    }
    
    func setCodigoDistrito(codigoDistrito: String) ->Void{
        _codigoDistrito = codigoDistrito
    }
    func getCodigoDistrito() -> String {
        return _codigoDistrito
    }
    
    func setPriceCode(priceCode: String) -> Void {
        _priceCode = priceCode
    }
    
    func getPriceCode() -> String {
        return _priceCode
    }
}
