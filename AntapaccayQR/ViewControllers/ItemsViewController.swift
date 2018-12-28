//
//  ItemsViewController.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 12/26/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import UIKit
import Alamofire
import PMAlertController
import SwiftSpinner

class ItemsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var listaItems = Array<ItemBulsto>()
    var listaItems1 = Array<ItemBulsto>()

    var indiceReal = 0
    
    var bultoOrden = Paleta()
    @IBOutlet weak var tableItems: UITableView!
    var cellReuseIdentifier:String = "cell"
    
    override func viewDidLoad() {
        listaItems1.removeAll()
        
        
        if indiceReal == 0 {
            for item in listaItems {
                var nuevo = ItemBulsto()
                nuevo = item
                listaItems1.append(nuevo)
            }
            indiceReal = listaItems.count
        }
        else {
            for index in 0 ... (indiceReal - 1){
                var nuevo = ItemBulsto()
                nuevo = listaItems[index]
                listaItems1.append(nuevo)
            }
        }
        
       
        listaItems.removeAll()
        tableItems.delegate = self
        tableItems.dataSource = self
        tableItems.register(UINib(nibName: "ItemsVerificaTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
        super.viewDidLoad()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listaItems1.count
    }
    
    //@IBOutlet weak var buttonInConforme: UIButton!
    //@IBOutlet weak var buttonConforme: UIButton!

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableItems.dequeueReusableCell(withIdentifier: "cell",for:  indexPath) as! ItemsVerificaTableViewCell
        cell.numeroItem.text = self.listaItems1[indexPath.row].getNumeroItem()
        cell.descripcion.numberOfLines = 0
        cell.descripcion.text = self.listaItems1[indexPath.row].getDescripcion()
        cell.cantidad.text = String(self.listaItems1[indexPath.row].getCantidad())
        cell.buttonConforme.addTarget(self, action: #selector(conforme(_:)), for: .touchDown)
        cell.buttonInConforme.addTarget(self, action: #selector(disconforme(_:)), for: .touchDown)
        cell.buttonInConforme.tag = indexPath.row
        cell.buttonConforme.tag = indexPath.row
        return cell
    }
    
    /*
     revisar los servicios de conformidad y disconformidad json invalido
     */
    @objc func conforme( _  sender: UIButton){
        print("Confirmacion")
        let parameters : Parameters = [
            "bultoOrden": [
                "Id":listaItems1[sender.tag].getId(),
                "idOrden": CONST_ID,
                "idOrdenDetalle": CONST_ID,
                "idBulto": bultoOrden.getId(),
                "idProveedor": listaItems1[sender.tag].getIdProveedor(),
                "numeroItem": listaItems1[sender.tag].getNumeroItem(),
                "descripcion": listaItems1[sender.tag].getDescripcion(),
                "cantidad": listaItems1[sender.tag].getCantidad(),
                "discrepancia": false,
                "descripcionDiscrepancia": "",
                "transportista": listaItems1[sender.tag].getTransportista(),
                "verificadoAlmacen": true,
                "numeroWaybill": listaItems1[sender.tag].getNumeroWaybill(),
                "peso": listaItems1[sender.tag].getPeso(),
                "alto": listaItems1[sender.tag].getAlto(),
                "ancho": listaItems1[sender.tag].getAncho(),
                "largo": listaItems1[sender.tag].getLargo(),
                "numeroGuia": listaItems1[sender.tag].getNumeroGuia(),
                "RowVersion":listaItems1[sender.tag].getRowVersion(),
            ],
            "discrepancia": [
                "Id": CONST_ID,
                "idOrdenDetalle": "",
                "idBultoOrden": listaItems1[sender.tag].getId(),
                "valorOrden": "",
                "numeroItem": listaItems1[sender.tag].getNumeroItem(),
                "descripcionItem": listaItems1[sender.tag].getDescripcion(),
                "numeroWaybill": "",
                "comentario": "",
                "unidad": "",
                "cantidad": listaItems1[sender.tag].getCantidad(),
                "tipoDiscrepancia":"1",
                "estadoDiscrepancia": "1",
                "RowVersion": "000000000000"
            ]
        ]
        print(parameters)
        self.delay(seconds: 3.0, completion: {
            SwiftSpinner.show("Cargando")
            Alamofire.request(VERIFICA_ITEM, method: .post, parameters: parameters, encoding: JSONEncoding.default)
                .responseJSON(){
                    response in switch response.result{
                    case .success(let data):
                        print(data)
                        SwiftSpinner.hide()
                    case .failure(let error):
                        print(error)
                        SwiftSpinner.hide()
                    }
            }
        })
        
    }
    
    @objc func disconforme( _ sender : UIButton){
        print("No quiere")
        var descripcion = String()
        let alertDescripcion = PMAlertController(title: "Discrepanacia", description: "Escriba el motivo de la Discrepancia", image: UIImage(named: "error"), style: .alert)
        alertDescripcion.addTextField{ (textField) in
            textField?.placeholder = "Ingrese la Discrepancia"
        }
        alertDescripcion.addAction(PMAlertAction(title: "Cancel", style: .cancel))
        alertDescripcion.addAction(PMAlertAction(title: "Aceptar", style: .default, action: { () in
            descripcion = alertDescripcion.textFields[0].text ?? ""
        }))
        self.present(alertDescripcion,animated: true, completion: nil)
        let parameters : Parameters = [
            "bultoOrden": [
                "Id":listaItems1[sender.tag].getId(),
                "idOrden": CONST_ID,
                "idOrdenDetalle": CONST_ID,
                "idBulto": bultoOrden.getId(),
                "idProveedor": listaItems1[sender.tag].getIdProveedor(),
                "numeroItem": listaItems1[sender.tag].getNumeroItem(),
                "descripcion": listaItems1[sender.tag].getDescripcion(),
                "cantidad": listaItems1[sender.tag].getCantidad(),
                "discrepancia": true,
                "descripcionDiscrepancia": "aa",
                "transportista": listaItems1[sender.tag].getTransportista(),
                "verificadoAlmacen": true,
                "numeroWaybill": listaItems1[sender.tag].getNumeroWaybill(),
                "peso": listaItems1[sender.tag].getPeso(),
                "alto": listaItems1[sender.tag].getAlto(),
                "ancho": listaItems1[sender.tag].getAncho(),
                "largo": listaItems1[sender.tag].getLargo(),
                "numeroGuia": listaItems1[sender.tag].getNumeroGuia(),
                "RowVersion":listaItems1[sender.tag].getRowVersion(),
            ],
            "discrepancia": [
                "Id": CONST_ID,
                "idOrdenDetalle": CONST_ID,
                "idBultoOrden": listaItems1[sender.tag].getId(),
                "valorOrden": "",
                "numeroItem": listaItems1[sender.tag].getNumeroItem(),
                "descripcionItem": listaItems1[sender.tag].getDescripcion(),
                "numeroWaybill": "",
                "comentario": "aa",
                "unidad": "",
                "cantidad": listaItems1[sender.tag].getCantidad(),
                "tipoDiscrepancia":"1",
                "estadoDiscrepancia": "1",
                "RowVersion": "000000000000"
            ]
        ]
        print(parameters)
        self.delay(seconds: 3.0, completion: {
            SwiftSpinner.show("Cargando")
            Alamofire.request(VERIFICA_ITEM, method: .post, parameters: parameters, encoding: JSONEncoding.default)
                .responseJSON(){
                    response in switch response.result{
                    case .success(let data):
                        print(data)
                        SwiftSpinner.hide()
                    case .failure(let error):
                        print(error)
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
}
