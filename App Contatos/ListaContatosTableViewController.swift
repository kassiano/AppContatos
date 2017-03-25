//
//  ListaContatosTableViewController.swift
//  App Contatos
//
//  Created by ios6570 on 3/25/17.
//  Copyright © 2017 Caelum. All rights reserved.
//

import UIKit

class ListaContatosTableViewController: UITableViewController {

    let cellIdentifier = "celula"

    let contatoDao:ContatoDao
    
    required init?(coder aDecoder: NSCoder) {
        
        contatoDao = ContatoDao.getInstance()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        self.editButtonItem.title = "editar"
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
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
        
            print("new UITableViewCell")
            cell = UITableViewCell(style: .default, reuseIdentifier: self.cellIdentifier)
        }
        print(contato.nome)
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
    
        print(contato.description)
    }
}
