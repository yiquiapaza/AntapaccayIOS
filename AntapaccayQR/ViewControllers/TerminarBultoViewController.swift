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
import SwiftyJSON

class TerminarBultoViewController: UIViewController {

    var imagenesDirectorio  = [UIImage()]
    var listaPaleta  = Array<Paleta>()
    var validado = Dictionary<String, Any>()
    override func viewDidLoad() {
        //self.getImageFromDocumentDirectory()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cerrar Session", style: .plain, target: self, action: #selector(cerrarSession))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
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
        
        self.delay(seconds: 0.0, completion: {
            SwiftSpinner.show("Verficando Datos")
            Alamofire.request(INSERT_BULTO, method: .post, parameters: paleta, encoding: JSONEncoding.default)
                .responseJSON(){
                    response in switch response.result{
                    case .success(let data):
                        print(data)
                        self.validado = data as! Dictionary<String, Any>
                        var imagenes_nuevas =  [UIImage]()
                        let fileManager = FileManager.default
                        for i in 0...CONTADOR_IMAGEN - 1 {
                            let imagePath = (self.getDirectoryPath() as NSURL).appendingPathComponent("antapaccay\(i).png")
                            let urlString: String = imagePath!.absoluteString
                            if fileManager.fileExists(atPath: urlString) {
                                let image = UIImage(contentsOfFile: urlString)!
                                imagenes_nuevas.append(image)
                            } else {
                                print("No Image")
                            }
                        }
                        CONTADOR_IMAGEN = 0
                        for item in imagenes_nuevas{
                            self.delay(seconds: 0.0, completion: {
                                Alamofire.upload(multipartFormData: { multipartFormData in
                                    multipartFormData.append((self.validado["Id"] as! String).data(using: String.Encoding.utf8)!, withName: "identificador")
                                    if item.pngData() != nil {
                                        multipartFormData.append(item.pngData()!, withName: "image", fileName: "\(String(Date().currentTimeMillis())).png",     mimeType: "image/png")
                                    }
                                    
                                }, usingThreshold: UInt64.init(),
                                   to: PALETA_IMAGENES,
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
    
    @objc func cerrarSession(){
        UserDefaults.standard.set(VACIO, forKey: "user")
        UserDefaults.standard.set(VACIO, forKey: "pass")
        let loginView = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        present(loginView, animated: true, completion: nil)
    }
    
    func requestWith(endUrl: String, imageData: Data?, parameters: [String : Any], onCompletion: ((JSON?) -> Void)? = nil, onError: ((Error?) -> Void)? = nil){
        
        let url = PALETA_IMAGENES /* your API url */
        
        let headers: HTTPHeaders = [
            /* "Authorization": "your_access_token",  in case you need authorization header */
            "Content-Type": "multipart/form-data"
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
    
    func getImageFromDocumentDirectory() {
        let fileManager = FileManager.default
        let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("Antapaccay")
        if fileManager.fileExists(atPath: path){
            for i in 0...(CONTADOR_IMAGEN - 1){
                print(i)
                let imagePath = (self.getDirectoryPath() as NSURL).appendingPathComponent("antapaccay\(i).png")
                let urlString: String = imagePath!.absoluteString
                if fileManager.fileExists(atPath: urlString){
                    let imagen = UIImage(contentsOfFile: urlString)
                    imagenesDirectorio.append(imagen!)
                    print("se guardo")
                }
                else{
                    print("no hay imagen")
                }
            }
        }
        CONTADOR_IMAGEN = 0
    }
    
    func deleteDirectory() {
        let fileManager = FileManager.default
        let yourProjectImagesPath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("Antapaccay")
        if fileManager.fileExists(atPath: yourProjectImagesPath) {
            try! fileManager.removeItem(atPath: yourProjectImagesPath)
        }
        let yourProjectDirectoryPath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("Antapaccay")
        if fileManager.fileExists(atPath: yourProjectDirectoryPath) {
            try! fileManager.removeItem(atPath: yourProjectDirectoryPath)
        }
    }
    func getDirectoryPath() -> NSURL {
        let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("Antapaccay")
        let url = NSURL(string: path)
        return url!
    }
    
}
extension Date {
    func currentTimeMillis() -> Int64! {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}
