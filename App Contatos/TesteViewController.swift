//
//  TesteViewController.swift
//  App Contatos
//
//  Created by ios6570 on 4/1/17.
//  Copyright © 2017 Caelum. All rights reserved.
//

import UIKit

class TesteViewController: UIViewController , UITableViewDataSource , UITableViewDelegate{

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var txtTask: UITextField!
    

    var taskList = Array<String>()
    
    
    override func viewDidLoad() {
        taskList.append("Enviar email para kelly")
        taskList.append("Ler o livro do Jung")
        taskList.append("Assistir o ep 3 do Touch")
    
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    @IBAction func addToTable(_ sender: AnyObject) {
        
        self.taskList.append(txtTask.text!)
        tableView.reloadData()
        
        txtTask.text = ""
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskList.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = taskList[indexPath.row]
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        print(taskList[indexPath.row])
        
    }

}
