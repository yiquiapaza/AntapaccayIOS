//
//  AlmacenViewController.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 12/6/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import UIKit
import Alamofire
import SwiftSpinner
import PMAlertController

class AlmacenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    var bultos = Array<Paleta>()
    var bultosConfi = Array<Paleta>()
    var cellReuseIdentifier:String = "cell"
    var dto = Paleta()
    
    @IBOutlet weak var tableAlamacen: UITableView!
    @IBOutlet weak var buscarGuia: UITextField!
    
    override func viewDidLoad() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cerrar Session", style: .plain, target: self, action: #selector(cerrarSession))
        tableAlamacen.delegate = self
        tableAlamacen.dataSource = self
        tableAlamacen.register(UINib(nibName: "AlmacenComponentTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
      
        super.viewDidLoad()
    }

    
    @IBAction func obtenerGuias(_ sender: Any) {
        let parametres:Parameters = [
            "Logical": "AND",
            "PropertyName": "numeroGuia",
            "Value": buscarGuia.text!,
            "Operator": "Equals"
        ]
        delay(seconds: 3.0, completion: {
            SwiftSpinner.show("Cargando")
            Alamofire.request(OBTENER_OBJECTO_GUI, method: .post, parameters: parametres, encoding: JSONEncoding.default)
                .responseJSON(){
                    response in switch response.result{
                    case .success(let data):
                        let out = data as! [Dictionary<String,AnyObject>]
                        var obj = Array<DataDTO>()
                        for item in out {
                            let _a = DataDTO()
                            _a.setData1(data1: item["almacenDestino"] as! String)
                            obj.append(_a)
                        }
                        if obj.isEmpty{
                            let aceptar = PMAlertController(title: "Precaucion", description: "Revise si el bulto existe", image: UIImage(named: "precaucion"), style: .alert)
                            aceptar.addAction(PMAlertAction(title: "Aceptar", style: .cancel))
                            self.present(aceptar, animated: true, completion: nil)
                            SwiftSpinner.hide()
                        }
                        else if !obj.isEmpty {
                            let almacenDestino = obj[0].getData1()
                            let parameter: Parameters = [
                                "numeroGuia": self.buscarGuia.text!,
                                "estadoBulto": "3",
                                "almacenDestino": almacenDestino,
                                "recepcionAlmacen": ""
                            ]
                            self.delay(seconds: 3.0, completion: {
                                SwiftSpinner.show("Cargando")
                                Alamofire.request(OBTENER_BULTO_BY_GUIA, method: .post, parameters: parameter, encoding: JSONEncoding.default)
                                    .responseJSON(){
                                        response in switch response.result{
                                        case .success(let data):
                                            let out = data as! [Dictionary<String,AnyObject>]
                                            if out.isEmpty {
                                                let aceptar = PMAlertController(title: "Precaucion", description: "Revise si el bulto existe", image: UIImage(named: "precaucion"), style: .alert)
                                                aceptar.addAction(PMAlertAction(title: "Aceptar", style: .cancel))
                                                self.present(aceptar, animated: true, completion: nil)
                                                SwiftSpinner.hide()
                                            }
                                            else {
                                                for item in out {
                                                    let _a = Paleta()
                                                    _a.setId(Id: item["Id"] as! String)
                                                    _a.setIdPaleta(IdPaleta: item["idPaleta"] as! String)
                                                    _a.setIdAlmacenRecepcion(IdAlmacenRecepcion: item["idAlmacenRecepcion"] as! String)
                                                    _a.setAlmacenDestino(AlmacenDestino: item["almacenDestino"] as! String)
                                                    _a.setNumeroBulto(numeroBulto: item["numeroBulto"] as! Int)
                                                    _a.setCodigo(Codigo: item["codigo"] as! String)
                                                    _a.setNombreProveedor(nombreProveedor: item["nombreProveedor"] as! String)
                                                    _a.setNombreAlmacen(nombreAlmacen: item["nombreAlmacen"] as! String)
                                                    _a.setTipoOrden(tipoOrden: item["tipoOrden"] as! String)
                                                    _a.setValorOrden(valorOrden: item["valorOrden"] as! String)
                                                    _a.setEstadoBulto(EstadoBulto: item["estadoBulto"] as! String)
                                                    _a.setPeso(peso: item["peso"] as! Double)
                                                    _a.setAlto(alto: item["alto"] as! Double)
                                                    _a.setAncho(ancho: item["ancho"] as! Double)
                                                    _a.setLargo(largo: item["largo"] as! Double)
                                                    _a.setFragil(fragil: item["fragil"] as! Bool)
                                                    _a.setSobredimensionado(sobredimensionado: item["sobredimensionado"] as! Bool)
                                                    _a.setCargaPeligrosa(cargaPeligrosa: item["cargaPeligrosa"] as! Bool)
                                                    _a.setImportacion(importancia: item["importacion"] as! Bool)
                                                    _a.setNacional(nacional: item["nacional"] as! Bool)
                                                    _a.setOS(OS: item["os"] as! String)
                                                    _a.setPR(PR: item["pr"] as! String)
                                                    _a.setPlaqueteo(Plaqueteo: item["plaqueteo"] as! String)
                                                    _a.setCampoID(CampoID: item["campoID"] as! String)
                                                    _a.setComentario(Comentario: item["comentario"] as! String)
                                                    _a.setComentarioID(ComentarioID: item["comentarioID"] as! String)
                                                    _a.setIdDiscrepancia(IdDiscrepancia: item["idDiscrepancia"] as? String ?? "")
                                                    _a.setCampoDiscrepancia(CampoDiscrepancia: item["campoDiscrepancia"] as? String ?? "")
                                                    _a.setFechaRecepcion(fecha: item["fechaRecepcion"] as! Int)
                                                    _a.setRecepcionAlmacen(RecepcionAlmacen: item["recepcionAlmacen"] as? Bool ?? false)
                                                    _a.setFechaRecepcionAlmacen(FechaRecepcionAlmacen: item["fechaRecepcionAlmacen"] as? Int ?? 0)
                                                    _a.setCodigoTransportista(CodigoTransportista: item["codigoTransportista"] as! String)
                                                    _a.setTransportista(transportista: item["transportista"] as! String)
                                                    _a.setUbicacion(ubicacion: item["ubicacion"] as? String ?? "")
                                                    _a.setGeneral(general: item["general"] as? Bool ?? false)
                                                    _a.setComponente(componente: item["componente"] as? Bool ?? false)
                                                    _a.setPaletaConsolidada(PaletaConsolidada: item["paletaConsolidada"] as? Bool ?? false)
                                                    _a.setUnidadCompleta(unidad: item["unidadCompleta"] as? Bool ?? false)
                                                    _a.setImagenes(Imagenes: item["imagenes"] as? String ?? "" )
                                                    _a.setCompleteOrder(CompleteOrder: item["completeOrder"] as? Bool ?? false)
                                                    _a.setDistrictCode(DistrictCode: item["districtCode"] as? String ?? "")
                                                    _a.setRowVersion(rowVersion: item["RowVersion"] as! String)
                                                    _a.setCodigoQR(CodigoQr: item["codigoQR"] as? String ?? "")
                                                    if _a.getEstadoBulto() == "3" {
                                                        self.bultos.append(_a)
                                                    }
                                                    else {
                                                        self.bultosConfi.append(_a)
                                                    }
                                                    
                                                    self.tableAlamacen.reloadData()
                                                }
                                                SwiftSpinner.hide()
                                            }
                                            
                                            print(data)
                                        case .failure(let error):
                                            print(error)
                                            let errorNotification = PMAlertController(title: "Error", description: "no se pudo obtener los datos, revice su conexion a internet", image: UIImage(named:"error"), style: .alert)
                                            errorNotification.addAction(PMAlertAction(title: "Aceptar", style: .cancel))
                                            self.present(errorNotification, animated: true, completion: nil)
                                            SwiftSpinner.hide()
                                        }
                                }
                            })
                        }
                    case .failure(let error):
                        print(error)
                        let errorNotification = PMAlertController(title: "Error", description: "no se pudo obtener los datos, revice su conexion a internet", image: UIImage(named:"error"), style: .alert)
                        errorNotification.addAction(PMAlertAction(title: "Aceptar", style: .cancel))
                        self.present(errorNotification, animated: true, completion: nil)
                        SwiftSpinner.hide()
                    }
            }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bultos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableAlamacen.dequeueReusableCell(withIdentifier: "cell",for:  indexPath) as! AlmacenComponentTableViewCell
        cell.numeroItem.text = self.bultos[indexPath.row].getCodigo()
        cell.numeroProducto.text = self.bultos[indexPath.row].getValorOrden()
        cell.nombreProveedor.text = self.bultos[indexPath.row].getNombreProveedor()
        cell.nombreAlmacen.text = self.bultos[indexPath.row].getNombreAlmacen()
        cell.nombreTransporte.text = self.bultos[indexPath.row].getTransportista()
        cell.buttonConfirm.addTarget(self, action: #selector(hacerClick(_:)), for: .touchDown)
        cell.buttonConfirm.tag = indexPath.row
        return cell
    }
    
    @objc func hacerClick( _ sender: UIButton){
        let item = self.bultos[sender.tag]
        self.bultos.remove(at: sender.tag)
        self.tableAlamacen.reloadData()
        self.bultosConfi.append(item)
        
        var nuevo : [[String:Any]] = []
            let _item : [String:Any] = [
            "Id": item.getId(),
            "idPaleta":  item.getIdPaleta(),
            "idAlmacenRecepcion": item.getIdAlmacenRecepcion(),
            "almacenDestino": item.getAlmacenDestino(),
            "numeroBulto": item.getNumeroBulto(),
            "codigo": item.getCodigo(),
            "nombreProveedor": item.getNombreProveedor(),
            "nombreAlmacen": item.getNombreAlmacen(),
            "tipoOrden": item.getTipoOrden(),
            "valorOrden": item.getValorOrden(),
            "estadoBulto": "4",
            "peso": item.getPeso(),
            "alto": item.getAlto(),
            "ancho": item.getAncho(),
            "largo": item.getLarog(),
            "fragil": item.getFragil(),
            "sobredimensionado": item.getSobredimensionado(),
            "cargaPeligrosa": item.getCargaPeligrosa(),
            "importacion": item.getImportacion(),
            "nacional": item.getNacional(),
            "os": item.getOS(),
            "pr": item.getPR(),
            "plaqueteo": item.getPlaqueteo(),
            "campoID": item.getCampoId(),
            "comentario": item.getComentario(),
            "comentarioID": item.getComentarioID(),
            "idDiscrepancia": item.getIdDiscrepancia(),
            "campoDiscrepancia": item.getCampoDiscrepancia(),
            "fechaRecepcion": item.getFechaRecepcion(),
            "recepcionAlmacen": true,
            "fechaRecepcionAlmacen": NSDate().timeIntervalSince1970,
            "codigoTransportista": item.getCodigoTransportista(),
            "transportista": item.getTransportista(),
            "ubicacion": item.getUbicacion(),
            "general": item.getGeneral(),
            "componente": item.getComponente(),
            "paletaConsolidada": item.getPaletaConsolidada(),
            "unidadCompleta": item.getUnidadCompleta(),
            "imagenes": item.getImagenes(),
            "completeOrder": item.getCompleteOrder(),
            "districtCode": item.getDistrictCode(),
            "RowVersion": item.getRowVersion(),
            "codigoQR": item.getCodigoQR()
        ]
        nuevo.append(_item)
        print(nuevo)
        var request = URLRequest(url: URL(string: UPDATE_BULTO)!)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let json = try? JSONSerialization.data(withJSONObject: nuevo)
        request.httpBody = json
        self.delay(seconds: 5.0, completion: {
            SwiftSpinner.show("Cargando")
            Alamofire.request(request).responseJSON(){
            //Alamofire.request(UPDATE_BULTO, method:.post, parameters: [nuevo] as! [Dictionary<String,Any>], encoding: JSONEncoding.default){
                response in switch response.result{
                case .success(let data):
                    print(data)
                    SwiftSpinner.hide()
                case .failure(let error):
                    print(error)
                    let errorNotification = PMAlertController(title: "Error", description: "no se pudo obtener los datos, revice su conexion a internet", image: UIImage(named:"error"), style: .alert)
                    errorNotification.addAction(PMAlertAction(title: "Aceptar", style: .cancel))
                    self.present(errorNotification, animated: true, completion: nil)
                    SwiftSpinner.hide()
                }
            }
        })
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is ListaBultosViewController{
            let vs = segue.destination as? ListaBultosViewController
            vs!.bultosConfi = self.bultosConfi
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
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        buscarGuia.resignFirstResponder()
        return true
    }
    
}
