//
//  TerminarUnidadViewController.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 12/18/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import UIKit
import Alamofire
import SwiftSpinner
import PMAlertController

class TerminarUnidadViewController: UIViewController {

    var data = Array<Unidad>()
    
    
    @IBOutlet weak var estadoButton: ButtonComponent!
    
    override func viewDidLoad() {
        let new_data = self.parent as! TabBarUnidadViewController
        self.data = new_data.listaPaletas
        super.viewDidLoad()
    }

    @IBAction func backMenu(_ sender: UIButton) {
        let menuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        navigationController?.pushViewController( menuViewController, animated: true)
    }
    
    @IBAction func terminarProceso(_ sender: UIButton) {
        
        let transporte: Parameters = [
            "Id": CONST_ID,
            "idPuntoPartida": "",// servicio
            "nombrePuntoPartida": "", // servicio
            "codigoVehiculo": VACIO,
            "placaRemolque": PLACA_SEMIREMOLQUE,
            "codigoTipoRemolque": TIPO_SEMIREMOLQUE_CODIGO,
            "tipoRemolque": TIPO_SEMIREMOLQUE_CONST ,
            "codigoConductor": VACIO,
            "nombreConductor": VACIO,
            "servicioExpreso": SERVICIO_EXPRESS,
            "precio": 0,
            "estadoTransporte": "1",
            "peso": PESO_LISTA,
            "codigoDestino": CODIGO_DESTINO,
            "nombreDestino": NOMBRE_DESTINO,
            "codigoConfiguracionRemolque": "",// servicio placa remolque
            "configuracionRemolque": "",// servicio placa remolque
            "fechaCreacion": Int(NSDate().timeIntervalSince1970),
            "guiaTransportista": false,
            "guiaAntapaccay": false,
            "codigoTransportista": CODIGO_TRANSPORTISTA_LISTA,
            "transportista": CODIGO_TRANSPORTISTA_LISTA,
            "tipoCreado": "2",
            "RowVersion": CONST_ROW_VERSION
        ]
        
        var listaPaletas: [Parameters] = []
        
        for item in data {
            let temp: Parameters = [
                "Id" : item.getId(),
                "idAlmacenRecepcion" : item.getIdAlmacenRecepcion(),
                "idTransporteConsolidado": item.getIdTransporteConsolidado(),
                "numeroPaleta": item.getNumeroPaleta(),
                "codigo": item.getCodigo(),
                "codigoQR": item.getCodigoQR(),
                "numeroWaybill": item.getNumeroWaybill(),
                "peso": item.getPeso(),
                "alto": item.getAlto(),
                "largo": item.getLargo(),
                "ancho": item.getAncho(),
                "fragil": item.getFragil(),
                "sobredimensionado": item.getSobredimensionado(),
                "cargaPeligrosa": item.getCargaPeligrosa(),
                "importacion" : item.getImportacion(),
                "nacional" : item.getNacional(),
                "fechaRecepcion": item.getFechaRecepcion(),
                "idDiscrepancia": item.getIdDiscrepancia(),
                "campoDiscrepancia": item.getCampoDiscrepancia(),
                "imagenes": item.getImagenes(),
                "codigoTransportista": item.getCodigoTransportista(),
                "transportista": item.getTransportista(),
                "RowVersion": item.getRowVersion()
            ]
            listaPaletas.append(temp)
        }
        
        let paremetres : Parameters = [
            "transporte": transporte,
            "listaPaletas": listaPaletas,
            "listaGuias": [[]],
            "transporteVehiculo": [[]]
        ]
        self.delay(seconds: 3.0, completion: {
            SwiftSpinner.show("Verificando Datos")
            Alamofire.request(CONSOLIDAR_TRANSPORTE, method: .post, parameters: paremetres, encoding: JSONEncoding.default)
                .responseJSON{
                    response in switch (response.result) {
                    case .success(let data):
                        let resultado = PMAlertController(title: "Exito", description: "Se consolido la Paleta" , image: UIImage(named: "exito"), style: .alert)
                        resultado.addAction(PMAlertAction(title: "Aceptar", style: .cancel))
                        self.present(resultado, animated: true, completion: nil)
                        self.estadoButton.isEnabled = false
                        print(data)
                    case .failure(let error):
                        let errorMessaje = PMAlertController(title: "Error", description: "Error del servidor, revise su conexion de Internet", image: UIImage(named: "error"), style: .alert)
                        errorMessaje.addAction(PMAlertAction(title: "Aceptar", style: .cancel))
                        self.present(errorMessaje, animated: true, completion: nil)
                        print(error)
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
    
}
