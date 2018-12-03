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
import SwiftSpinner

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

    var _ordenDTO = OrdenDTO()
    
    var _cantidadesItem:Dictionary<String, String> = [:]
    
    @IBOutlet weak var nombreProveedor: UILabel!
    @IBOutlet weak var descripcion: UILabel!
    @IBOutlet weak var unidad: UILabel!
    @IBOutlet weak var almacen: UILabel!
    @IBOutlet weak var disponible: UILabel!
    
    let dropDown = DropDown()
    
    @IBOutlet weak var cantidadItems: UILabel!
    @IBOutlet weak var cantidadRequerida: UITextField!
    
    
    @IBOutlet weak var selectState: UIButton!
    @IBOutlet weak var buscarItem: UIButton!
    
    
    
    @IBAction func menu(_ sender: Any) {
        //ObtenerOrdenDet(_parametros: nuevo2)
        self.dropDown.dataSource.removeAll()
        self.dropDown.anchorView = prueba
        self.dropDown.dataSource = listItems
        self.dropDown.selectionAction = {[unowned self] (index ,item) in
            self.numeroItem.text = item
            self._numeroItem = item
            self.buscarItem.isEnabled = true
        }
        dropDown.show()
    }
    
    @IBAction func buscarItem(_ sender: UIButton) {
        dropDown.dataSource.removeAll()
        if self._numeroItem != VACIO {
            self.cantidadRequerida.isEnabled = true
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
                self.cantidadRequerida.isEnabled = true
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
        self.navigationController?.view.backgroundColor = UIColor.red
        self.navigationController?.title = "ANTAPACCAI"
        self.selectState.isEnabled = false
        self.buscarItem.isEnabled = false
        self.cantidadRequerida.isEnabled = false
        self.cantidadRequerida.keyboardType = .numberPad
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func buscarOrden(_ sender: UIButton) {
        self.listaOrdenDetalle.removeAll()
        self.dropDown.dataSource.removeAll()
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
            self.delay(seconds: 3.0, completion: {
                SwiftSpinner.show("Verificando API")
                    Alamofire.request(LIST_ORDEN_DET, method: .post,parameters: parametros, encoding: JSONEncoding.default)
                        .responseJSON(){ response in
                            switch response.result {
                            case .success:
                                //print(response.result.value)
                                let ordenesDetalle = response.result.value as! [Dictionary<String, AnyObject>]
                                var item: OrdenDetalle
                                var temp = Array<String>()
                                var temp_orden = Array<OrdenDetalle>()
                                self._ordenDTO.setTipoOrden(tipoOrden: self.orden.getTipoOrden())
                                self._ordenDTO.setValorOrden(valorOrden: self.numeroOrden.text!)
                                temp_orden.removeAll()
                                temp.removeAll()
                                var cantidad_po: Int = 0
                                var cantidad_recibida:Int = 0
                                for ordenDetalle in ordenesDetalle {
                                    item = OrdenDetalle()
                                    //item.setId(id: ordenDetalle[ID] as! String)
                                    item.setNumeroItem(numeroItem: ordenDetalle[NUMERO_ITEM] as! String)
                                    item.setNombreProoveedor(nombreProveedor: ordenDetalle[NOMBRE_PROVEEDOR] as! String)
                                    item.setDescripcion(descripcion: ordenDetalle[DESCRIPCION] as? String ?? "")
                                    item.setUnidad(unidad: ordenDetalle[UNIDAD] as! String)
                                    item.setAlmacen(almacen: ordenDetalle[ALMACEN] as! String)
                                    cantidad_po = ordenDetalle[CANTIDAD_PO] as! Int
                                    cantidad_recibida = ordenDetalle[CANTIDAD_RECIBIDA] as! Int
                                    item.setDisponibilidad(disponibilidad: cantidad_po-cantidad_recibida)
                                    temp_orden.append(item)
                                }
                                self.listaOrdenDetalle = temp_orden
                                for item in self.listaOrdenDetalle {
                                    temp.append(item.getNumeroItem())
                                }
                                self.listItems = temp
                                temp.removeAll()
                                self.selectState.isEnabled = true
                                SwiftSpinner.hide()
                            case .failure( let error):
                                self.selectState.isEnabled = false
                                print(error)
                                SwiftSpinner.hide()
                            }
                    }
            })
        }
        if (orden.getTipoOrden() == VACIO && numeroOrden.text!.trimmingCharacters(in: .whitespacesAndNewlines) != VACIO) {
            
            //let alertOrden = UIAlertController(title: "Seleccione un Tipo de Orden", message: "Es Obligatorio", preferredStyle: UIAlertController.Style.alert)
            //let exit = UIAlertAction(title: "Regresar", style: UIAlertAction.Style.cancel, handler: nil)
            //alertOrden.addAction(exit)
            //self.present(alertOrden, animated: true, completion: nil)
            //let error = MessageView.viewFromNib(layout: .tabView)
            //error.configureTheme(.error)
            //error.configureContent(title:"Seleccione un Tipo de Orden",body:"Es un campo obligatorio" )
            //error.button?.isHidden = true
            //var configError = SwiftMessages.defaultConfig
            //configError.presentationStyle = .center
            //configError.duration = .seconds(seconds: 2)
            //SwiftMessages.show(config: configError , view:error)
        }
        if (numeroOrden.text!.trimmingCharacters(in: .whitespacesAndNewlines) == VACIO && orden.getTipoOrden() != VACIO) {
            //let error = MessageView.viewFromNib(layout: .tabView)
            //error.configureTheme(.error)
            //error.configureContent(title:"Ingrese Numero de Orden",body:"Es un campo obligatorio" )
            //error.button?.isHidden = true
            //var configError = SwiftMessages.defaultConfig
            //configError.presentationStyle = .center
            //configError.duration = .seconds(seconds: 2)
            //SwiftMessages.show(config: configError , view:error)
            
            //let alertOrden = UIAlertController(title: "Ingrese Numero de Orden", message: "Es un campo Obligatorio", preferredStyle: UIAlertController.Style.alert)
            //let exit = UIAlertAction(title: "Regresar", style: UIAlertAction.Style.cancel, handler: nil)
            //alertOrden.addAction(exit)
            //self.present(alertOrden, animated: true, completion: nil)
        }
        if(numeroOrden.text!.trimmingCharacters(in: .whitespacesAndNewlines) == VACIO && orden.getTipoOrden() == VACIO) {
            
            //let error = MessageView.viewFromNib(layout: .tabView)
            //error.configureTheme(.error)
            //error.configureContent(title:"Ingrese Numero y Tipo de Orden",body:"Es un campo obligatorio" )
            //error.button?.isHidden = true
            //var configError = SwiftMessages.defaultConfig
            //configError.presentationStyle = .center
            //configError.duration = .seconds(seconds: 2)
            //SwiftMessages.show(config: configError , view:error)
            //let alertOrden = UIAlertController(title: "Ingrese Numero y Tipo de Orden", message: "Son Obligatorio", preferredStyle: UIAlertController.Style.alert)
            //let exit = UIAlertAction(title: "Regresar", style: UIAlertAction.Style.cancel, handler: nil)
            //alertOrden.addAction(exit)
            //self.present(alertOrden, animated: true, completion: nil)
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
        if Int(self.cantidadRequerida.text!) != nil {
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
            //self.cantidadItems.text = String(self._listaItem.count)
            if self._cantidadesItem.keys.contains(self._numeroItem){
                if ( Int(self._cantidadesItem[self._numeroItem]!)! >= Int(nuevoItem.getCantidad())! ) {
                    self._cantidadesItem[self._numeroItem] = String( Int(self._cantidadesItem[self._numeroItem]!)! + Int(self.cantidadRequerida.text!)! )
                }
                else {
                    let alertOrden = UIAlertController(title: "Error", message: "La Cantidad no puede exceder al total", preferredStyle: UIAlertController.Style.alert)
                    let exit = UIAlertAction(title: "Regresar", style: UIAlertAction.Style.cancel, handler: nil)
                    alertOrden.addAction(exit)
                    self.present(alertOrden, animated: true, completion: nil)
                }
                
            }
            else{
                if ( currentAmountByItem(numeroItem: self._numeroItem)  >= Int(nuevoItem.getCantidad())! ) {
                    self._cantidadesItem[self._numeroItem] = self.cantidadRequerida.text!
                }
                else {
                    let alertOrden = UIAlertController(title: "Error", message: "La Cantidad no puede exceder al total", preferredStyle: UIAlertController.Style.alert)
                    let exit = UIAlertAction(title: "Regresar", style: UIAlertAction.Style.cancel, handler: nil)
                    alertOrden.addAction(exit)
                    self.present(alertOrden, animated: true, completion: nil)
                }
            }
            self.cantidadRequerida.text = VACIO
        }
        else {
            let alertOrden = UIAlertController(title: "Error", message: "Solo estan Permitidos caracteres Numericos", preferredStyle: UIAlertController.Style.alert)
            let exit = UIAlertAction(title: "Regresar", style: UIAlertAction.Style.cancel, handler: nil)
            alertOrden.addAction(exit)
            self.present(alertOrden, animated: true, completion: nil)
        }
    }
    
    @IBAction func crearBulto(_ sender: UIButton) {
        if self._listaItem.isEmpty{
            let alertOrden = UIAlertController(title: "Error", message: "Su bulto debe de tener minimo un elemento", preferredStyle: UIAlertController.Style.alert)
            let exit = UIAlertAction(title: "Regresar", style: UIAlertAction.Style.cancel, handler: nil)
            alertOrden.addAction(exit)
            self.present(alertOrden, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is ListaViewController
        {
            let vs = segue.destination as? ListaViewController
            vs!.objetoCarga = self._listaItem
            vs!.objetoOrden = self._ordenDTO
        }
    }
    
    func delay(seconds: Double, completion: @escaping () -> ()) {
        let popTime = DispatchTime.now() + Double(Int64( Double(NSEC_PER_SEC) * seconds )) / Double(NSEC_PER_SEC)
        
        DispatchQueue.main.asyncAfter(deadline: popTime) {
            completion()
        }
    }
    
    func currentAmountByItem(numeroItem:String) -> Int {
        for item in self.listaOrdenDetalle{
            if item.getNumeroItem() == numeroItem {
                return item.getDisponibilidad()
            }
        }
        return 0
    }
}

