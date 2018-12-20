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
import PMAlertController

class SeguimientoCargaViewController: UIViewController, UITextFieldDelegate {
 
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
            
            let parametres : Parameters = [
                "filtros": [
                    [
                        "PropertyName": "valorOrden",
                        "Operator": "Contains",
                        "value": self.numeroOrden.text!,
                        "Logical": "AND"
                    ],
                    [
                        "PropertyName": "numeroItem",
                        "Operator": "Contains",
                        "value": _item.getNumeroItem(),
                        "Logical": "AND"
                    ]
                ],
                "orden": [
                    [
                        "OrderType": "DESC",
                        "Property" : "Id",
                        "Index": "1"
                    ]
                ],
                "startIndex": 0,
                "length": 1000
            ]
            var cantidad_nueva = 0
            self.delay(seconds: 3.0, completion: {
                SwiftSpinner.show("Consultado Cantidad Actual")
                Alamofire.request(OBTENER_CANTIDAD_ACTUAL, method: .post, parameters: parametres, encoding:  JSONEncoding.default)
                    .responseJSON() {
                        response in switch response.result{
                        case .success(let data):
                            print(data)
                            let out = data as! [Dictionary<String, AnyObject>]
                            cantidad_nueva = out[0]["cantidadPorRecibir"] as! Int
                            SwiftSpinner.hide()
                        case .failure(let data):
                            print(data)
                            SwiftSpinner.hide()
                        }
                    }
                }
            )
            if self._cantidadesItem.keys.contains(_item.getNumeroItem()){
                self.disponible.text = String(_item.getDisponibilidad() - Int(self._cantidadesItem[_item.getNumeroItem()]!)! + cantidad_nueva)
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
        self.numeroOrden.delegate = self
        self.navigationController?.view.backgroundColor = UIColor.red
        self.navigationController?.title = "ANTAPACCAI"
        self.selectState.isEnabled = false
        self.buscarItem.isEnabled = false
        self.cantidadRequerida.isEnabled = false
        self.cantidadRequerida.keyboardType = .numberPad
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cerrar Sesion", style: .plain, target: self, action: #selector(cerrarSession))
        navigationItem.leftBarButtonItem     = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)


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
            let RUTA = switchID.isOn ? LIST_ORDEN_DET_ID : LIST_ORDEN_DET
            let parametros: Parameters = [
                VALOR_ORDEN : orden.getValorOrden(),
                TIPO_ORDEN: orden.getTipoOrden(),
                ID_COMPRADOR: orden.getIdCmprador(),
                CODIGO_DISTRITO: orden.getCodigoDistrito(),
                PRICE_CODE: orden.getPriceCode()
            ]
            self.delay(seconds: 3.0, completion: {
                SwiftSpinner.show("Consultando Orden")
                    Alamofire.request(RUTA, method: .post,parameters: parametros, encoding: JSONEncoding.default)
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
            let alertOrden = PMAlertController(title: "Ingrese un Tipo Orden", description: "Es un Campo Obligatorio", image: UIImage( named: "precaucion"), style: .alert)
            alertOrden.addAction( PMAlertAction(title: "Aceptar", style: .cancel, action: nil))
            self.present(alertOrden, animated: true, completion: nil)
        }
        if (numeroOrden.text!.trimmingCharacters(in: .whitespacesAndNewlines) == VACIO && orden.getTipoOrden() != VACIO) {
            let alertOrden = PMAlertController(title: "Escriba el Numero de Orden", description: "Es un Campo Obligatorio", image: UIImage( named: "precaucion"), style: .alert)
            alertOrden.addAction(PMAlertAction(title: "Aceptar", style: .cancel))
            self.present(alertOrden, animated: true, completion: nil)
        }
        if(numeroOrden.text!.trimmingCharacters(in: .whitespacesAndNewlines) == VACIO && orden.getTipoOrden() == VACIO) {
            let alertOrden = PMAlertController(title: "Escriba y Ingrese la orden", description: "Son Campos Obligatorios", image: UIImage(named: "precaucion"), style: .alert)
            alertOrden.addAction(PMAlertAction(title: "Aceptar", style: .cancel))
            self.present(alertOrden, animated: true, completion: nil)
        }

        
    }
    
    
    @IBAction func switchChangeOC(_ sender: UISwitch) {
        if sender.isOn {
            switchID.setOn(false, animated: true)
            switchOS.setOn(false, animated: true)
            switchOR.setOn(false, animated: true)
            orden.setTipoOrden(tipoOrden: SWITCH_OC)
            orden.setPriceCode(priceCode: VACIO )
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
            orden.setPriceCode(priceCode: VACIO )
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
            orden.setPriceCode(priceCode: "RP" )
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
            orden.setPriceCode(priceCode: VACIO )
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
                    let alertOrden = PMAlertController(title: "Error", description: "La cantidad no puede exceder al total", image: UIImage(named: "error"), style: .alert)
                    alertOrden.addAction(PMAlertAction(title: "Aceptar", style: .cancel))
                    self.present(alertOrden, animated: true, completion: nil)
                }
            }
            self.cantidadRequerida.text = VACIO
        }
        else {
            let alertOrden = PMAlertController(title: "Error", description: "Solo estan Permitidos caracteres Numericos", image: UIImage(named: "error"), style: .alert)
            alertOrden.addAction(PMAlertAction(title: "Aceptar", style: .cancel))
            self.present(alertOrden, animated: true, completion: nil)
        }
    }
    
    @IBAction func crearBulto(_ sender: UIButton) {
        if self._listaItem.isEmpty{
            let alertOrden = PMAlertController(title: "Error", description: "Su bulto debe de tener minimo un elemento", image: UIImage(named: "error"), style: .alert)
            alertOrden.addAction(PMAlertAction(title: "Aceptar", style: .cancel))
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.numeroOrden.resignFirstResponder()
        return true
    }
    
    
    @objc func cerrarSession() -> Void {
        UserDefaults.standard.set(VACIO, forKey: "user")
        UserDefaults.standard.set(VACIO, forKey: "pass")
    }
}

