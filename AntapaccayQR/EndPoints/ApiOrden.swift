//
//  ApiOrden.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 10/31/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import Foundation

import Alamofire

func ObtenerOrdenDet(_parametros: Orden) -> Array<OrdenDetalle> {
    var listaOrdenDetalle =  Array<OrdenDetalle>()
    let parametros: Parameters = [
        VALOR_ORDEN : _parametros.getValorOrden(),
        TIPO_ORDEN: _parametros.getTipoOrden(),
        ID_COMPRADOR: _parametros.getIdCmprador(),
        CODIGO_DISTRITO: _parametros.getCodigoDistrito(),
        PRICE_CODE: _parametros.getPriceCode()
    ]
    Alamofire.request(LIST_ORDEN_DET, method: .post,parameters: parametros, encoding: JSONEncoding.default)
        .responseJSON(){ response in
            switch response.result {
            case .success:
                //print(response.result.value)
                let ordenesDetalle = response.result.value as! [Dictionary<String, AnyObject>]
                var listaOrdenDetalleIn =  Array<OrdenDetalle>()
                var item: OrdenDetalle
                var cantidad_po: Int = 0
                var cantidad_recibida:Int = 0
                for ordenDetalle in ordenesDetalle {
                    item = OrdenDetalle()
                    //item.setId(id: ordenDetalle[ID] as! String)
                    item.setNumeroItem(numeroItem: ordenDetalle[NUMERO_ITEM] as! String)
                    item.setNombreProoveedor(nombreProveedor: ordenDetalle[NOMBRE_PROVEEDOR] as! String)
                    item.setDescripcion(descripcion: ordenDetalle[DESCRIPCION] as! String)
                    item.setUnidad(unidad: ordenDetalle[UNIDAD] as! String)
                    item.setAlmacen(almacen: ordenDetalle[ALMACEN] as! String)
                    cantidad_po = ordenDetalle[CANTIDAD_PO] as! Int
                    cantidad_recibida = ordenDetalle[CANTIDAD_RECIBIDA] as! Int
                    item.setDisponibilidad(disponibilidad: cantidad_po-cantidad_recibida)
                    listaOrdenDetalleIn.append(item)
                }
                listaOrdenDetalle = listaOrdenDetalleIn
//                for prueba in listaOrdenDetalle {
//                    print(prueba.getId())
//                    print(prueba.getNumeroItem())
//                    print(prueba.getDisponibilidad())
//                }
            case .failure( let error):
                print(error)
            }
    }
    return listaOrdenDetalle
}

