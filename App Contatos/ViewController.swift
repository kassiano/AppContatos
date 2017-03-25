//
//  ViewController.swift
//  App Contatos
//
//  Created by ios6570 on 3/25/17.
//  Copyright © 2017 Caelum. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   
    @IBOutlet weak var txtNome: UITextField!
    
    @IBOutlet weak var txtEndereco: UITextField!
    
    @IBOutlet weak var txtTelefone: UITextField!
    
    @IBOutlet weak var txtSite: UITextField!
    
    let contatoDao: ContatoDao
    
    var contato:Contato
    
    
    required init?(coder aDecoder: NSCoder) {
        
        contatoDao = ContatoDao.getInstance()
        contato = Contato()
        super.init(coder: aDecoder)
    }
    
    
    func pegarDadosFormulario() {
        contato = Contato(nome:txtNome.text!, endereco:txtEndereco.text!, telefone: txtTelefone.text!, site: txtSite.text! )
    }
    
    func criarContato()  {
        contatoDao.adicionar(contato)
    }
    
    func exibirListaContatos() {
       _ = self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func adicionarContato(_ sender: UIBarButtonItem) {
    
        pegarDadosFormulario()
        criarContato()
        exibirListaContatos()
        
        //debug
        print(contato.description)
    }
    

}

