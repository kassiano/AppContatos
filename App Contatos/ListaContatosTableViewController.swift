//
//  ListaContatosTableViewController.swift
//  App Contatos
//
//  Created by ios6570 on 3/25/17.
//  Copyright © 2017 Caelum. All rights reserved.
//

import UIKit

class ListaContatosTableViewController: UITableViewController, FormularioContatoViewControllerDelegate {

    let cellIdentifier = "celula"

    let contatoDao:ContatoDao
    var linhaDestaque:IndexPath?
    
    
    required init?(coder aDecoder: NSCoder) {
        
        contatoDao = ContatoDao.getInstance()
        contatoDao.criaContatosPadrao()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        
       // self.navigationItem.leftBarButtonItem = self.editButtonItem
       // self.editButtonItem.title = "editar"
        
        let gesto = UILongPressGestureRecognizer(target: self, action: #selector(exibePupUp(gesto:)))
        self.tableView.addGestureRecognizer(gesto)
        
    }
    
    
    func exibePupUp(gesto: UIGestureRecognizer){
     
        
        if gesto.state == .began{
        
            let ponto = gesto.location(in: self.tableView)
            
            if let index = self.tableView.indexPathForRow(at: ponto) {
                
                let contato = contatoDao.getById(id: index.row)
                    
                let acoes = GerenciadorDeAcoes(do: contato)
                
                acoes.show(on: self)
            }
        }
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
        if segue.identifier == "addSegue" {
        
            if let form = segue.destination as? ViewController{
                form.delegate = self
            }
        }
    }
    
    
    func contatoAdicionado(_ contato: Contato) {
        
        self.linhaDestaque = IndexPath(row: contatoDao.getPosition(contato), section: 0)
        //print("Contato adicionado \( (contato.nome ?? "") )")
    }
    
    func contatoAtualizado(_ contato: Contato) {
        self.linhaDestaque = IndexPath(row: contatoDao.getPosition(contato), section: 0)
        //print("Contato atualizado \( (contato.nome ?? " ") )")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
        
        
        if let linha = linhaDestaque {
            self.tableView.selectRow(at: linha, animated: true, scrollPosition: .middle)
           
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                
                self.tableView.deselectRow(at: self.linhaDestaque!, animated: true)
                self.linhaDestaque = .none
                
            })
        }
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    //Retorna o numero de linhas da tabela
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contatoDao.getAll().count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        
        let contato = contatoDao.getById(id: indexPath.row);
        
        var cell = self.tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier)
        
        if cell == nil {
    
            cell = UITableViewCell(style: .default, reuseIdentifier: self.cellIdentifier)
        }
        //print(contato.nome)
        cell?.textLabel?.text = contato.nome
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
       
        if editingStyle == .delete{
            
            self.contatoDao.delete(id: indexPath.row)
            
            //self.tableView.reloadData()
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contato = contatoDao.getById(id: indexPath.row)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let form = storyboard.instantiateViewController(withIdentifier: "FormContato") as? ViewController {
        
            form.contato = contato
            form.delegate = self
            
            self.navigationController?.pushViewController(form, animated: true)
        }
    
       // print(contato.description)
    }
}
