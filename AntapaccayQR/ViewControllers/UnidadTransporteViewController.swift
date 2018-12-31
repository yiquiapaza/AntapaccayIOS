//
//  UnidadTransporteViewController.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 11/26/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import UIKit
import Alamofire
import DropDown

class UnidadTransporteViewController: UIViewController {

    var data = Array<Unidad>()
    
    let dropDownPlaca = DropDown()
    var listaPlaca = Array<String>()
    
    let dropDownTipo = DropDown()
    var dropTipo = Array<String>()
    var data2 = Array<DataDTO>()
    
    let dropDownRegistro = DropDown()
    
    
    var almacenDestino = Array<DataDTO>()
    var dropDestino = Array<String>()
    var dropRegistro = Array<String>()
    var dropRegistroValue = Array<String>()
    
    @IBOutlet weak var destino: UILabel!
    @IBOutlet weak var origen: UILabel!
    @IBOutlet weak var semiremolque: UILabel!
    @IBOutlet weak var placa: UILabel!
    
    @IBOutlet var vista: UIView!
    let dropDownAlmacenDestino = DropDown()
    
    override func viewDidLoad() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cerrar Session", style: .plain, target: self, action: #selector(cerrarSession))
        
        let new_listas = self.parent as! TabBarUnidadViewController
        data = new_listas.listaPaletas
        PESO_LISTA = pesototal(lista: data)
        dropRegistro.append("Todos")
        dropRegistro.append("WebControl")
        dropRegistro.append("Otros")
        dropRegistroValue.append("T")
        dropRegistroValue.append("W")
        dropRegistroValue.append("O")
        super.viewDidLoad()
        Alamofire.request(ALMACENES_DESTINO)
        .responseJSON(){
            response in switch response.result{
            case .success(let data):
                let nueva = data as! [Dictionary<String,AnyObject>]
                for item in nueva{
                    let aldes = DataDTO()
                    aldes.setData1(data1: item["nombre"] as! String)
                    aldes.setData2(data2: item["codigo"] as! String)
                    self.dropDestino.append(aldes.getData1())
                    self.almacenDestino.append(aldes)
                }
                print(data)
            case .failure(let error):
                print(error)
            }
        }
        Alamofire.request(TIPO_SEMIREMOLQUE)
        .responseJSON(){
            response in switch response.result{
            case .success(let data):
                let nueva = data as! [Dictionary<String,AnyObject>]
                for item in nueva {
                    let aldes = DataDTO()
                    aldes.setData1(data1: item["nombre"] as! String)
                    aldes.setData2(data2: item["codigo"] as! String)
                    self.dropTipo.append(aldes.getData1())
                    self.dropTipo.append(aldes.getData2())
                    self.data2.append(aldes)
                }
                print(data)
            case .failure(let error):
                print(error)
            }
        }
        let parametres : Parameters = [
            "tipoVehiculo" : "R",
            "tipoRegistro" : "T",
            "tipoCarroceria" : "-"
        ]
        Alamofire.request(PLACAS_SEMIREMOLQUE, method: .post, parameters: parametres, encoding: JSONEncoding.default)
            .responseJSON(){
                response in switch response.result{
                case .success(let data):
                    let nueva = data as! [Dictionary<String,AnyObject>]
                    for item in nueva {
                        let aldes = DataDTO()
                        aldes.setData1(data1: item["codigo"] as! String)
                        self.listaPlaca.append(aldes.getData1())
                    }
                    print(data)
                case .failure(let error):
                    print(error)
                }
        }
    }
    
    @IBAction func almacenDestiono(_ sender: UIButton) {
        self.dropDownAlmacenDestino.dataSource.removeAll()
        self.dropDownAlmacenDestino.anchorView = vista
        self.dropDownAlmacenDestino.dataSource = self.dropDestino
        self.dropDownAlmacenDestino.selectionAction = { [unowned self] (index, item) in
            self.destino.text! = item
            NOMBRE_DESTINO = self.almacenDestino[index].getData1()
            CODIGO_DESTINO = self.almacenDestino[index].getData2()
        }
        self.dropDownAlmacenDestino.show()
    }
    
    func pesototal(lista: Array<Unidad>) -> Float {
        if data.isEmpty {
            return 0
        } else {
            var suma:Float = 0
            for item in lista {
                let element = item.getPeso()
                suma = suma + element
            }
            return suma
        }
    }
    func dataJSON() -> Void {
        if data.isEmpty {
            CODIGO_TRANSPORTISTA_LISTA = VACIO
            TRANSPORTISTA_LISTA = VACIO
        }
        else {
            CODIGO_TRANSPORTISTA_LISTA = data[0].getCodigoTransportista()
            TRANSPORTISTA_LISTA = data[0].getTransportista()
        }
    }
    
    @IBAction func registro(_ sender: UIButton) {
        self.dropDownRegistro.dataSource.removeAll()
        self.dropDownRegistro.anchorView = vista
        self.dropDownRegistro.dataSource = self.dropRegistro
        self.dropDownRegistro.selectionAction = { [unowned self] (index, item) in
            self.origen.text! = item
        }
        self.dropDownRegistro.show()
    }
    
    @IBAction func tipo(_ sender: UIButton) {
        self.dropDownTipo.dataSource.removeAll()
        self.dropDownTipo.anchorView = vista
        self.dropDownTipo.dataSource = self.dropTipo
        self.dropDownTipo.selectionAction = { [unowned self] (index, item) in
            self.semiremolque.text! = item
            TIPO_SEMIREMOLQUE_CODIGO = self.data2[index].getData2()
            TIPO_SEMIREMOLQUE_CONST = self.data2[index].getData1()
        }
        self.dropDownTipo.show()
    }
    
    /*
    revusar el servicio de la placa o cambiar todos los servicios para el transporte 
     */
    @IBAction func placa(_ sender: UIButton) {
        self.dropDownPlaca.dataSource.removeAll()
        self.dropDownPlaca.anchorView = vista
        self.dropDownPlaca.dataSource = self.listaPlaca
        self.dropDownPlaca.selectionAction = { [unowned self] (index, item) in
            self.placa.text! = item
            PLACA_SEMIREMOLQUE = item
        }
        self.dropDownPlaca.show()
    }
    
    @IBAction func tipoServicio(_ sender: UISwitch) {
        if sender.isOn {
           SERVICIO_EXPRESS = true
        }
        else if !sender.isOn{
            SERVICIO_EXPRESS = false
        }
    }
    
    @objc func cerrarSession(){
        UserDefaults.standard.set(VACIO, forKey: "user")
        UserDefaults.standard.set(VACIO, forKey: "pass")
        let loginView = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        present(loginView, animated: true, completion: nil)
    }
}
