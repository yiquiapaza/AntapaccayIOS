//
//  TerminarBultoViewController.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 11/26/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import UIKit
import Alamofire
import SwiftSpinner
import PMAlertController

class TerminarBultoViewController: UIViewController {

    var listaPaleta  = Array<Paleta>()
    
    override func viewDidLoad() {
        let data = self.parent as! TabBarBultoViewController
        self.listaPaleta =  data.listaPaleta
        super.viewDidLoad()
    }

    @IBAction func terminar(_ sender: UIButton) {
        
        var listaBultos: [Parameters] = []
        for item in listaPaleta{
            let temp : Parameters = [
                "Id": item.getId(),
                "idPaleta": CONST_ID,
                "idAlmacenRecepcion": item.getIdAlmacenRecepcion(),
                "numeroBulto": item.getNumeroBulto(),
                "codigo": item.getCodigo(),
                "nombreProveedor": item.getNombreProveedor(),
                "nombreAlmacen": item.getNombreAlmacen(),
                "tipoOrden": item.getTipoOrden(),
                "valorOrden": item.getValorOrden(),
                "estadoBulto": item.getEstadoBulto(),
                "peso": item.getPeso(),
                "alto":item.getAlto(),
                "ancho": item.getAncho(),
                "largo": item.getLarog(),
                "fragil": item.getFragil(),
                "sobredimensionado": item.getSobredimensionado(),
                "cargaPeligrosa": item.getCargaPeligrosa(),
                "importacion": item.getImportacion(),
                "nacional": item.getNacional(),
                "fechaRecepcion": item.getFechaRecepcion(),
                "transportista": item.getTransportista(),
                "ubicacion" : item.getUbicacion(),
                "general": item.getGeneral(),
                "componente": item.getComponente(),
                "unidadCompleta": item.getUnidadCompleta(),
                "RowVersion": item.getRowVersion()
            ]
            listaBultos.append(temp)
        }
        
        let paleta : Parameters = [
            "paleta":[
                "Id": CONST_ID,
                "idAlmacenRecepcion": "",
                "idTransporteCosolidado": CONST_ID,
                "codigoQR": "",
                "peso" : PESO_BULTO,
                "alto" : ALTO_BULTO,
                "largo" : LARGO_BULTO,
                "ancho": ANCHO_BULTO,
                "fragil": false,
                "sobredimensionado" : false,
                "cargaPeligrosa" : false,
                "importacion": false,
                "nacional":false,
                "fechaRecepcion" : 0,
                "idDiscrepancia": "",
                "campoDiscrepancia": "",
                "numeroWaybill": "",
                "codigoTransportista": "",
                "transportista": "",
                "RowVersion": CONST_ROW_VERSION
            ],
            "listaBultos": listaBultos
        ]
        
        self.delay(seconds: 3.0, completion: {
            SwiftSpinner.show("Verficando Datos")
            Alamofire.request(INSERT_BULTO, method: .post, parameters: paleta, encoding: JSONEncoding.default)
                .responseJSON(){
                    response in switch response.result{
                    case .success(let data):
                        print(data)
                        SwiftSpinner.hide()
                        let datos = PMAlertController(title: "Exit", description: "La operacion se realizo exitasamente", image: UIImage(named: "exito"), style: .alert)
                        datos.addAction(PMAlertAction(title: "Aceptar", style: .cancel))
                        self.present(datos, animated: true, completion: nil)
                    case .failure(let error):
                        print(error)
                        SwiftSpinner.hide()
                        let datos = PMAlertController(title: "Error", description: "Verifique los datos ingresados y su conneccion a Internet", image: UIImage(named: "error"), style: .alert)
                        datos.addAction(PMAlertAction(title: "Aceptar", style: .cancel))
                        self.present(datos, animated: true, completion: nil)
                    }
            }
        })
    }
    
    func delay(seconds: Double, completion: @escaping () -> ()) {
        let popTime = DispatchTime.now() + Double(Int64( Double(NSEC_PER_SEC) * seconds )) / Double(NSEC_PER_SEC)
        
        DispatchQueue.main.asyncAfter(deadline: popTime) {
            completion()
        }
    }
    
    @IBAction func backMenu(_ sender: UIButton) {
        let menuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        navigationController?.pushViewController( menuViewController, animated: true)
    }
}
