//
//  Contato.swift
//  App Contatos
//
//  Created by ios6570 on 3/25/17.
//  Copyright © 2017 Caelum. All rights reserved.
//

import UIKit


class Contato : Equatable {

    var nome:String?
    var endereco:String?
    var telefone:String?
    var site:String?
    var imagem:UIImage?
    var latitude:NSNumber?
    var longitude:NSNumber?
    
    init(){
    }
    
    init(nome:String, endereco:String, telefone:String, site:String) {
        
        self.nome = nome;
        self.endereco = endereco;
        self.telefone = telefone;
        self.site = site;
    }
    
    var description: String{
        return "Nome: \(self.nome)\nEnd.: \(self.endereco)\nTelefone: \(self.telefone)\nSite: \(self.site)";
    }

    
    static func ==(lhs: Contato, rhs: Contato) -> Bool{
        
        if(lhs === rhs)
        {
            return true
        }
        /*if lhs.nome == rhs.nome {
            return true
        }*/
        
        return false
    }
}


