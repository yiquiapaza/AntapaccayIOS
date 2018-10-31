//
//  Orden.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 10/31/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import Foundation
class Orden {
    private var _valorOrden: String?
    private var _tipoOrden: String?
    private var _idComprador: String?
    private var _codigoDistrito: String?
    private var _priceCode: String?
    
    init() {
        self._valorOrden = ""
        self._tipoOrden = ""
        self._idComprador = ""
        self._codigoDistrito = ""
        self._priceCode = ""
    }
    
    init(_valorOrden: String?, _tipoOrden: String?, _idComprador: String? ,_codigoDistrito: String?, _priceCode: String?) {
        self._valorOrden = _valorOrden
        self._tipoOrden = _tipoOrden
        self._idComprador = _idComprador
        self._codigoDistrito = _codigoDistrito
        self._priceCode = _priceCode
    }
    
    var idComprador :String? {
        set{
            _idComprador = idComprador
        }
        get{
            return _idComprador
        }
    }
    
    var valorOrden: String?{
        set{
            _valorOrden = valorOrden
        }
        get{
            return _valorOrden
        }
    }
    
    var tipoOrden: String?{
        set{
            _tipoOrden = tipoOrden
        }
        get{
            return _tipoOrden
        }
    }
    var codigoDistrito: String? {
        set{
            _codigoDistrito = codigoDistrito
        }
        get{
            return _codigoDistrito
        }
    }
    var priceCode: String?{
        set {
            _priceCode = priceCode
        }
        get {
            return _priceCode
        }
    }
}
