//
//  ListaViewController.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 11/19/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import UIKit

class ListaViewController: UIViewController, UITableViewDelegate,   UITableViewDataSource {
    

    var objetoCarga = Array<Item>()
    var objetoOrden = OrdenDTO()
    var lista_guias = Array<String>()
    
    @IBOutlet weak var tableLista: UITableView!
    let cellReuseIdentifier = "cell"
    
    override func viewDidLoad() {
        for item in objetoCarga {
            let guia = item.getNumeroGuia()
            lista_guias.append(guia)
        }
            
        super.viewDidLoad()
        tableLista.delegate = self
        tableLista.dataSource = self
        tableLista.register(UINib(nibName: "BultoComponentTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
        self.view.addSubview(tableLista)
        navigationItem.leftBarButtonItem     = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cerrar Sesion", style: .plain, target: nil, action: nil)
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
        return self.objetoCarga.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableLista.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BultoComponentTableViewCell
        cell.numeroOrden.text! = objetoCarga[indexPath.row].getNumeroItem()
        cell.descripcionOrden.text! = objetoCarga[indexPath.row].getDescripcion()
        cell.quitarButton.addTarget(self, action: #selector(quitar(_: )), for: .touchDown)
        cell.numeroGuia.addTarget(self, action: #selector(agregarGuia_nuevo(_:)), for: .editingDidEnd)
        cell.numeroGuia.tag = indexPath.row
        cell.quitarButton.tag = indexPath.row
        return cell
    }
    
    @objc func quitar(_ sender: UIButton){
        objetoCarga.remove(at: sender.tag)
        tableLista.reloadData()
    }
    @objc func agregarGuia_nuevo(_ sender: UITextField){
        objetoCarga[sender.tag].setNumeroGuia(numeroGuia: sender.text!)
        print(objetoCarga[sender.tag].getNumeroGuia())
    }

    
    @objc func cerrarSession(){
        UserDefaults.standard.set(VACIO, forKey: "user")
        UserDefaults.standard.set(VACIO, forKey: "pass")
        let loginView = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        present(loginView, animated: true, completion: nil)
    }
    
}

