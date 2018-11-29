//
//  PartidaCargaViewController.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 11/28/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import UIKit
import Alamofire

class PartidaCargaViewController: UIViewController {

    var lista = Array<Registro>()
    
    @IBOutlet weak var numeroGuia: UITextField!
    @IBOutlet weak var almacenDestino: UILabel!
    @IBOutlet weak var puntoPartida: UILabel!
    @IBOutlet weak var numero_guia: UILabel!
    @IBOutlet weak var numero_transporte: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func buscar(_ sender: UIButton) {
        
        let parametres : Parameters = [
            "numeroGuia" : numeroGuia.text!,
            "estadoTransporte" :"1"
        ]
        
        Alamofire.request(BUSQUEDA_GUIA_ENTRADA, method: .post, parameters: parametres, encoding: JSONEncoding.default)
            .responseJSON(){
                response in switch response.result{
                case .success(let data):
                    var transporte  =  Int()
                    let nuevo = data as! [Dictionary <String, AnyObject>]
                    transporte = nuevo[0]["numeroTransporte"] as! Int
                    self.numero_guia.text = self.numeroGuia.text
                    self.numero_transporte.text = String(transporte)
                    for item in nuevo{
                        let a = Registro()
                        a.setId(id: item["Id"] as! String)
                        a.setIdPuntoPartida(idPuntoPartida: item["idPuntoPartida"] as! String)
                        a.setCodigoDestino(codigoDestino: item["codigoDestino"] as! String)
                        a.setNumeroTransporte(numeroTransporte: item["numeroTransporte"] as! Int)
                        a.setCodigo(codigo: item["codigo"] as! String)
                        a.setNombrePuntoPartida(nombrePuntoPartida: item["nombrePuntoPartida"] as! String)
                        a.setNombreDestino(nombreDestino: item["nombreDestino"] as! String)
                        a.setCodigoVehiculo(codigoVehiculo: item["codigoVehiculo"] as! String)
                        a.setCodigoConfiguracionTracto(codigoConfiguracionTracto: item["codigoConfiguracionTracto"] as! String)
                        a.setConfiguracionTracto(configuracionTracto: item["configuracionTracto"] as! String)
                        a.setPlacaRemolque(placaRemolque: item["placaRemolque"] as! String)
                        a.setCodigoTipoRemolque(codigoTipoRemolque: item["codigoTipoRemolque"] as! String)
                        a.setTipoRemolque(tipoRemolque: item["tipoRemolque"] as! String)
                        a.setCodigoConductor(codigoConductor: item["codigoConductor"] as! String)
                        a.setNombreConductor(nombreConductor: item["nombreConductor"] as! String)
                        a.setServicioExpreso(servicioExpreso: item["servicioExpreso"] as! Bool)
                        a.setPrecio(precio: item["precio"] as! Float)
                        a.setEstadoTransporte(estadoTransporte: item["estadoTransporte"] as! String)
                        a.setCodigoConfiguracionRemolque(codigoConfiguracionRemolque: item["codigoConfiguracionRemolque"] as! String)
                        a.setConfiguracionRemolque(configuracionRemolque: item["configuracionRemolque"] as! String)
                        a.setFechaInicio(fechaInicio: item["fechaInicio"] as! Int)
                        a.setFechaFin(fechaFin: item["fechaFin"] as! Int)
                        a.setFechaTentativaFin(fechaTentativaFin: item["fechaTentativaFin"] as! Int)
                        a.setTotalPaletas(totalPaletas: item["totalPaletas"] as! Int)
                        a.setGuiaAntapaccay(guiaAntapaccay: item["guiaTransportista"] as! Bool)
                        a.setGuiaAntapaccay(guiaAntapaccay: item["guiaAntapaccay"] as! Bool)
                        a.setCodigoTransportista(codigoTransportista: item["codigoTransportista"] as! String)
                        a.setTransportista(transportista: item["transportista"] as! String)
                        a.setRowVersion(RowVersion: item["RowVersion"] as! String)
                        self.lista.append(a)
                    }
                    print(data)
                case .failure(let error):
                    print(error)
                }
        }
        
        Alamofire.request(ALMACEN_GUIA_ENTRADA, method: .post, parameters: parametres, encoding: JSONEncoding.default)
            .responseJSON(){
                response in switch response.result{
                case .success(let data):
                    let nuevo = data as! [Dictionary<String,AnyObject>]
                    self.almacenDestino.text = nuevo[0]["nombreAlmacen"] as? String
                    self.puntoPartida.text = nuevo[0]["idAlmacenRecepcion"] as? String
                    print(data)
                case .failure(let error):
                    print(error)
                }
        }
    }
    @IBAction func registrarPartida(_ sender: Any) {
        
        let transporteRecorrido : Parameters = [
            "Id" : CONST_ID,
            "RowVersion" : CONST_ROW_VERSION,
            "idTransporte" : lista[0].getId(),
            "fecha" : obtenerFecha(),
            "tipoOperacion": "PARTIDA",
            "usuarioOperacion": "",
            "codigoPuntoControl": lista[0].getIdPuntoPartida(),
            "nombrePuntoControl": lista[0].getNombrePuntoPartida()
        ]
        let transporteVehiculo : Parameters = [
            "Id" : CONST_ID,
            "RowVersion" : CONST_ROW_VERSION,
            "idTransporte" : lista[0].getId(),
            "codigoVehiculo": lista[0].getCodigoVehiculo(),
            "placaRemolque": lista[0].getPlacaRemolque(),
            "codigoConductor": lista[0].getCodigoConductor(),
            "nombreConductor": lista[0].getNombreConductor(),
            "codigoTipoRemolque": lista[0].getCodigoTipoRemolque(),
            "tipoRemolque": lista[0].getTipoRemolque(),
            "codigoConfiguracionRemolque": lista[0].getCodigoConfiguracionRemolque(),
            "configuracionRemolque": lista[0].getConfiguracionRemolque(),
            "codigoAlmacenDestino" : lista[0].getCodigoDestino(),
            "nombreAlmacenDestino" : lista[0].getNombreDestino(),
            "fechaAsignacion" : obtenerFecha(),
            "codigoLugarAsignacion": lista[0].getIdPuntoPartida(),
            "lugarAsignacion" : lista[0].getNombrePuntoPartida(),
            "nombreOperador" : ""
        ]
        let transporte : Parameters = [
            "Id": lista[0].getId(),
            "idPuntoPartida" : lista[0].getIdPuntoPartida(),
            "codigoDestino" : lista[0].getCodigoDestino(),
            "numeroTransporte": lista[0].getNumeroTransporte(),
            "codigo": lista[0].getCodigo(),
            "nombrePuntoPartida" : lista[0].getNombrePuntoPartida(),
            "nombreDestino" : lista[0].getNombreDestino(),
            "codigoVehiculo": lista[0].getCodigoVehiculo(),
            "codigoConfiguracionTracto": lista[0].getCodigoConfiguracionTracto(),
            "configuracionTracto": lista[0].getConfiguracionTracto(),
            "placaRemolque": lista[0].getPlacaRemolque(),
            "codigoTipoRemolque": lista[0].getCodigoTipoRemolque(),
            "tipoRemolque" : lista[0].getTipoRemolque(),
            "codigoConductor" : lista[0].getCodigoConductor(),
            "nombreConductor" : lista[0].getNombreConductor(),
            "servicioExpreso" : lista[0].getServicioExpreso(),
            "precio" : lista[0].getPrecio(),
            "estadoTransporte" : 2,// este cambiar
            "codigoConfiguracionRemolque" : lista[0].getCodigoConfiguracionRemolque(),
            "configuracionRemolque": lista[0].getConfiguracionRemolque(),
            "fechaInicio" : obtenerFecha(),
            "totalPaletas" : lista[0].getTotalPaletas(),
            "guiaTransportista": lista[0].getGuiaTransportista(),
            "guiaAntapaccay": lista[0].getGuiaAntapaccay(),
            "codigoTransportista" : lista[0].getCodigoTransportista(),
            "transportista" : lista[0].getTransportista(),
            "RowVersion" : lista[0].getRowVersion()
        ]
        
        let parameters : Parameters = [
            "transporteRecorrido" : transporteRecorrido,
            "transporteVehiculo" : transporteVehiculo,
            "transporte" : transporte
        ]
        
        Alamofire.request(REGISTRO_ENTRADA, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON(){
                response in switch response.result{
                case .success(let data):
                    print(data)
                case .failure(let error):
                    print(error)
                }
        }
    }
    
    func delay(secons:Double, completatio: @escaping () -> ()) -> Void {
        let popTIme = DispatchTime.now() + Double(Int64(Double(NSEC_PER_SEC) * secons))/Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: popTIme){
            completatio()
        }
    }
    
    func obtenerFecha() -> Int {
        var fechaCadena = String()
        let anio = Calendar.current.component(.year, from: Date())
        let mes = Calendar.current.component(.month, from: Date())
        let dia = Calendar.current.component(.day, from: Date())
        if dia < 10{
            fechaCadena = String(anio) + String(mes) + "0" + String(dia)
        }
        else {
            fechaCadena = String(anio) + String(mes) + String(dia)
        }
        return Int(fechaCadena)!
    }
    
}
/*

 
 
 para buscar el consolidado y el bulto con  1
 y cambio de estado a 2

 salida consolidado con estado 2
 y cambio estado a 3
 
 */
