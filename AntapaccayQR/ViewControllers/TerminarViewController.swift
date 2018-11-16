//
//  TerminarViewController.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 11/7/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import UIKit
import Alamofire
import SwiftSpinner

class TerminarViewController: UIViewController {
    
    var shouldHideNavBar = false
    
    
    @IBOutlet weak var generarQR: UIButton!
    var objectoCarga = Array<Item>()
    var objectoOrden = OrdenDTO()
    var objectoTransporte = TransporteDTO()
    var id_qr = ""

    override func viewDidLoad() {
        
//        let data = self.parent as! TabBarViewController
//        self.objectoCarga =  data.objetoCarga
//        self.objectoOrden = data.objetoOrden
        self.generarQR.isEnabled = false
        self.navigationController?.isNavigationBarHidden = true
        super.viewDidLoad()
    }

    
    @IBAction func terminarBulto(_ sender: UIButton) {
    
    
        let bulto: Bulto = inicarBulto()
        var items : [[String: Any]] = []
        
        for item in self.objectoCarga{
            let temp:Parameters = [
                ID: CONST_ID,
                ROW_VERSION: CONST_ROW_VERSION,
                NUMERO_ITEM: item.getNumeroItem(),
                DESCRIPCION: item.getDescripcion(),
                CANTIDAD_GENERAL: item.getCantidad(),
                ID_ORDEN_DETALLE: item.getIdOrdenDetalle(),
                ID_PROVEEDOR : item.getIdProveedor(),
                TRANSPORTISTA: item.getTransportista(),
                VERIFICADO_ALMACEN: item.getVerificadoAlmacen()
            ]
            items.append(temp)
        }
        
        let datos: [[String:Any]] = [
            [
                "bulto": [
                    ID_ALMACEN_RECEPCION : VACIO,
                    ALMACEN_DESTINO : VACIO,
                    NOMBRE_PROVEEDOR : VACIO,
                    NOMBRE_ALMACEN : self.objectoTransporte.getNombreAlmacen(),
                    TIPO_ORDEN : self.objectoOrden.getTipoOrden(),
                    VALOR_ORDEN : self.objectoOrden.getValorOrden(),
                    ESTADO_BULTO: bulto.getEstadoBulto(),
                    JSON_PESO : bulto.getPeso(),
                    JSON_ALTO : bulto.getAlto(),
                    JSON_ANCHO : bulto.getAncho(),
                    JSON_LARGO : bulto.getLargo(),
                    JSON_FRAGIL : bulto.getFragil(),
                    JSON_SOBREDIMENSIONADO : bulto.getSobredimensionado(),
                    JSON_CARGA_PELIGROSA : bulto.getCargaPeligrosa(),
                    JSON_IMPORTACION : bulto.getImportacion(),
                    JSON_NACIONAL : bulto.getNacional(),
                    OS : VACIO,
                    PR : VACIO,
                    PLAQUETEO :VACIO,
                    CAMPO_ID:VACIO,
                    COMENTARIO: bulto.getComentario(),
                    COMENTARIO_ID: bulto.getComentarioID(),
                    FECHA_RECEPCION:bulto.getFechaRecepcion(),
                    CODIGO_TRANSPORTISTA: self.objectoTransporte.getCodigoTransportista(),
                    TRANSPORTISTA : self.objectoTransporte.getNombreTransportista(),
                    UBICACION: VACIO,
                    JSON_GENERAL: bulto.getGeneral(),
                    JSON_COMPONENTE : bulto.getComponente(),
                    JSON_PALETA_CONSOLIDADA : bulto.getPaletaCOnsolidada(),
                    JSON_UNIDAD_COMPLETA : bulto.getUnidadCompleta(),
                    ID: bulto.getId(),
                    ROW_VERSION : bulto.getRowVersion()
                ],
                "Orden": [
                    TIPO_ORDEN: objectoOrden.getTipoOrden(),
                    VALOR_ORDEN : objectoOrden.getValorOrden()
                ],
                "listaBO":[
                    items
                ],
                "listaGuia": [
                    []
                ],
                "listaOD": [
                    []
                ]
            ]
        ]
        var request = URLRequest(url: URL(string: CREATE_BULTO)!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let json = try? JSONSerialization.data(withJSONObject: datos)
        request.httpBody = json
        self.delay(seconds: 5.0, completion: {
            SwiftSpinner.show("Verificando API")
            Alamofire.request(request).responseJSON{ response in
                switch (response.result){
                case .success:
                    let response_nuevo = response.result.value as! [Dictionary<String, AnyObject>]
                    self.id_qr = response_nuevo[0]["Id"] as! String
                    self.generarQR.isEnabled = true
                    SwiftSpinner.hide()
                case .failure(let error):
                    print(error)
                    SwiftSpinner.hide()
                }
            }
        })
    }
    
    func inicarBulto() -> Bulto {
        let bulto = Bulto()
        bulto.setIdAlmacenRecepcion(idAlmacenRecepcion: VACIO)
        bulto.setAlmacenDestino(almacenDestino: VACIO)
        bulto.setNombreProveedor(nombreProveedor: VACIO)
        bulto.setNombreAlmacen(nombreAlmacen: VACIO)
        bulto.setTipoOrden(tipoOrden: objectoOrden.getTipoOrden())
        bulto.setValorOrden(valorOrden: objectoOrden.getValorOrden())
        bulto.setEstadoBulto(estadoBulto: "1")
        bulto.setPeso(peso: PESO)
        bulto.setAlto(alto: ALTO)
        bulto.setAncho(ancho: ANCHO)
        bulto.setLargo(largo: LARGO)
        bulto.setFragil(fragil: FRAGIL)
        bulto.setsobredimensionado(sobredimensionamiento: SOBREDIMENSIONADO)
        bulto.setCargaPeligrosa(cargaPeligrosa: CARGA_PELIGROSA)
        bulto.setImportacion(importacion: IMPORTACION)
        bulto.setNacional(nacional: NACIONAL)
        bulto.setFechaRecepcion(fechaRecepcion: obtenerFecha())
        bulto.setCodigoTransportista(codigoTransportista: "No hay")
        bulto.setTransportista(transportista: "No Hay")
        bulto.setGeneral(general: GENERAL)
        bulto.setComponente(componente: COMPONENTE)
        bulto.setPaletaConsolidada(paletaConsolidada: PALETA_CONSOLIDADA)
        bulto.setUnidadCompleta(unidadCompleta: UNIDAD_COMPLETA)
        bulto.setId(id: CONST_ID)
        bulto.setRowVersion(rowVersion: CONST_ROW_VERSION)
        return bulto
    }
    
    func obtenerFecha() -> Int {
        
        let anio = Calendar.current.component(.year, from: Date())
        let mes = Calendar.current.component(.month, from: Date())
        let dia = Calendar.current.component(.day, from: Date())
        let fechaCadena: String = String(anio) + String(mes) + String(dia)
        
        return Int(fechaCadena)!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is QRViewController {
            let vc = segue.destination as! QRViewController
            vc.id_qr_code = self.id_qr
        }
    }
    
    func delay(seconds: Double, completion: @escaping () -> ()) {
        let popTime = DispatchTime.now() + Double(Int64( Double(NSEC_PER_SEC) * seconds )) / Double(NSEC_PER_SEC)
        
        DispatchQueue.main.asyncAfter(deadline: popTime) {
            completion()
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(shouldHideNavBar, animated: animated)
    }
}
