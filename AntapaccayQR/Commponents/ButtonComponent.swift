//
//  ButtonComponent.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 12/12/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import UIKit

@IBDesignable
class ButtonComponent: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    @IBInspectable
    var cornerRadius : CGFloat = 0 {
        didSet {
            refreshCorners(value: cornerRadius)
        }
    }

    override func prepareForInterfaceBuilder() {
        sharedInit()
    }
    
    func sharedInit(){
        refreshCorners(value: cornerRadius)
    }
    
    func refreshCorners(value: CGFloat) -> Void {
        layer.cornerRadius = value
    }
    
    
}
