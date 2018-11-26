//
//  ConsolidadoUnidadViewController.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 11/26/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import UIKit
import Alamofire
import SwiftSpinner

class ConsolidadoUnidadViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var unidades: UITextField!
    
    @IBOutlet weak var tablaPaleta: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func getUnidades(_ sender: Any) {
        let parametres : Parameters = [
            "listaOrdenes": "'" + unidades.text! + "'",
            "tipoOrden": "N",
            "consolidado": "T"
        ]
        self.delay(secons: 3.0, completatio: {
            SwiftSpinner.show("Verificando API")
            Alamofire.request(BUSQUEDA_PALETA, method: .post, parameters: parametres, encoding: JSONEncoding.default)
                .responseJSON() {
                    response in switch response.result{
                    case .success:
                        print(response.result.value)
                        SwiftSpinner.hide()
                        self.unidades.text = ""
                    case .failure(let error):
                        print(error)
                        SwiftSpinner.hide()
                    }
            }
        })
    }
    
    func delay(secons:Double, completatio: @escaping () -> ()) -> Void {
        let popTIme = DispatchTime.now() + Double(Int64(Double(NSEC_PER_SEC) * secons))/Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: popTIme){
            completatio()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tablaPaleta.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
    
}
