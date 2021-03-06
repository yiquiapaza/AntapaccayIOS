//
//  Util.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 10/31/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import Foundation

let BASE_URL:String = "https://app.antapaccay.com.pe/seguimientoCarga/api/"


// parametres

let VALOR_ORDEN: String = "valorOrden"
let TIPO_ORDEN: String = "tipoOrden"
let ID_COMPRADOR: String = "idComprador"
let CODIGO_DISTRITO: String = "codigoDistrito"
let PRICE_CODE: String = "priceCode"

let ID:String = "Id"
let NUMERO_ITEM:String = "numeroItem"
let DISTRITO: String = "distrito"
let ALMACEN: String = "almacen"
let UNIDAD: String = "unidad"
let PART_NUMBER: String = "partNumber"
let DESCRIPCION : String = "descripcion"
let NOMBRE_PROVEEDOR: String = "nombreProveedor"
let CANTIDAD_PO:String = "cantidadPO"
let PR: String = "pr"
let RECIBIDO = "recibido"
let CANTIDAD_RECIBIDA = "cantidadRecibida"
let ROW_VERSION = "rowVersion"
let DISPONIBILIDAD = "disponibilidad"

let SWITCH_OC: String = "OC"
let SWITCH_OS: String = "S"
let SWITCH_OR: String = "O"
let SWITCH_ID: String = "F"

let CONST_CODIGO_DISTRITO: String = "XTAN"
let CONST_ID: String = "00000000-0000-0000-0000-000000000000"
let CONST_ROW_VERSION: String = "000000000000"
let CONST_ID_ORDEN_DETALLE = "00000000-0000-0000-0000-000000000000"
let CONST_TRANSPORTISTA = "CIVA"

var NACIONAL: Bool = false
var IMPORTACION: Bool = false
var PESO: String = ""
var ALTO: String = ""
var ANCHO: String = ""
var LARGO: String = ""
var FRAGIL: Bool = false
var SOBREDIMENSIONADO: Bool = false
var CARGA_PELIGROSA:Bool = false
var GENERAL: Bool = false
var COMPONENTE: Bool = false
var PALETA_CONSOLIDADA: Bool = false
var UNIDAD_COMPLETA:Bool = false
let ID_ALMACEN_RECEPCION = "idAlmacenRecepcion"
let ALMACEN_DESTINO = "almacenDestino"
let NOMBRE_ALMACEN = "nombreAlmacen"
let ESTADO_BULTO = "estadoBulto"
let JSON_PESO = "peso"
let JSON_ALTO = "alto"
let JSON_ANCHO = "ancho"
let JSON_LARGO = "largo"
let JSON_FRAGIL = "fragil"
let JSON_SOBREDIMENSIONADO = "sobredimensionado"
let JSON_CARGA_PELIGROSA = "cargaPeligrosa"
let JSON_IMPORTACION = "importacion"
let JSON_NACIONAL = "nacional"
let OS = "os"
let PLAQUETEO = "plaqueteo"
let CAMPO_ID = "campoID"
let COMENTARIO = "comentario"
let COMENTARIO_ID = "comentarioID"
let FECHA_RECEPCION = "fechaRecepcion"
let CODIGO_TRANSPORTISTA = "codigoTransportista"
let TRANSPORTISTA = "transportista"
let UBICACION = "ubicacion"
let JSON_GENERAL = "general"
let JSON_COMPONENTE = "componente"
let JSON_PALETA_CONSOLIDADA = "paletaConsolidada"
let JSON_UNIDAD_COMPLETA = "unidadCompleta"
let ID_ORDEN_DETALLE = "idOrdenDetalle"
let CANTIDAD_GENERAL = "cantidad"
let ID_PROVEEDOR = "idProveedor"
let VERIFICADO_ALMACEN = "verificadoAlmacen"

let NUMERO_GUIA = "numeroGuia"

let VACIO: String = ""

var PESO_BULTO: String = ""
var ALTO_BULTO: String = ""
var ANCHO_BULTO: String = ""
var LARGO_BULTO: String = ""




var QR_CONST_PALETA: String = VACIO
var QR_CONST_BULTO: String = VACIO



var SERVICIO_EXPRESS = false
var CODIGO_DESTINO = VACIO
var NOMBRE_DESTINO = VACIO
var PLACA_SEMIREMOLQUE = VACIO
var TIPO_SEMIREMOLQUE_CODIGO = VACIO
var TIPO_SEMIREMOLQUE_CONST = VACIO
var PESO_LISTA: Float = 0
var CODIGO_TRANSPORTISTA_LISTA = VACIO
var TRANSPORTISTA_LISTA = VACIO


var LISTA_PALETA = Array<Data>()
var CONTADOR_IMAGEN = 0
var CONTADOR_IMAGEN_2 = 0
var CONTADOR_IMAGEN_3 = 0

var ROL_ADMINISTRADOR = "administrador"
var ROL_COORDINADOR = "cordinador"
var ROL_TRANSPORTISTA = "transportista"
var ROL_USUARIOMINA = "usuriomina"
