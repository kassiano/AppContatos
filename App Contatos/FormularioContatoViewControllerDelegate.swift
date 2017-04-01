//
//  FormularioContatoViewControllerDelegate.swift
//  App Contatos
//
//  Created by ios6570 on 4/1/17.
//  Copyright © 2017 Caelum. All rights reserved.
//

import Foundation

protocol FormularioContatoViewControllerDelegate {
    
    func contatoAtualizado(_ contato:Contato)
    func contatoAdicionado(_ contato:Contato)
}
