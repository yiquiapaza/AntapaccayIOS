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

class TransportistaViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
//*****************************************Action*****************************************
/**
     #Action Button for Get all depot using Alamofire
*/
    @IBAction func almacenesButton(_ sender: UIButton) {
        let parametres: Parameters = [
            "Logial": "AND",
            "PropertyName":"tipo",
            "Value": "AT",
            "Operator":"Equals"
        ]
        Alamofire.request(LIST_ALMACENES, method: .post, parameters: parametres, encoding: JSONEncoding.default)
            .responseJSON{ response in
                switch (response.result){
                case .success(let data):
                    print(data)
                case .failure(let error):
                    print(error)
                }
                
        }
    }
/**
     #Action Button for Get all drives with states is active
*/
    @IBAction func transportistasButton(_ sender: UIButton) {
        Alamofire.request(LIST_TRANSPORTISTAS, method: .get, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON{ response in
                switch (response.result){
                case .success(let data):
                    print(data)
                case .failure(let error):
                    print(error)
                }
        }
    }
    
}
