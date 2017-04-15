//
//  ContatoDao.swift
//  App Contatos
//
//  Created by ios6570 on 3/25/17.
//  Copyright © 2017 Caelum. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ContatoDao : CoreDataUtil {

    var contatos: [Contato]
    static var instance:ContatoDao?
    
    
    private override init() {
        
        contatos = [Contato]()
    }
    
    
    func novoContato() -> Contato{
    
        return Contato(context: self.persistentContainer.viewContext)
    }
    
    
    
    func criaContatosPadrao(){
        
        
        let conf = UserDefaults.standard
        
        let jafoi = conf.bool(forKey: "ja_inseridos")
        
        if (!jafoi){
        
            
            let walt = self.novoContato()
            walt.nome = "Walter White"
            walt.endereco = "Av Paulista"
            walt.telefone = "889956"
            walt.site = "google.com"
                
            /*
            let saul = Contato(context : context!,nome: "Saul", endereco: "Rua vergueiro", telefone: "889956", site:    "google.com")
            let gus = Contato(context : context!,nome: "Gustavo", endereco: "Av 9 de Julho", telefone: "11999952", site: "lospolloshermanos.com")
             saul.imagem = UIImage(named: "saul")
             gus.imagem = UIImage(named: "gus")
             //contatos.append(walt)
             */
            
            walt.imagem = UIImage(named: "walterwhite")
            
        
            self.saveContext()
            
            conf.set(true, forKey: "ja_inseridos")
            conf.synchronize()
            
        }
    }
    
    
    func carregarContatos(){
     
        let busca = NSFetchRequest<Contato>(entityName: "Contato")
        let orderBy = NSSortDescriptor(key: "nome", ascending: true)
        
        busca.sortDescriptors = [orderBy]
        
        do{
            self.contatos = try self.persistentContainer.viewContext.fetch(busca)
            
        }catch let erro as NSError{
        
            print("Erro: \(erro.localizedDescription)")
        }
    }
    
    
    func getPosition(_ contato:Contato) -> Int{
    
        return contatos.index(of: contato)!
    }
    
    func delete(id:Int)  {
        contatos.remove(at: id)
         self.saveContext()
    }
    
    func getById(id:Int) ->Contato{
        return contatos[id]
    }
    
    func getAll() -> [Contato]{
        return contatos;
    }
    
    func adicionar(_ contato:Contato){
        self.contatos.append(contato)
        self.saveContext()
    }
    
    
    func printAll(){
        
      /*  for <#item#> in self.contatos {
            print((Contato)item)
        }*/
    }
    
    static func getInstance() -> ContatoDao{
    
        if self.instance==nil {
            self.instance = ContatoDao();
        }
        
        instance?.carregarContatos()
        return self.instance!;
    }

}
