//
//  GerenciadorDeAcoes.swift
//  App Contatos
//
//  Created by ios6570 on 4/1/17.
//  Copyright © 2017 Caelum. All rights reserved.
//

import Foundation
import UIKit

class GerenciadorDeAcoes{


    let contato:Contato
    var controller :UIViewController?
    
    init(do contato:Contato){
        self.contato = contato
    }
    
    
    func show(on controller:UIViewController){
    
        self.controller = controller
        
        
        
        let alert = UIAlertController(title: self.contato.nome, message: nil, preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: "cancelar", style: .cancel)
        
        let ligar = UIAlertAction(title: "ligar", style: .default, handler: {
            (action) in
            self.ligar()
        })
        
        
        let abrirSite = UIAlertAction(title: "Abrir Site", style: .default, handler: {
            (action) in
            self.abrirSite()
        })

        let exibirMapa = UIAlertAction(title: "Exibir Mapa", style: .default, handler: {
            (action) in
            self.exibirMapa()
        })
        
        alert.addAction(cancel)
        alert.addAction(ligar)
        alert.addAction(abrirSite)
        alert.addAction(exibirMapa)
        
        controller.present(alert, animated: true)
    }
    
    func abrirSite(){
    
        var site = contato.site!
        
        if !(site.hasPrefix("http://")){
        
            site = "http://" + site
        
        }
 
        abrirApp(url: site)
    }
    
    func ligar(){
        let dev = UIDevice.current
        
        if dev.model == "iPhone"{
        
            self.abrirApp(url: "tel:" + contato.telefone!)
            
        }else{
        
            let alert = UIAlertController(title: "Impssivel fazer ligação", message: "Seu dispositivo não suporta", preferredStyle: .alert)
            
            controller?.present(alert, animated: true, completion: nil)
            
        }
    }

    func exibirMapa(){
        let url = ("http://maps.google.com/maps?q=" + self.contato.endereco!).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        abrirApp(url: url)
    }
    
    
    private func abrirApp(url:String){
    
        UIApplication.shared.open(URL(string:url)!, options: [:], completionHandler: nil)
        
    }
    
}
