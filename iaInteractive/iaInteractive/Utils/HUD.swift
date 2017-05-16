//
//  HUD.swift
//  KokonutTemplate
//
//  Created by Aldo Bonilla on 07/09/16.
//  Copyright © 2016 Aldo Bonilla. All rights reserved.
//  Nos permite hacer cambios faciles en el HUD si queremos cambiar el framework solo lo tendremos que hacer aqui sin hacer cambios en todas las vistas

import Foundation
import KVNProgress

class HUD {
    
    ///shows hud
    class func show() {
        KVNProgress.show()
    }
    
    ///shows hud with texto
    class func showWithStatus(_ status: String) {
        KVNProgress.show(withStatus: status)
    }
    
    ///updates hud text
    class func updateStatus(_ status:String) {
        KVNProgress.updateStatus(status)
    }
    
    ///dismiss HUD
    class func dismiss() {
        KVNProgress.dismiss()
    }
    
    ///setups HUD
    class func setupHUD() {
        configureKVNProgress()
    }
}
