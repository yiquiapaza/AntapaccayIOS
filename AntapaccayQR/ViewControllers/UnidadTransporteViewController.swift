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
    
    @IBOutlet var vista: UIView!
    let dropDownAlmacenDestino = DropDown()
    
    override func viewDidLoad() {
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
        self.dropDownAlmacenDestino.show()
    }
    
    
    @IBAction func registro(_ sender: UIButton) {
        self.dropDownRegistro.dataSource.removeAll()
        self.dropDownRegistro.anchorView = vista
        self.dropDownRegistro.dataSource = self.dropRegistro
        self.dropDownRegistro.show()
    }
    
    @IBAction func tipo(_ sender: UIButton) {
        self.dropDownTipo.dataSource.removeAll()
        self.dropDownTipo.anchorView = vista
        self.dropDownTipo.dataSource = self.dropTipo
        self.dropDownTipo.show()
    }
    
    @IBAction func placa(_ sender: UIButton) {
        self.dropDownPlaca.dataSource.removeAll()
        self.dropDownPlaca.anchorView = vista
        self.dropDownPlaca.dataSource = self.listaPlaca
        self.dropDownPlaca.show()
    }
    
}
