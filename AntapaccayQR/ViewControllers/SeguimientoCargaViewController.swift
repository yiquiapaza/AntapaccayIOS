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
//TODO: eliminar las variables que no se usan
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
    
    var _cantidadesItem = Dictionary<String, String>()
    
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
    
    var _discrepancias = Array<Discrepancia>()
    
    var opciones_discrepancia = Array<String>()
    let dropDownDiscrepancia = DropDown()
    @IBOutlet weak var discripencia_nombre: UILabel!
    var constante = String()
    var lista_item_discrepancia = Array<String>()
    
    var idDiscrepanciaPadreConst = String()
    var esta_mal_disenio = Int()
    
    var id_dicrepancia_mal_disenio = String()
    var id_orden_detalle_mal_disenio = String()
    var comentario_mal_disenio = String()
    var unidad_mal_disenio = String()
    var nombreProveedor_mal_disenio = String()
    var cantidadPorRecibir_mal_disenio = Int()
    var cantodadRecibidad_mal_disenio = Int()
    
    var listaOrdenes_final = Array<OrdenDetalle>()
    
    @IBAction func discrepancia(_ sender: UIButton) {
        self.opciones_discrepancia.removeAll()
        self.opciones_discrepancia.append("Sin Discrepancia")
        self.opciones_discrepancia.append("Con Discrepancia")
        self.dropDownDiscrepancia.dataSource = self.opciones_discrepancia
        self.dropDownDiscrepancia.anchorView = prueba
        self.dropDownDiscrepancia.selectionAction = {[unowned self] (index,item) in
            self.discripencia_nombre.text = item
            self.constante = item
        }
        dropDownDiscrepancia.show()
    }
    
    @IBAction func menu(_ sender: Any) {
        //ObtenerOrdenDet(_parametros: nuevo2)
        self.dropDown.dataSource.removeAll()
        self.dropDown.anchorView = prueba
        if constante == "Sin Discrepancia" {
            self.dropDown.dataSource = listItems
            self.dropDown.selectionAction = {[unowned self] (index ,item) in
                self.numeroItem.text = item
                self._numeroItem = item
                self.buscarItem.isEnabled = true
            }
        }
        if constante == "Con Discrepancia" {
            self.dropDown.dataSource = lista_item_discrepancia
            self.dropDown.selectionAction = { [unowned self] (index ,item) in
                self.numeroItem.text = item
                self._numeroItem = item
                self.buscarItem.isEnabled = true
            }
            
        }
        
        dropDown.show()
    }
    
    
    
    @IBAction func buscarItem(_ sender: UIButton) {
        //TODO: quitar cada uno de los items cada se seleccione
        dropDown.dataSource.removeAll()
        if self._numeroItem != VACIO {
            if constante == "Sin Discrepancia"{
                
                //if filtro_orden(lista: listaOrdenDetalle, orden: _numeroItem){
                    print("funciona")
                    self.cantidadRequerida.isEnabled = true
                    var _item = OrdenDetalle()
                    var indice_nuevo = Int()
                    for (index, item) in self.listaOrdenDetalle.enumerated(){
                        if item.getNumeroItem() == self._numeroItem{
                            _item = item
                            indice_nuevo = index
                            break
                        }
                    }
                    self.nombreProveedor.text = _item.getNombreProveedor()
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
                    self.delay(seconds: 0.0, completion: {
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
                    //cantidadPorRecibir + la cantidad que se ingreso
                    _item.setCantidadRecibida(cantidadRecibida: Int(self.disponible.text!)!)
                    self.listaOrdenes_final.append(_item)
                self.listaOrdenDetalle.remove(at: indice_nuevo)
                //self.listItems.remove(at: indice_nuevo)
                //}
                
                
            }
            if constante == "Con Discrepancia"{
                self.cantidadRequerida.isEnabled = true
                var _item = Discrepancia()
                for item in self._discrepancias{
                    if item.getNumeroItem() == self._numeroItem{
                        _item = item
                        break
                    }
                }
                self.idDiscrepanciaPadreConst = _item.getIdDiscrepancia()
                self.nombreProveedor.text = _item.getNombreProveedor()
                self.descripcion.numberOfLines = 0
                self._idProveedor = _item.getIdProveedor()
                self.descripcion.text = _item.getDescripcion()
                self.unidad.text = _item.getUnidad()
                self.almacen.text = _item.getAlmacen()
                self.disponible.text = String( _item.getCantidad() - (_item.getCantidadRecibida() + _item.getCantidadPorRecibir()))
                
                esta_mal_disenio = _item.getCantidadPorRecibir() + Int(self.disponible.text!)!
                
                self.id_dicrepancia_mal_disenio = _item.getIdDiscrepancia()
                self.id_orden_detalle_mal_disenio = _item.getIdOrdenDetalle()
                self.comentario_mal_disenio = _item.getComentario()
                self.unidad_mal_disenio = _item.getUnidad()
                self.nombreProveedor_mal_disenio = _item.getNombreProveedor()
                self.cantodadRecibidad_mal_disenio = _item.getCantidadRecibida()
                self.cantidadPorRecibir_mal_disenio = _item.getCantidadPorRecibir()
                
                if self._cantidadesItem.keys.contains(_item.getNumeroItem()){
                    self.disponible.text = String(_item.getCantidad() - (_item.getCantidadRecibida() + _item.getCantidadPorRecibir()))
                }
                else{
                    self.cantidadRequerida.isEnabled = true
                    self.disponible.text = String(_item.getCantidad() - (_item.getCantidadRecibida() + _item.getCantidadPorRecibir()))
                }
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
    
    func filtro_orden(lista: Array<OrdenDetalle>, orden: String) -> Bool {
        var out = Bool()
        if !lista.isEmpty{
            for item in lista{
                if item.getNumeroItem() == orden{
                    let alertOrden = PMAlertController(title: "Error", description: "Ya ingreso este item", image: UIImage(named: "error"), style: .alert)
                    alertOrden.addAction(PMAlertAction(title: "Aceptar", style: .cancel))
                    self.present(alertOrden, animated: true, completion: nil)
                    out = false
                }
                else {
                    let alertOrden = PMAlertController(title: "Exito", description: "Se Agrego correctamente el item", image: UIImage(named: "exito"), style: .alert)
                    alertOrden.addAction(PMAlertAction(title: "Aceptar", style: .cancel))
                    self.present(alertOrden, animated: true, completion: nil)
                    out =  true
                }
            }
        }
        else{
            out = true
        }
        return out
    }
        
    override func viewDidLoad() {
        self.numeroOrden.delegate = self
        self.navigationController?.view.backgroundColor = UIColor.red
        self.navigationController?.title = "ANTAPACCAI"
        self.selectState.isEnabled = true
        self.buscarItem.isEnabled = false
        self.cantidadRequerida.isEnabled = false
        self.cantidadRequerida.keyboardType = .numberPad
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cerrar Sesion", style: .plain, target: self, action: #selector(cerrarSession))
    }
    
    @IBAction func buscarOrden(_ sender: UIButton) {
        //TODO: cambiar toda la implementacion y agregar los campos necesarios
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
            let parametrosDiscrepancia: Parameters = [
                "valorOrden" : orden.getValorOrden()
            ]
            self.delay(seconds: 0.0, completion: {
                SwiftSpinner.show("Consultando Orden")
                Alamofire.request(LISTA_DISCREPANCIA, method: .post, parameters: parametrosDiscrepancia, encoding: JSONEncoding.default).responseJSON(){ response in
                    switch response.result{
                    case .success(let data):
                        print(data)
                        let out = data as! [Dictionary<String,Any>]
                        for item in out {
                            let nuevo = Discrepancia()
                            nuevo.setNumeroItem(numeroItem: item["numeroItem"] as? String ?? "")
                            nuevo.setNombreProveedor(nombreProveedor: item["idProveedor"] as? String ?? "")
                            nuevo.setDescripcion(descripcion: item["descripcion"] as? String ?? "")
                            nuevo.setUnidad(unidad: item["unidad"] as? String ?? "" )
                            nuevo.setAlmacen(almacen: item["almacen"] as? String ?? "")
                            nuevo.setCantidad(cantidad: item["cantidad"] as? Int ?? 0)
                            nuevo.setCantidadRecibida(cantidadRecibida: item["cantidadRecibida"] as? Int ?? 0)
                            nuevo.setCantidadPorRecibir(cantidadPorRecibir: item["cantidadPorRecibir"] as? Int ?? 0)
                            nuevo.setIdOrdenDetalle(idOrdenDetalle: item["idOrdenDetalle"] as? String ?? "")
                            nuevo.setIdDiscrepancia(idDiscrepancia: item["idDiscrepancia"] as? String ?? "")
                            nuevo.setUnidad(unidad: item["unidad"] as? String ?? "")
                            nuevo.setComentario(comentario: item["comentario"] as? String ?? "")
                            nuevo.setNombreProveedor(nombreProveedor: item["nombreProveedor"] as? String ?? "")
                            nuevo.setCantidadPorRecibir(cantidadPorRecibir: item["cantidadPorRecibir"] as? Int ?? 0)
                            nuevo.setCantidadRecibida(cantidadRecibida: item["cantidadRecibida"] as? Int ?? 0)
                            self._discrepancias.append(nuevo)
                        }
                        for item in self._discrepancias{
                            self.lista_item_discrepancia.append(item.getNumeroItem())
                        }
                    case .failure(let error):
                        print(error)
                    }
                }
                
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
                                    item.setId(id: ordenDetalle[ID] as! String)
                                    item.setValorOrden(valoProveedor: ordenDetalle["valorOrden"] as! String)
                                    item.setNumeroItem(numeroItem: ordenDetalle[NUMERO_ITEM] as! String)
                                    item.setTipoOrden(tipoOrden: ordenDetalle["tipoOrden"] as! String)
                                    item.setDistrito(distrito: ordenDetalle["distrito"] as! String)
                                    item.setAlmacen(almacen: ordenDetalle[ALMACEN] as! String)
                                    item.setUnidad(unidad: ordenDetalle["unidad"] as! String)
                                    item.setPartNumber(partNamber: ordenDetalle["partNumber"] as! String)
                                    item.setDescripcion(descripcion: ordenDetalle[DESCRIPCION] as? String ?? "")
                                    item.setNombreProoveedor(nombreProveedor: ordenDetalle[NOMBRE_PROVEEDOR] as! String)
                                    item.setIdProveedor(idProveedor: ordenDetalle["idProveedor"] as! String)
                                    item.setCantidadPO(cantidadPO: ordenDetalle["cantidadPO"] as! Float)
                                    item.setRecibido(recibido: ordenDetalle["recibido"] as! Int)
                                    item.setCantidadRecibida(cantidadRecibida: ordenDetalle["cantidadRecibida"] as! Int)
                                    item.setCentroCosto(centroCosto: ordenDetalle["centroCosto"] as? String ?? "")
                                    item.setRowVersion(rowVersion: ordenDetalle["RowVersion"] as? String ?? "")
                                    item.setPR(pr: ordenDetalle["PR"] as? String ?? "")
                                    item.setCentroCosto(centroCosto: ordenDetalle["centroCosto"] as? String ?? "")
                                    
                                    
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
                                let alertOrden = PMAlertController(title: "Error", description: "revise si tiene conexion a internet", image: UIImage( named: "error"), style: .alert)
                                alertOrden.addAction( PMAlertAction(title: "Aceptar", style: .cancel, action: nil))
                                self.present(alertOrden, animated: true, completion: nil)
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
        //TODO: comparar las cantidadas y quitar la agregada
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
            if constante == "Con Discrepancia"{
                nuevoItem.setCreadoDeDiscOnsite(creadoDeDiscOnsite: true)
                nuevoItem.setIdDiscrepanciaPadre(idDiscrepanciaPadre: self.idDiscrepanciaPadreConst)
                nuevoItem.setMAL_USO_REST_API(MAL_USO_REST_API: self.esta_mal_disenio)
                nuevoItem.setMAL_USO_API_REST_idDiscrepancia(MAL_USO_API_REST_idDiscrepancia: self.id_dicrepancia_mal_disenio)
                nuevoItem.setMAL_USO_API_REST_idOrdenDetalle(MAL_USO_API_REST_idOrdenDetalle: self.id_orden_detalle_mal_disenio)
                nuevoItem.setMAL_USO_API_REST_comentario(MAL_USO_API_REST_comentario: self.comentario_mal_disenio)
                nuevoItem.setMAL_USO_API_REST_unidad(MAL_USO_API_REST_unidad: self.unidad_mal_disenio)
                nuevoItem.setMAL_USO_API_REST_nombreProveedor(MAL_USO_API_REST_nombreProveedor: self.nombreProveedor_mal_disenio)
                nuevoItem.setMAL_USO_API_REST_cantidadPorRecibir(MAL_USO_API_REST_cantidadPorRecibir: self.cantidadPorRecibir_mal_disenio)
                nuevoItem.setMAL_USO_API_REST_cantidadPorRecibir(MAL_USO_API_REST_cantidadPorRecibir: self.cantodadRecibidad_mal_disenio)
            }
            self._listaItem.append(nuevoItem)
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
            vs!.objetoLista = self.listaOrdenes_final
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
        let loginView = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        present(loginView, animated: true, completion: nil)
    }
}

