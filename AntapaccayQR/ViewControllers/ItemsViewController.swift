//
//  ItemsViewController.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 12/26/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import UIKit

class ItemsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var listaItems = Array<ItemBulsto>()
    @IBOutlet weak var tableItems: UITableView!
    var cellReuseIdentifier:String = "cell"
    
    override func viewDidLoad() {
        
        tableItems.delegate = self
        tableItems.dataSource = self
        tableItems.register(UINib(nibName: "ItemsVerificaTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
        super.viewDidLoad()
        for item in listaItems{
            print(item.getId())
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listaItems.count
    }
    
    //@IBOutlet weak var buttonInConforme: UIButton!
    //@IBOutlet weak var buttonConforme: UIButton!

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableItems.dequeueReusableCell(withIdentifier: "cell",for:  indexPath) as! ItemsVerificaTableViewCell
        cell.numeroItem.text = self.listaItems[indexPath.row].getNumeroItem()
        cell.descripcion.numberOfLines = 0
        cell.descripcion.text = self.listaItems[indexPath.row].getDescripcion()
        cell.cantidad.text = String(self.listaItems[indexPath.row].getCantidad())
        cell.buttonConforme.addTarget(self, action: #selector(conforme(_:)), for: .touchDown)
        cell.buttonInConforme.addTarget(self, action: #selector(disconforme(_:)), for: .touchDown)
        return cell
    }
    
    @objc func conforme( _  sender: UIButton){
        print("Confirmacion")
    }
    
    @objc func disconforme( _ sender : UIButton){
        print("No quiere")
    }
}
