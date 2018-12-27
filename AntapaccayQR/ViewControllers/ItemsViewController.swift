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
    var bultoOrden = Paleta()
    @IBOutlet weak var tableItems: UITableView!
    var cellReuseIdentifier:String = "cell"
    
    override func viewDidLoad() {
        
        tableItems.delegate = self
        tableItems.dataSource = self
        tableItems.register(UINib(nibName: "ItemsVerificaTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
        super.viewDidLoad()
        for item in listaItems{
            print(item.getId())
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listaItems.count
    }
    
    //@IBOutlet weak var buttonInConforme: UIButton!
    //@IBOutlet weak var buttonConforme: UIButton!

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableItems.dequeueReusableCell(withIdentifier: "cell",for:  indexPath) as! ItemsVerificaTableViewCell
        cell.numeroItem.text = self.listaItems[indexPath.row].getNumeroItem()
        cell.descripcion.numberOfLines = 0
        cell.descripcion.text = self.listaItems[indexPath.row].getDescripcion()
        cell.cantidad.text = String(self.listaItems[indexPath.row].getCantidad())
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
                "Id": bultoOrden.getId(),
                "idOrden": CONST_ID,
                "idOrdenDetalle": CONST_ID,
                "idBulto": listaItems[sender.tag].getId(),
                "idProveedor": listaItems[sender.tag].getIdProveedor(),
                "numeroItem": listaItems[sender.tag].getNumeroItem(),
                "descripcion": listaItems[sender.tag].getDescripcion(),
                "cantidad": listaItems[sender.tag].getCantidad(),
                "discrepancia": false,
                "descripcionDiscrepancia": "",
                "transportista": listaItems[sender.tag].getTransportista(),
                "verificadoAlmacen": true,
                "RowVersion":bultoOrden.getRowVersion(),
            ],
            "discrepancia": [
                "Id": CONST_ID,
                "idOrdenDetalle": "",
                "idBultoOrden": bultoOrden.getId(),
                "valorOrden": "",
                "numeroItem": listaItems[sender.tag].getNumeroItem(),
                "descripcionItem": listaItems[sender.tag].getDescripcion(),
                "comentario": "no",
                "unidad": "",
                "cantidad": listaItems[sender.tag].getCantidad(),
                "tipoDiscrepancia":"1",
                "estadoDiscrepancia": "1",
                "RowVersion": CONST_ID
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
                "Id": bultoOrden.getId(),
                "idOrden": CONST_ID,
                "idOrdenDetalle": CONST_ID,
                "idBulto": listaItems[sender.tag].getId(),
                "idProveedor": listaItems[sender.tag].getIdProveedor(),
                "numeroItem": listaItems[sender.tag].getNumeroItem(),
                "descripcion": listaItems[sender.tag].getDescripcion(),
                "cantidad": listaItems[sender.tag].getCantidad(),
                "discrepancia": false,
                "descripcionDiscrepancia": "",
                "transportista": listaItems[sender.tag].getTransportista(),
                "verificadoAlmacen": true,
                "RowVersion":bultoOrden.getRowVersion(),
            ],
            "discrepancia": [
                "Id": CONST_ID,
                "idOrdenDetalle": "",
                "idBultoOrden": bultoOrden.getId(),
                "valorOrden": "",
                "numeroItem": listaItems[sender.tag].getNumeroItem(),
                "descripcionItem": listaItems[sender.tag].getDescripcion(),
                "comentario": "no",
                "unidad": "",
                "cantidad": listaItems[sender.tag].getCantidad(),
                "tipoDiscrepancia":"1",
                "estadoDiscrepancia": "1",
                "RowVersion": CONST_ID
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
