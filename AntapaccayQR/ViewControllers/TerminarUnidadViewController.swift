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
import SwiftyJSON

class TerminarUnidadViewController: UIViewController {

    var data = Array<Unidad>()
    var validado = Dictionary<String, Any>()
    
    @IBOutlet weak var estadoButton: ButtonComponent!
    
    override func viewDidLoad() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cerrar Session", style: .plain, target: self, action: #selector(cerrarSession))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
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
        self.delay(seconds: 0.0, completion: {
            SwiftSpinner.show("Verificando Datos")
            Alamofire.request(CONSOLIDAR_TRANSPORTE, method: .post, parameters: paremetres, encoding: JSONEncoding.default)
                .responseJSON{
                    response in switch (response.result) {
                    case .success(let data):
                        
                        self.validado = data as! Dictionary<String, Any>
                        var imagenes_nuevas =  [UIImage]()
                        let fileManager = FileManager.default
                        for i in 0...CONTADOR_IMAGEN_3 - 1 {
                            let imagePath = (self.getDirectoryPath() as NSURL).appendingPathComponent("antapaccay3\(i).png")
                            let urlString: String = imagePath!.absoluteString
                            if fileManager.fileExists(atPath: urlString) {
                                let image = UIImage(contentsOfFile: urlString)!
                                imagenes_nuevas.append(image)
                            } else {
                                print("No Image")
                            }
                        }
                        CONTADOR_IMAGEN_3 = 0
                        
                        for item in imagenes_nuevas{
                            self.delay(seconds: 0.0, completion: {
                                Alamofire.upload(multipartFormData: { multipartFormData in
                                    multipartFormData.append((self.validado["Id"] as! String).data(using: String.Encoding.utf8)!, withName: "identificador")
                                    if item.pngData() != nil {
                                        multipartFormData.append(item.pngData()!, withName: "image", fileName: "\(String(Date().currentTimeMillis())).png",     mimeType: "image/png")
                                    }
                                    
                                }, usingThreshold: UInt64.init(),
                                   to: TRANSPORTE_IMAGENES,
                                   method: .post,
                                   headers: ["Content-type": "multipart/form-data"]){ (result) in
                                    switch result {
                                    case .success(let uploaddos, _, _):
                                        print("Succesfully uploaded")
                                        print(uploaddos)
                                        self.deleteDirectory()
                                        if let err = response.error{
                                            print(err)
                                            return
                                        }
                                    case .failure(let error):
                                        print("Error in upload: \(error.localizedDescription)")
                                        print(error)
                                    }
                                }
                            })
                        }
                        
                        let resultado = PMAlertController(title: "Exito", description: "Se consolido la Paleta" , image: UIImage(named: "exito"), style: .alert)
                        resultado.addAction(PMAlertAction(title: "Aceptar", style: .cancel))
                        self.present(resultado, animated: true, completion: nil)
                        self.estadoButton.isEnabled = false
                        SwiftSpinner.hide()
                        print(data)
                    case .failure(let error):
                        let errorMessaje = PMAlertController(title: "Error", description: "Error del servidor, revise su conexion de Internet", image: UIImage(named: "error"), style: .alert)
                        errorMessaje.addAction(PMAlertAction(title: "Aceptar", style: .cancel))
                        self.present(errorMessaje, animated: true, completion: nil)
                        SwiftSpinner.hide()
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
 
    @objc func cerrarSession(){
        UserDefaults.standard.set(VACIO, forKey: "user")
        UserDefaults.standard.set(VACIO, forKey: "pass")
        let loginView = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        present(loginView, animated: true, completion: nil)
    }
    
    func requestWith(endUrl: String, imageData: Data?, parameters: [String : Any], onCompletion: ((JSON?) -> Void)? = nil, onError: ((Error?) -> Void)? = nil){
        
        let url = "http://google.com" /* your API url */
        
        let headers: HTTPHeaders = [
            /* "Authorization": "your_access_token",  in case you need authorization header */
            "Content-type": "multipart/form-data"
        ]
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            
            if let data = imageData{
                multipartFormData.append(data, withName: "image", fileName: "image.png", mimeType: "image/png")
            }
            
        }, usingThreshold: UInt64.init(), to: url, method: .post, headers: headers) { (result) in
            switch result{
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    print("Succesfully uploaded")
                    if let err = response.error{
                        onError?(err)
                        return
                    }
                    onCompletion?(nil)
                }
            case .failure(let error):
                print("Error in upload: \(error.localizedDescription)")
                onError?(error)
            }
        }
    }
    
    func deleteDirectory() {
        let fileManager = FileManager.default
        let yourProjectImagesPath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("Antapaccay3")
        if fileManager.fileExists(atPath: yourProjectImagesPath) {
            try! fileManager.removeItem(atPath: yourProjectImagesPath)
        }
        let yourProjectDirectoryPath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("Antapaccay3")
        if fileManager.fileExists(atPath: yourProjectDirectoryPath) {
            try! fileManager.removeItem(atPath: yourProjectDirectoryPath)
        }
    }
    func getDirectoryPath() -> NSURL {
        let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("Antapaccay3")
        let url = NSURL(string: path)
        return url!
    }
}
