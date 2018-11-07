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
    var listaOrdenDetalle = Array<OrdenDetalle>()
    @IBOutlet var prueba: UIView!
    
    @IBOutlet weak var numeroItem: UILabel!
    var _numeroItem: String = VACIO
    
    var _listaItem = Array<Item>()
    var _idProveedor: String = VACIO
    
    var _cantidadesItem:Dictionary<String, String> = [:]
    
    @IBOutlet weak var nombreProveedor: UILabel!
    @IBOutlet weak var descripcion: UILabel!
    @IBOutlet weak var unidad: UILabel!
    @IBOutlet weak var almacen: UILabel!
    @IBOutlet weak var disponible: UILabel!
    
    let dropDown = DropDown()
    
    @IBOutlet weak var cantidadItems: UILabel!
    @IBOutlet weak var cantidadRequerida: UITextField!
    
    
    @IBAction func menu(_ sender: Any) {
        //ObtenerOrdenDet(_parametros: nuevo2)
        dropDown.anchorView = prueba
        dropDown.dataSource = listItems
        dropDown.selectionAction = {[unowned self] (index ,item) in
            self.numeroItem.text = item
            self._numeroItem = item
            print(item)
        }
        dropDown.show()
    }
    
    @IBAction func buscarItem(_ sender: UIButton) {
        if self._numeroItem != VACIO {
            var _item = OrdenDetalle()
            for item in self.listaOrdenDetalle{
                if item.getNumeroItem() == self._numeroItem{
                    _item = item
                    break
                }
            }
            self.nombreProveedor.text = _item.getNombreProveedor()
            //self.descripcion.adjustsFontSizeToFitWidth = true
            self.descripcion.numberOfLines = 0
            self._idProveedor = _item.getIdProveedor()
            self.descripcion.text = _item.getDescripcion()
            self.unidad.text = _item.getUnidad()
            self.almacen.text = _item.getAlmace()
            if self._cantidadesItem.keys.contains(_item.getNumeroItem()){
                self.disponible.text = String(_item.getDisponibilidad() - Int(self._cantidadesItem[_item.getNumeroItem()]!)!)
            }
            else{
                self.disponible.text = String(_item.getDisponibilidad())
            }
            
        }
        else{
            self.nombreProveedor.text = "Nombre del Proveedor"
            self.descripcion.text = "Descripcion"
            self.unidad.text = "Unidad"
            self.almacen.text = "Almacen"
            self.disponible.text = "0"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.view.backgroundColor = UIColor.red
        self.navigationController?.title = "ANTAPACCAI"
    }
    
    @IBAction func buscarOrden(_ sender: UIButton) {
        if (numeroOrden.text!.trimmingCharacters(in: .whitespacesAndNewlines) != VACIO && orden.getTipoOrden() != VACIO) {
            orden.setValorOrden(valorOrden: numeroOrden.text!)
            orden.setIdComprador(idComprador: VACIO)
            orden.setPriceCode(priceCode: VACIO)
            orden.setCodigoDistrito(codigoDistrito: CONST_CODIGO_DISTRITO)
            dropDown.dataSource = []
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
                        var temp = Array<String>()
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
                            self.listaOrdenDetalle.append(item)
                        }
                    
                        for item in self.listaOrdenDetalle {
                            temp.append(item.getNumeroItem())
                        }
                        self.listItems = temp
                        temp.removeAll()
                        
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
    
    
    @IBAction func agregarItem(_ sender: UIButton) {
        let nuevoItem = Item()
        nuevoItem.setId(id: CONST_ID)
        nuevoItem.setRowVersion(rowVersion: CONST_ROW_VERSION)
        nuevoItem.setNumeroItem(numeroItem: self._numeroItem)
        nuevoItem.setDescripcion(descripcion: self.descripcion.text!)
        self.descripcion.text = "Descripcion"
        self.unidad.text = "Unidad"
        self.disponible.text = "0"
        self.almacen.text = "Almacen"
        nuevoItem.setCantida(cantidad: self.cantidadRequerida.text!)
        
        nuevoItem.setIdOrdenDetalle(idOrdenDetalle: CONST_ID_ORDEN_DETALLE)
        nuevoItem.setIdProveedor(idProveedor: self._idProveedor)
        self._idProveedor = VACIO
        nuevoItem.setTransportista(transportista: CONST_TRANSPORTISTA)
        nuevoItem.setVerificadoAlmacen(verificadoAlmacen: false)
        self._listaItem.append(nuevoItem)
        self.cantidadItems.text = String(self._listaItem.count)
        if self._cantidadesItem.keys.contains(self._numeroItem){
            self._cantidadesItem[self._numeroItem] = String( Int(self._cantidadesItem[self._numeroItem]!)! + Int(self.cantidadRequerida.text!)! )
        }
        else{
            self._cantidadesItem[self._numeroItem] = self.cantidadRequerida.text!
        }
        self.cantidadRequerida.text = VACIO
    }
    
    @IBAction func crearBulto(_ sender: UIButton) {
        for item in self._listaItem {
            print(item.getNumeroItem())
            
        }
    }
}

