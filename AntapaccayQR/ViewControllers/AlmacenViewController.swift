//
//  AlmacenViewController.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 12/6/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import UIKit
import Alamofire

class AlmacenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    var bultos = Array<Paleta>()
    var indice: Int = -1
    var cellReuseIdentifier:String = "cell"
    var dto = Paleta()
    
    @IBOutlet weak var tableAlamacen: UITableView!
    @IBOutlet weak var buscarGuia: UITextField!
    
    override func viewDidLoad() {
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
                    if !obj.isEmpty {
                        let almacenDestino = obj[0].getData1()
                        let parameter: Parameters = [
                            "numeroGuia": self.buscarGuia.text!,
                            "estadoBulto": "3",
                            "almacenDestino": almacenDestino,
                            "recepcionAlmacen": ""
                        ]
                        Alamofire.request(OBTENER_BULTO_BY_GUIA, method: .post, parameters: parameter, encoding: JSONEncoding.default)
                            .responseJSON(){
                                response in switch response.result{
                                case .success(let data):
                                    let out = data as! [Dictionary<String,AnyObject>]
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
                                        _a.setPeso(peso: item["peso"] as! Float)
                                        _a.setAlto(alto: item["alto"] as! Float)
                                        _a.setAncho(ancho: item["ancho"] as! Float)
                                        _a.setLargo(largo: item["largo"] as! Float)
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
                                        _a.setIdDiscrepancia(IdDiscrepancia: item["idDiscrepancia"] as! String)
                                        _a.setCampoDiscrepancia(CampoDiscrepancia: item["campoDiscrepancia"] as! String)
                                        _a.setTransportista(transportista: item["transportista"] as! String)
                                        _a.setRowVersion(rowVersion: item["RowVersion"] as! String)
                                        self.bultos.append(_a)
                                        self.tableAlamacen.reloadData()
                                    }
                                    print(data)
                                case .failure(let error):
                                    print(error)
                                }
                        }
                    }
                    //print(data)
                case .failure(let error):
                    print(error)
                }
        }
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
        self.indice = indexPath.row
        return cell
    }
    
    @objc func hacerClick( _ sender: UIButton){
        print("Funciono Carajo")
        print(self.indice)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dto = bultos[indexPath.row]
        print(dto.getCodigo())
    }
    
}
