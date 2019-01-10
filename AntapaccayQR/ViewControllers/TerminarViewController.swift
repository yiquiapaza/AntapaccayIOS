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
    var listaGuias = Array<String>()
    var objectoCarga = Array<Item>()
    var objectoOrden = OrdenDTO()
    var objectoTransporte = TransporteDTO()
    var id_qr = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem     = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cerrar Sesion", style: .plain, target: nil, action: nil)
    }

    
    @IBAction func terminarBulto(_ sender: UIButton) {
    
        var guias : [[String:Any]] = []
        for item in self.listaGuias {
            let temp : Parameters = [
                ID: CONST_ID,
                ROW_VERSION : CONST_ROW_VERSION,
                NUMERO_GUIA : item
            ]
            guias.append(temp)
        }
        
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
                    guias
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
        self.delay(seconds: 0.0, completion: {
            SwiftSpinner.show("Verificando API")
            Alamofire.request(request).responseJSON{ response in
                switch (response.result){
                case .success(let data):
                    let out_data = data as! [Dictionary<String,AnyObject>]
                    let paleta_nuevo = out_data[0]["idPaleta"] as! String
                    let response_nuevo = response.result.value as! [Dictionary<String, AnyObject>]
                    self.id_qr = response_nuevo[0]["Id"] as! String
                    self.generarQR.isEnabled = true
                    
                    self.delay(seconds: 0.0, completion: {
                        
                        SwiftSpinner.show("Subiendo Imagenes")
                        
                        var imagenes_nuevas =  [UIImage]()
                        let fileManager = FileManager.default
                        for i in 0...CONTADOR_IMAGEN_2 - 1 {
                            let imagePath = (self.getDirectoryPath() as NSURL).appendingPathComponent("antapaccay2\(i).png")
                            let urlString: String = imagePath!.absoluteString
                            if fileManager.fileExists(atPath: urlString) {
                                let image = UIImage(contentsOfFile: urlString)!
                                imagenes_nuevas.append(image)
                            } else {
                                print("No Image")
                            }
                        }
                        CONTADOR_IMAGEN_2 = 0
                        for item in imagenes_nuevas{
                            self.delay(seconds: 0.0, completion: {
                                Alamofire.upload(multipartFormData: { multipartFormData in
                                    multipartFormData.append((self.id_qr).data(using: String.Encoding.utf8)!, withName: "identificador")
                                    multipartFormData.append("BULTO".data(using: String.Encoding.utf8)!, withName: "tipoImagen")
                                    if item.pngData() != nil {
                                        multipartFormData.append(item.pngData()!, withName: "image", fileName: "\(String(Date().currentTimeMillis())).png", mimeType: "image/png")
                                    }
                                    
                                }, usingThreshold: UInt64.init(),
                                   to: PALETA_IMAGENES,
                                   method: .post,
                                   headers: ["Content-type": "multipart/form-data"]){ (result) in
                                    switch result {
                                    case .success(let uploaddos, _, _):
                                        print("Succesfully uploaded")
                                        print(uploaddos)
                                        if (paleta_nuevo != "00000000-0000-0000-0000-000000000000"){
                                            Alamofire.upload(multipartFormData: { multipartFormData in
                                                multipartFormData.append(paleta_nuevo.data(using: String.Encoding.utf8)!, withName: "identificador")
                                                multipartFormData.append("PALETA".data(using: String.Encoding.utf8)!, withName: "tipoImagen")
                                                if item.pngData() != nil {
                                                    multipartFormData.append(item.pngData()!, withName: "image", fileName: "\(String(Date().currentTimeMillis())).png", mimeType: "image/png")
                                                }
                                            }, usingThreshold: UInt64.init(),
                                               to: BULTOS_IMAGENES,
                                               method: .post,
                                               headers: ["Content-type": "multipart/form-data"]){ (result) in
                                                switch result {
                                                case .success(let uploaddos, _ , _):
                                                    print(uploaddos)
                                                    let parameters : Parameters = [
                                                        "Logical": "AND",
                                                        "PropertyName": "id",
                                                        "Value": paleta_nuevo,
                                                        "Operator": "Equals"
                                                    ]
                                                    Alamofire.request(TRANSPORTE_CONSOLIDADES_IMAGENES, method: .post, parameters: parameters, encoding: JSONEncoding.default)
                                                        .responseJSON(){
                                                            response in switch response.result{
                                                            case .success(let data):
                                                                let out = data as! [Dictionary<String,Any>]
                                                                var transporte = String()
                                                                transporte  = out[0]["idTransporteConsolidado"] as! String
                                                                let constante = "00000000-0000-0000-0000-000000000000"
                                                                if !out.isEmpty{
                                                                    if transporte != constante {
                                                                        Alamofire.upload(multipartFormData: { multipartFormData in
                                                                            multipartFormData.append(paleta_nuevo.data(using: String.Encoding.utf8)!, withName: "identificador")
                                                                            multipartFormData.append("TRANSPORTE".data(using: String.Encoding.utf8)!, withName: "tipoImagen")

                                                                        }, usingThreshold: UInt64.init(),
                                                                           to: BULTOS_IMAGENES,
                                                                           method: .post,
                                                                           headers: ["Content-type": "multipart/form-data"]) { (result) in
                                                                            switch result{
                                                                            case .success(let uploaddos, _, _):
                                                                                print(uploaddos)
                                                                                if let err = response.error{
                                                                                    print(err)
                                                                                    return
                                                                                }
                                                                            case .failure(let error):
                                                                                print("Error in upload: \(error.localizedDescription)")
                                                                                print(error)
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                                print(data)
                                                            case .failure(let error):
                                                                print(error)
                                                            }
                                                        }
                                                    if let err = response.error{
                                                        print(err)
                                                        return
                                                    }
                                                case .failure( let error):
                                                    print("Error in upload: \(error.localizedDescription)")
                                                    print(error)
                                                }
                                            }
                                        }
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
                    })
                    
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
        bulto.setFechaRecepcion(fechaRecepcion: Int(Date().currentTimeMillis()))
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
    @objc func cerrarSession(){
        UserDefaults.standard.set(VACIO, forKey: "user")
        UserDefaults.standard.set(VACIO, forKey: "pass")
        let loginView = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        present(loginView, animated: true, completion: nil)
    }
    
    func deleteDirectory() {
        let fileManager = FileManager.default
        let yourProjectImagesPath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("Antapaccay_2")
        if fileManager.fileExists(atPath: yourProjectImagesPath) {
            try! fileManager.removeItem(atPath: yourProjectImagesPath)
        }
        let yourProjectDirectoryPath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("Antapaccay_2")
        if fileManager.fileExists(atPath: yourProjectDirectoryPath) {
            try! fileManager.removeItem(atPath: yourProjectDirectoryPath)
        }
    }
    func getDirectoryPath() -> NSURL {
        let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("Antapaccay_2")
        let url = NSURL(string: path)
        return url!
    }
}
