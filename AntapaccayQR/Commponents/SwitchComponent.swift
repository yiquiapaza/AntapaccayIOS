//
//  SwitchComponent.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 12/12/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import UIKit

@IBDesignable
class SwitchComponent: UISwitch {

    override init(frame: CGRect) {
        super.init(frame: frame)
        sizeInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sizeInit()
    }
    
    @IBInspectable
    var sizeSwitch : CGFloat = 0{
        didSet {
            resize(value: sizeSwitch)
        }
    }
    
    override func prepareForInterfaceBuilder() {
        sizeInit()
    }
    
    func sizeInit(){
        resize(value: sizeSwitch)
    }
    
    func resize(value: CGFloat){
        self.transform = CGAffineTransform(scaleX: value, y: value)
    }
    
}
