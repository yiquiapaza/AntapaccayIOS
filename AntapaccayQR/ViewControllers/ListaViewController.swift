//
//  ListaViewController.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 11/19/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import UIKit

class MyCell: UITableViewCell {
    
    
    
}


class ListaViewController: UIViewController, UITableViewDelegate,   UITableViewDataSource {
    

    var objetoCarga = Array<Item>()
    var objetoOrden = OrdenDTO()
    
    @IBOutlet weak var tableLista: UITableView!
    let cellReuseIdentifier = "cell"
    var listaSting: Array<String> = Array<String>()
    var index:Int = -1
    
    
    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden = true
        for item in objetoCarga{
            let nuevo = item.getDescripcion()
            listaSting.append(nuevo)
        }
        super.viewDidLoad()

        tableLista.delegate = self
        tableLista.dataSource = self
        tableLista.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        self.view.addSubview(tableLista)
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is SeguimientoCargaViewController
        {
            let vs = segue.destination as? SeguimientoCargaViewController
            vs!._listaItem = self.objetoCarga
        }
        
        if segue.destination is TabBarViewController
        {
            let vs = segue.destination as? TabBarViewController
            vs!.objetoCarga = self.objetoCarga
            vs!.objetoOrden = self.objetoOrden
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listaSting.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableLista.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.listaSting[indexPath.row]
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 300))
        button.addTarget(self, action: #selector(quitar(_:)), for: .touchDown)
        button.setTitle("", for : .normal)
        button.setTitleColor(.white, for: .normal)
        button.setImage(UIImage(named:"icons8-delete_filled"), for: .normal)
        cell.accessoryView = button

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.index = indexPath.row
        print(indexPath.row)
    }
    
    @objc func quitar(_ sneder: UIButton){
        print("Elimine la filas")
        self.listaSting.remove(at: index)
        self.objetoCarga.remove(at: index)
        print(index)
        tableLista.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableLista.reloadData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
}

