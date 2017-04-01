//
//  ContatoDao.swift
//  App Contatos
//
//  Created by ios6570 on 3/25/17.
//  Copyright © 2017 Caelum. All rights reserved.
//

import Foundation


class ContatoDao {

    var contatos: [Contato]
    static var instance:ContatoDao?
    
    
    private init() {
        contatos = [Contato]()
        contatos.append(Contato(nome: "Teste 1", endereco: "Rua vergueiro", telefone: "889956", site: "google.com"))
        contatos.append(Contato(nome: "Teste 2", endereco: "Rua vergueiro", telefone: "889956", site: "google.com"))
    }
    
    
    func getPosition(_ contato:Contato) -> Int{
    
        return contatos.index(of: contato)!
    }
    
    func delete(id:Int)  {
        contatos.remove(at: id)
    }
    
    func getById(id:Int) ->Contato{
        return contatos[id]
    }
    
    func getAll() -> [Contato]{
        return contatos;
    }
    
    func adicionar(_ contato:Contato){
        self.contatos.append(contato)
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
        
        return self.instance!;
    }

}
