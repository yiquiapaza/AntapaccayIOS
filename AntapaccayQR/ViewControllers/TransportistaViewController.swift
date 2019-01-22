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


class TransportistaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate  {
    @IBOutlet var vista: UIView!
    
    var guias_listas = Array<String>()
    
    var listaGuias: Array<String> = Array<String>()
    @IBOutlet weak var tablaGuias: UITableView!
    var index:Int = -1
    let cellReuseIdentifier = "cell"
    
    var objectoCarga = Array<Item>()
    var objectoOrden = OrdenDTO()
    var objetoLista = Array<OrdenDetalle>()
    
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
    
    let imagenSelect = UIImagePickerController()
    
    var constante_index = Int()
    
    var item_imagenes = Dictionary<String,Array<String>>()
    
    var elementos = Array<String>()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.imagenSelect.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cerrar Session", style: .plain, target: self, action: #selector(cerrarSession))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        self.almacenesActivate.isEnabled = false
        self.transporteActive.isEnabled = false
        let data = self.parent as! TabBarViewController
        self.objectoCarga =  data.objetoCarga
        self.objectoOrden = data.objetoOrden
        self.objetoLista = data.objetoLista
        self.dropDownAlmacenes.direction = .top
        guias_listas = numerosGuias(obj: objectoCarga )
        self.viewAlmacenes.frame(forAlignmentRect: rect)
        
        let parametres: Parameters = [
            "Logial": "AND",
            "PropertyName":"tipo",
            "Value": "AT",
            "Operator":"Equals"
        ]
        
        self.delay(seconds: 0.0, completion: {
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
        self.delay(seconds: 0.0, completion: {
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
        tablaGuias.register(UINib(nibName: "GuiaComponentTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
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
            vs!.item_imagenes = self.item_imagenes
            vs!.objetoLista = self.objetoLista
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.guias_listas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tablaGuias.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GuiaComponentTableViewCell
        cell.numeroGuia.text! = guias_listas[indexPath.row]
        cell.guardarImagen.addTarget(self, action: #selector(algoDebeHacer(_:)), for: .touchDown)
        cell.tag = indexPath.row
        return cell
    }
    
    @objc func algoDebeHacer(_ sender: UIButton ){
        print("nuevo")
        constante_index = sender.tag
        imagenSelect.allowsEditing = false
        imagenSelect.sourceType = .photoLibrary
        present(imagenSelect, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.index = indexPath.row
        print(indexPath.row)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickImage = info[.originalImage] as? UIImage{
            print("funciona")
            
            let nombre_imagen = String(Date().currentTimeMillis())
            elementos.append(nombre_imagen)
            item_imagenes.updateValue(elementos, forKey: objectoCarga[constante_index].getNumeroItem() + objectoCarga[constante_index].getNumeroGuia())
            
            saveImageDocumentDirectory(image: pickImage, imageName: nombre_imagen + ".png")
            dismiss(animated: true, completion: nil)
        }else{
            print("no funciona")
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func cerrarSession(){
        UserDefaults.standard.set(VACIO, forKey: "user")
        UserDefaults.standard.set(VACIO, forKey: "pass")
        let loginView = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        present(loginView, animated: true, completion: nil)
    }
    
    func numerosGuias(obj: Array<Item>) -> Array<String> {
        var out = Array<String>()
        if !obj.isEmpty{
            for item in obj{
                out.append(item.getNumeroGuia())
                item_imagenes.updateValue([], forKey: item.getNumeroItem() + item.getNumeroGuia())
            }
        }
        return out
    }
    
    func saveImageDocumentDirectory(image: UIImage, imageName: String) {
        let fileManager = FileManager.default
        let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("AntapaccayGuia")
        if !fileManager.fileExists(atPath: path) {
            try! fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        }
        let url = NSURL(string: path)
        let imagePath = url!.appendingPathComponent(imageName)
        let urlString: String = imagePath!.absoluteString
        let imageData = image.pngData()
        fileManager.createFile(atPath: urlString as String, contents: imageData, attributes: nil)
    }
    
    func numeroGuias2(obj : Array<Item>) -> Array<String>{
        var out = Array<String>()
        
        if !obj.isEmpty{
            var lista = Array<String>()
            for item in obj{
                let nuevo = item.getNumeroGuia()
                lista.append(nuevo)
            }
            for item in lista{
                if !lista.contains(item){
                    out.append(item)
                }
            }
        }
        
        return out
    }
}
