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


class TransportistaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet var vista: UIView!
    
    var listaGuias: Array<String> = Array<String>()
    @IBOutlet weak var tablaGuias: UITableView!
    @IBOutlet weak var guia: UITextField!
    var index:Int = -1
    let cellReuseIdentifier = "cell"
    
    var objectoCarga = Array<Item>()
    var objectoOrden = OrdenDTO()
    
    var _almacenes: Array<Dictionary<String,AnyObject>> = []
    var _transporte: Array<Dictionary<String,AnyObject>> = []
    
    var dropDownAlmacenes = DropDown()
    var dropDownTranporter = DropDown()
    
    var objTransporte: TransporteDTO = TransporteDTO()
    
    @IBOutlet var viewAlmacenes: UIView!
    @IBOutlet var viewTransporte: UIView!
    
    
    @IBOutlet var almacenesActivate: UIButton!
    @IBOutlet weak var transporteActive: UIButton!
    
    @IBOutlet weak var nombreAlmacen: UILabel!
    @IBOutlet weak var nombreTransportista: UILabel!
    var rect = CGRect(x: 10, y: 10, width: 100, height: 100)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cerrar Session", style: .plain, target: self, action: #selector(cerrarSession))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        self.almacenesActivate.isEnabled = false
        self.transporteActive.isEnabled = false
        let data = self.parent as! TabBarViewController
        self.objectoCarga =  data.objetoCarga
        self.objectoOrden = data.objetoOrden
        self.dropDownAlmacenes.direction = .top
        
        self.viewAlmacenes.frame(forAlignmentRect: rect)
        
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
        
        tablaGuias.delegate = self
        tablaGuias.dataSource = self
        tablaGuias.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        self.vista.addSubview(tablaGuias)
        // Do any additional setup after loading the view.
    }
//*****************************************Action*****************************************
/**
     #Action Button for Get all depot using Alamofire
*/
    @IBAction func almacenesButton(_ sender: UIButton) {
        self.dropDownAlmacenes.dataSource.removeAll()
        self.dropDownAlmacenes.anchorView = self.viewAlmacenes
        self.dropDownAlmacenes.direction = .any
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
            vs!.listaGuias = self.listaGuias
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listaGuias.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tablaGuias.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.listaGuias[indexPath.row].description
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 300))
        button.addTarget(self, action: #selector(quitar(_:)), for: .touchDown)
        button.setTitle("", for : .normal)
        button.setTitleColor(.white, for: .normal)
        button.setImage(UIImage(named:"icons8-delete_filled"), for: .normal)
        cell.accessoryView = button
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.index = indexPath.row
        print(indexPath.row)
    }
    
    @IBAction func agregarGuia(_ sender: Any) {
        self.listaGuias.append(self.guia.text!)
        tablaGuias.reloadData()
        self.guia.text = VACIO
    }
    
    @objc func quitar(_ sneder: UIButton){
        print("Elimine la filas")
        if index == -1{
            //let error = MessageView.viewFromNib(layout: .tabView)
            //error.configureTheme(.error)
            //error.configureContent(title:"Error",body:"Es necesario Seleccionar una Celda" )
            //error.button?.isHidden = true
            //var configError = SwiftMessages.defaultConfig
            //configError.presentationStyle = .center
            //configError.duration = .seconds(seconds: 2)
            //SwiftMessages.show(config: configError , view:error)
        }
        else{
            self.listaGuias.remove(at: index)
            index = -1
            tablaGuias.reloadData()
        }
    }
    @objc func cerrarSession(){
        UserDefaults.standard.set(VACIO, forKey: "user")
        UserDefaults.standard.set(VACIO, forKey: "pass")
        let loginView = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        present(loginView, animated: true, completion: nil)
    }
}
