//
//  GaleriaViewController.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 11/7/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import UIKit
import Photos

class GaleriaViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {

    var listaImagenes = Array<UIImageView>()
    @IBOutlet var collectionFotos: UICollectionView!
    let cellReuseIdentifier = "cell"
    
    //var screenSize: CGRect!
    //var screenWidth: CGFloat!
    //var screenHeight: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.listaImagenes.append(UIImageView(image: UIImage(named: "uno")))
        self.listaImagenes.append(UIImageView(image: UIImage(named: "dos")))
        self.listaImagenes.append(UIImageView(image: UIImage(named: "tres")))
        self.collectionFotos.delegate = self
        self.collectionFotos.dataSource = self
        
        //screenSize = UIScreen.main.bounds
        //screenWidth = screenSize.width
        //screenHeight = screenSize.height
        
        //let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        //layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        //layout.itemSize = CGSize(width: screenWidth / 3, height: screenWidth / 3)
        //self.collectionFotos = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        
        //self.collectionFotos.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        self.collectionFotos.register(UINib(nibName: "CellComponentCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        //self.view.addSubview(self.collectionFotos)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //let row = listaImagenes[indexPath.row]
        let cell = self.collectionFotos.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CellComponentCollectionViewCell
        //cell.autoresizesSubviews = true
        //cell.contentView.addSubview(listaImagenes[indexPath.row])
        //cell.imageView = listaImagenes[indexPath.row]
        //cell.imageView = self.listaImagenes[indexPath.row]
        let vistaImagen = UIImageView()
        vistaImagen.image = resize(image: self.listaImagenes[indexPath.row].image!, newWidth: 200)
        cell.imageView = vistaImagen
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listaImagenes.count
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.frame.size.width
        return CGSize(width: cellWidth, height: cellWidth*0.8)
    
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func resize(image: UIImage, newWidth: CGFloat) -> UIImage? {
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
