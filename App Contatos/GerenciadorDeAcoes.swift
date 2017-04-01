//
//  GerenciadorDeAcoes.swift
//  App Contatos
//
//  Created by ios6570 on 4/1/17.
//  Copyright © 2017 Caelum. All rights reserved.
//

import Foundation
import UIKit

class GerenciadorDeAcoes{


    let contato:Contato
    var controller :UIViewController?
    
    init(do contato:Contato){
        self.contato = contato
    }
    
    
    func show(on controller:UIViewController){
    
        self.controller = controller
        
        
        
        let alert = UIAlertController(title: self.contato.nome, message: nil, preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: "cancelar", style: .cancel)
        
        let ligar = UIAlertAction(title: "ligar", style: .default, handler: {
            (action) in
            self.ligar()
        })

        alert.addAction(cancel)
        alert.addAction(ligar)
        
        controller.present(alert, animated: true)
    }
    
    
    func ligar(){
    }
    
}
