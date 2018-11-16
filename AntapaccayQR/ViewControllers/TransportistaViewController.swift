//
//  TransportistaViewController.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 11/14/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import UIKit
import Alamofire
import DropDown
import SwiftSpinner

class TransportistaViewController: UIViewController {

    var objectoCarga = Array<Item>()
    var objectoOrden = OrdenDTO()
    
    var _almacenes: Array<Dictionary<String,AnyObject>> = []
    var _transporte: Array<Dictionary<String,AnyObject>> = []
    
    var dropDownAlmacenes = DropDown()
    var dropDownTranporter = DropDown()
    
    var objTransporte: TransporteDTO = TransporteDTO()
    
    @IBOutlet weak var viewAlmacenes: UIView!
    @IBOutlet weak var viewTransporte: UIView!
    @IBOutlet weak var almacenesActivate: UIButton!
    @IBOutlet weak var transporteActive: UIButton!
    
    @IBOutlet weak var nombreAlmacen: UILabel!
    @IBOutlet weak var nombreTransportista: UILabel!
    
    override func viewDidLoad() {
        self.almacenesActivate.isEnabled = false
        self.transporteActive.isEnabled = false
        let data = self.parent as! TabBarViewController
        self.objectoCarga =  data.objetoCarga
        self.objectoOrden = data.objetoOrden
        self.dropDownAlmacenes.direction = .top
        let parametres: Parameters = [
            "Logial": "AND",
            "PropertyName":"tipo",
            "Value": "AT",
            "Operator":"Equals"
        ]
        
        self.delay(seconds: 5.0, completion: {
            SwiftSpinner.show("Obteniendo datos de Almacen")
            Alamofire.request(LIST_ALMACENES, method: .post, parameters: parametres, encoding: JSONEncoding.default)
                .responseJSON{ response in
                    switch (response.result){
                    case .success(let data):
                        self._almacenes = data as! Array<Dictionary<String, AnyObject>>
                        self.almacenesActivate.isEnabled = true
                    case .failure(let error):
                        print(error)
                        SwiftSpinner.hide()
                    }
            }
        })
        self.delay(seconds: 5.0, completion: {
            SwiftSpinner.show("Obteniendo datos de Trasporte")
            Alamofire.request(LIST_TRANSPORTISTAS, method: .get, parameters: nil, encoding: JSONEncoding.default)
                .responseJSON{ response in
                    switch (response.result){
                    case .success(let data):
                        self._transporte = data as! Array<Dictionary<String,AnyObject>>
                        self.transporteActive.isEnabled = true
                        SwiftSpinner.hide()
                    case .failure(let error):
                        print(error)
                        SwiftSpinner.hide()
                    }
            }
        })
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
//*****************************************Action*****************************************
/**
     #Action Button for Get all depot using Alamofire
*/
    @IBAction func almacenesButton(_ sender: UIButton) {
        self.dropDownAlmacenes.dataSource.removeAll()
        self.dropDownAlmacenes.anchorView = self.viewAlmacenes
        self.dropDownAlmacenes.dataSource = getListaNombres(lista: self._almacenes)
        self.dropDownAlmacenes.selectionAction = {[unowned self] (index ,item) in
            self.nombreAlmacen.text = item
            print(item)
            self.objTransporte.setNombreAlmacen(nombreAlmacen: item)
            print(self._almacenes[index]["Id"]!)
        }
        self.dropDownAlmacenes.show()
    }
/**
     #Action Button for Get all drives with states is active
*/
    @IBAction func transportistasButton(_ sender: UIButton) {
        self.dropDownTranporter.dataSource.removeAll()
        self.dropDownTranporter.anchorView = self.viewAlmacenes
        self.dropDownTranporter.dataSource = getListaNombres(lista: self._transporte)
        self.dropDownTranporter.selectionAction = {[unowned self] (index, item) in
            self.nombreTransportista.text = item
            print(item)
            self.objTransporte.setNombreTransportista(nombreTransportista: item)
            self.objTransporte.setCodigoTransportista(codigoTransportista: self._transporte[index]["codigo"] as! String)
            print(self._transporte[index]["Id"]!)
        }
        self.dropDownTranporter.show()
    }
    
    func delay(seconds: Double, completion: @escaping () -> ()) {
        let popTime = DispatchTime.now() + Double(Int64( Double(NSEC_PER_SEC) * seconds )) / Double(NSEC_PER_SEC)
        
        DispatchQueue.main.asyncAfter(deadline: popTime) {
            completion()
        }
    }
    
    func getListaNombres(lista: Array<Dictionary<String,AnyObject>>) -> Array<String> {
        var out =  Array<String>()
        for item in lista{
            var nombre:String = ""
            nombre = item["nombre"] as! String
            out.append(nombre)
        }
        return out
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.hidesBottomBarWhenPushed = true
        if segue.destination is TerminarViewController
        {
            let vs = segue.destination as? TerminarViewController
            vs!.objectoCarga = self.objectoCarga
            vs!.objectoOrden = self.objectoOrden
            vs!.objectoTransporte = self.objTransporte
        }
    }
}
