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
    
    var contato:Contato?
    
    var delegate: ListaContatosTableViewController?
    
    
    required init?(coder aDecoder: NSCoder) {
        
        contatoDao = ContatoDao.getInstance()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        
        if contato != nil {
        
            let btnEditar = UIBarButtonItem(title: "salvar", style: .plain, target: self, action: #selector(atualizarContato))
            self.navigationItem.rightBarButtonItem = btnEditar
            
            
            txtNome.text = contato?.nome
            txtEndereco.text = contato?.endereco
            txtTelefone.text = contato?.telefone
            txtSite.text = contato?.site
        }
    }
    
    func atualizarContato(){
        pegarDadosFormulario()
        exibirListaContatos()
        
        self.delegate?.contatoAtualizado(contato!)
    }
    
    func pegarDadosFormulario() {
        
        contato?.nome = txtNome.text!
        contato?.endereco = txtEndereco.text!
        contato?.telefone = txtTelefone.text!
        contato?.site = txtSite.text!
    }
    
    func criarContato() {
        contatoDao.adicionar(contato!)
    }
    
    func exibirListaContatos() {
       _ = self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func adicionarContato(_ sender: UIBarButtonItem) {
    
        contato = Contato()
        
        pegarDadosFormulario()
        criarContato()
        exibirListaContatos()
        
        
        self.delegate?.contatoAtualizado(contato!)
    }
}

