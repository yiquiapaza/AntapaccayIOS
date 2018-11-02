//
//  SeguimientoCargaViewController.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 10/31/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import UIKit
import DropDown
import Alamofire

class SeguimientoCargaViewController: UIViewController {

 
    @IBOutlet weak var switchOC: UISwitch!
    @IBOutlet weak var switchOS: UISwitch!
    @IBOutlet weak var switchOR: UISwitch!
    @IBOutlet weak var switchID: UISwitch!
    
    @IBOutlet weak var numeroOrden: UITextField!
    
    var orden = Orden()
    var listItems = Array<String>()
    @IBOutlet var prueba: UIView!
    
    let nuevo = DropDown()
    var nuevo2 = Orden(_valorOrden: "M43401", _tipoOrden: "OC", _idComprador: "", _codigoDistrito: "XTAN", _priceCode: "")
    
    
    @IBAction func menu(_ sender: Any) {
        //ObtenerOrdenDet(_parametros: nuevo2)
        nuevo.anchorView = prueba
        nuevo.dataSource = listItems
        nuevo.show()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func buscarOrden(_ sender: UIButton) {
        if (numeroOrden.text!.trimmingCharacters(in: .whitespacesAndNewlines) != VACIO && orden.getTipoOrden() != VACIO) {
            orden.setValorOrden(valorOrden: numeroOrden.text!)
            orden.setIdComprador(idComprador: VACIO)
            orden.setPriceCode(priceCode: VACIO)
            orden.setCodigoDistrito(codigoDistrito: CONST_CODIGO_DISTRITO)
            
            
            var listaOrdenDetalle =  Array<OrdenDetalle>()
            let parametros: Parameters = [
                VALOR_ORDEN : orden.getValorOrden(),
                TIPO_ORDEN: orden.getTipoOrden(),
                ID_COMPRADOR: orden.getIdCmprador(),
                CODIGO_DISTRITO: orden.getCodigoDistrito(),
                PRICE_CODE: orden.getPriceCode()
            ]
            Alamofire.request(LIST_ORDEN_DET, method: .post,parameters: parametros, encoding: JSONEncoding.default)
                .responseJSON(){ response in
                    switch response.result {
                    case .success:
                        //print(response.result.value)
                        let ordenesDetalle = response.result.value as! [Dictionary<String, AnyObject>]
                        var item: OrdenDetalle
                        var cantidad_po: Int = 0
                        var cantidad_recibida:Int = 0
                        for ordenDetalle in ordenesDetalle {
                            item = OrdenDetalle()
                            //item.setId(id: ordenDetalle[ID] as! String)
                            item.setNumeroItem(numeroItem: ordenDetalle[NUMERO_ITEM] as! String)
                            item.setNombreProoveedor(nombreProveedor: ordenDetalle[NOMBRE_PROVEEDOR] as! String)
                            item.setDescripcion(descripcion: ordenDetalle[DESCRIPCION] as! String)
                            item.setUnidad(unidad: ordenDetalle[UNIDAD] as! String)
                            item.setAlmacen(almacen: ordenDetalle[ALMACEN] as! String)
                            cantidad_po = ordenDetalle[CANTIDAD_PO] as! Int
                            cantidad_recibida = ordenDetalle[CANTIDAD_RECIBIDA] as! Int
                            item.setDisponibilidad(disponibilidad: cantidad_po-cantidad_recibida)
                            listaOrdenDetalle.append(item)
                        }
                        for item in listaOrdenDetalle {
                            self.listItems.append(item.getNumeroItem())
                        }
                    case .failure( let error):
                        print(error)
                    }
            }
        }
        if (orden.getTipoOrden() == VACIO && numeroOrden.text!.trimmingCharacters(in: .whitespacesAndNewlines) != VACIO) {
            let alertOrden = UIAlertController(title: "Seleccione un Tipo de Orden", message: "Es Obligatorio", preferredStyle: UIAlertController.Style.alert)
            let exit = UIAlertAction(title: "Regresar", style: UIAlertAction.Style.cancel, handler: nil)
            alertOrden.addAction(exit)
            self.present(alertOrden, animated: true, completion: nil)
        }
        if (numeroOrden.text!.trimmingCharacters(in: .whitespacesAndNewlines) == VACIO && orden.getTipoOrden() != VACIO) {
            let alertOrden = UIAlertController(title: "Ingrese Numero de Orden", message: "Es un campo Obligatorio", preferredStyle: UIAlertController.Style.alert)
            let exit = UIAlertAction(title: "Regresar", style: UIAlertAction.Style.cancel, handler: nil)
            alertOrden.addAction(exit)
            self.present(alertOrden, animated: true, completion: nil)
        }
        if(numeroOrden.text!.trimmingCharacters(in: .whitespacesAndNewlines) == VACIO && orden.getTipoOrden() == VACIO) {
            let alertOrden = UIAlertController(title: "Ingrese Numero y Tipo de Orden", message: "Son Obligatorio", preferredStyle: UIAlertController.Style.alert)
            let exit = UIAlertAction(title: "Regresar", style: UIAlertAction.Style.cancel, handler: nil)
            alertOrden.addAction(exit)
            self.present(alertOrden, animated: true, completion: nil)
        }
        
    }
    
    
    @IBAction func switchChangeOC(_ sender: UISwitch) {
        if sender.isOn {
            switchID.setOn(false, animated: true)
            switchOS.setOn(false, animated: true)
            switchOR.setOn(false, animated: true)
            orden.setTipoOrden(tipoOrden: SWITCH_OC)
        }
        else{
            orden.setTipoOrden(tipoOrden: VACIO)
        }
    }
    
    @IBAction func switchChangeOS(_ sender: UISwitch) {
        if sender.isOn {
            switchOC.setOn(false, animated: true)
            switchOR.setOn(false, animated: true)
            switchID.setOn(false, animated: true)
            orden.setTipoOrden(tipoOrden:SWITCH_OS)
        }else{
            orden.setTipoOrden(tipoOrden: VACIO)
        }
    }
    
    @IBAction func switchChangeOR(_ sender: UISwitch) {
        if sender.isOn {
            switchOC.setOn(false, animated: true)
            switchOS.setOn(false, animated: true)
            switchID.setOn(false, animated: true)
            orden.setTipoOrden(tipoOrden: SWITCH_OR)
        }else{
            orden.setTipoOrden(tipoOrden: VACIO)
        }
    }
    
    @IBAction func switchChangeID(_ sender: UISwitch) {
        if sender.isOn {
            switchOC.setOn(false, animated: true)
            switchOS.setOn(false, animated: true)
            switchOR.setOn(false, animated: true)
            orden.setTipoOrden(tipoOrden: SWITCH_ID)
        }else{
            orden.setTipoOrden(tipoOrden: VACIO)
        }
    }
    
}

