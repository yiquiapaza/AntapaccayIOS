//
//  ListaBultosViewController.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 12/7/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import UIKit
import Alamofire
import SwiftSpinner
import PMAlertController

class ListaBultosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableAlmacen: UITableView!
    @IBOutlet weak var codigoItem: UILabel!
    
    var cellReuseIdentifier:String = "cell"
    var idItem = String()
    var bultosConfi = Array<Paleta>()
    var bultoOrden = Paleta()
    var listaItems = Array<ItemBulsto>()
    
    override func viewDidLoad() {
        tableAlmacen.delegate = self
        tableAlmacen.dataSource = self
        tableAlmacen.register(UINib(nibName: "AlmacenComponentTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
        super.viewDidLoad()
        for item in bultosConfi {
            print(item.getId())
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bultosConfi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableAlmacen.dequeueReusableCell(withIdentifier: "cell",for:  indexPath) as! AlmacenComponentTableViewCell
        cell.numeroItem.text = self.bultosConfi[indexPath.row].getCodigo()
        cell.numeroProducto.text = self.bultosConfi[indexPath.row].getValorOrden()
        cell.nombreProveedor.text = self.bultosConfi[indexPath.row].getNombreProveedor()
        cell.nombreAlmacen.text = self.bultosConfi[indexPath.row].getNombreAlmacen()
        cell.nombreTransporte.text = self.bultosConfi[indexPath.row].getTransportista()
        cell.buttonConfirm.addTarget(self, action: #selector(hacerClick(_:)), for: .touchDown)
        cell.buttonConfirm.tag = indexPath.row
        return cell
    }
    
    @objc func hacerClick(_ sender: UIButton){
        codigoItem.text = self.bultosConfi[sender.tag].getCodigo()
        idItem = self.bultosConfi[sender.tag].getId()
        bultoOrden = self.bultosConfi[sender.tag]
        let parameters : Parameters = [
            "filtros":[
                [
                    "PropertyName": "idBulto",
                    "Operator": "Equals",
                    "value": idItem,
                    "Logical": "AND"
                ]
            ],
            "orden":[
                [
                    "OrderType": "DESC",
                    "Property": "numeroItem",
                    "Index": "1"
                ]
            ],
            "startIndex":0,
            "length":100
        ]
        delay(seconds: 3.0, completion: {
            SwiftSpinner.show("Cargando")
            Alamofire.request(OBTENER_ITEMS_BULTO, method: .post, parameters: parameters, encoding: JSONEncoding.default)
                .responseJSON(){
                    response in switch response.result{
                    case .success(let data):
                        let out = data as! [Dictionary<String, AnyObject>]
                        if out.isEmpty{
                            let alertOrden = PMAlertController(title: "Precacuion", description: "Este bulto no tiene items", image: UIImage( named: "precaucion"), style: .alert)
                            alertOrden.addAction( PMAlertAction(title: "Aceptar", style: .cancel, action: nil))
                            self.present(alertOrden, animated: true, completion: nil)
                        }
                        else {
                            for item in out {
                                let _nuevo = ItemBulsto()
                                _nuevo.setId(Id: item["Id"] as! String)
                                _nuevo.setIdOrden(idOrden: CONST_ID)
                                _nuevo.setIdOrdenDetalle(idOrdenDetalle: CONST_ID)
                                _nuevo.setIdBulto(idBulto: item["idBulto"] as! String)
                                _nuevo.setIdProveedor(idProveedor: item["idProveedor"] as! String)
                                _nuevo.setNumeroItem(numeroItem: item["numeroItem"] as! String)
                                _nuevo.setDescripcion(descripcion: item["descripcion"] as? String ?? "")
                                _nuevo.setCantidad(cantidad: item["cantidad"] as! Int)
                                _nuevo.setDiscrepancia(discrepancia: item["discrepancia"] as? String ?? "" )
                                _nuevo.setDescripcionDiscrepancia(descripcionDiscrepancia: item["descripcionDiscrepancia"] as? String ?? "" )
                                _nuevo.setTransportista(transportista: item["transportista"] as! String)
                                _nuevo.setVerificadoAlmacen(verificadoAlmacen: item["verificadoAlmacen"] as! Bool)
                                _nuevo.setNumeroWaybill(numeroWaybill: item["numeroWaybill"] as? String ?? "" )
                                _nuevo.setPeso(peso: item["peso"] as! Double)
                                _nuevo.setAlto(alto: item["alto"] as! Double)
                                _nuevo.setAncho(ancho: item["ancho"] as! Double)
                                _nuevo.setLargo(largo: item["largo"] as! Double)
                                _nuevo.setNumeroGuia(numeroGuia: item["numeroGuia"] as! String)
                                _nuevo.setRowVersion(RowVersion: item["RowVersion"] as! String)
                                self.listaItems.append(_nuevo)
                            }
                        }
                        print(data)
                        SwiftSpinner.hide()
                    case .failure(let error):
                        print(error)
                        let alertOrden = PMAlertController(title: "Error", description: "revise si tiene conexion a internet", image: UIImage( named: "error"), style: .alert)
                        alertOrden.addAction( PMAlertAction(title: "Aceptar", style: .cancel, action: nil))
                        self.present(alertOrden, animated: true, completion: nil)
                        SwiftSpinner.hide()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is ItemsViewController
        {
            let vs = segue.destination as? ItemsViewController
            vs!.listaItems = self.listaItems
            vs!.bultoOrden = self.bultoOrden
        }
    }
    
}
