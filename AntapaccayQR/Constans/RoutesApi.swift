//
//  RoutesApi.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 10/31/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import Foundation

let LIST_ORDEN_DET: String = BASE_URL + "EllipseItems/GetListaOrdenDetalle"
let CREATE_BULTO: String = BASE_URL + "Bulto/SaveConjuntoBultos"
let LIST_TRANSPORTISTAS: String = BASE_URL + "Transportista/GetAll"
let LIST_ALMACENES: String = BASE_URL + "PuntoControl/GetPuntoControlById"
let BUSQUEDA_BULTO: String = BASE_URL + "Bulto/GetListaBultoByOrden"
let BUSQUEDA_PALETA: String = BASE_URL + "PaletaConsolidada/GetListaPaletaByOrden"
let INSERT_BULTO: String = BASE_URL + "Bulto/InsertPaletaBultos"

let ALMACENES_DESTINO: String = BASE_URL + "PuntoControl/GetAll"
let TIPO_SEMIREMOLQUE: String = BASE_URL + "TipoRemolque/GetAll"
let PLACAS_SEMIREMOLQUE: String = BASE_URL + "NombreVehiculo/GetListaVehiculos"

let BUSQUEDA_GUIA_ENTRADA: String = BASE_URL + "TransporteConsolidado/GetTransporteByGuiaAntapaccay"
let ALMACEN_GUIA_ENTRADA: String = BASE_URL + "Bulto/GetBultoByGuiaAntapaccay"
let REGISTRO_ENTRADA: String = BASE_URL + "TransporteConsolidado/UpdateTCTVTR"
let ESTADO_RECORRIDO: String = BASE_URL + "TransporteRecorrido/GetTransporteRecorrido"
let REGISTRO_LLEGADA: String = BASE_URL + "TransporteConsolidado/UpdateTCandTRinsTP"


let OBTENER_GUIAS: String = BASE_URL + "TransporteRecorrido/GetSegComItemReporte"
let OBTENER_OBJECTO_GUI: String = BASE_URL + "GuiaAntapaccay/GetGuiaAntapaccayById"
let OBTENER_BULTO_BY_GUIA: String = BASE_URL + "Bulto/GetListaBultoByGuiaAntapaccay"
