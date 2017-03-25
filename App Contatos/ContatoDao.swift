//
//  ContatoDao.swift
//  App Contatos
//
//  Created by ios6570 on 3/25/17.
//  Copyright © 2017 Caelum. All rights reserved.
//

import Foundation


class ContatoDao : NSObject{

    var contatos:[Contato]
    static var instance:ContatoDao?
    
    
    private override init() {
        contatos = Array()
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
