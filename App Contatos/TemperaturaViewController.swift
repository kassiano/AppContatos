//
//  TemperaturaViewController.swift
//  App Contatos
//
//  Created by ios6570 on 4/15/17.
//  Copyright © 2017 Caelum. All rights reserved.
//

import UIKit

class TemperaturaViewController: UIViewController {

    @IBOutlet weak var labelCondicaoAtual: UILabel!
    @IBOutlet weak var labelTemperaturaMaxima: UILabel!
    @IBOutlet weak var labelTemperaturaMinima: UILabel!
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    var URL_BASE = "http://api.openweathermap.org/data/2.5/weather?APPID=eb949f17faa6fbdb7a837ddfc7993348&units=metric"
    var URL_BASE_IMAGEM  = "http://openweathermap.org/img/w/"
    
    var contato : Contato?
    
    override func viewDidLoad() {
        
        
        if let contato = self.contato {
        
            if let endPoint = URL(string: URL_BASE + "&lat=\(contato.latitude ?? 0)&lon=\(contato.longitude ?? 0)"){
            
                let session = URLSession(configuration: .default)
                
                print(endPoint)
                
                
                let task = session.dataTask(with: endPoint) {(data, response, error) in
                
                    if let httpResponse = response as? HTTPURLResponse {
                    
                        
                        if httpResponse.statusCode == 200 {
                        
                            
                            do{
                                
                                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:AnyObject]{
                                
                                    
                                    let main = json["main"] as! [String:AnyObject]
                                    let weather = json["weather"]![0] as! [String:AnyObject]
                                    let temp_min = main["temp_min"] as! Double
                                    let temp_max = main["temp_max"] as! Double
                                    let condicao = weather["main"] as! String
                                    let icon = weather["icon"] as! String
                                    
                                    
                                    DispatchQueue.main.async {
                                        
                                        
                                        self.labelCondicaoAtual.text = condicao
                                        self.labelTemperaturaMaxima.text = temp_max.description + "°"
                                        self.labelTemperaturaMinima.text = temp_min.description + "°"
                                        
                                        self.pegarImagem(icon)
                                        
                                        
                                        
                                    }
                                    
                                }
                            
                                
                            }catch let error as NSError {
                                print(error.localizedDescription)
                            }
                            
                            
                        }
                    
                    }
                
                }
                
                task.resume()
                
            }
        }
        
        
    }
    
    
    func pegarImagem(_ icon:String){
    
        
        if let endPoint = URL(string: URL_BASE_IMAGEM + icon + ".png"){
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: endPoint) {(data, response, error) in
                
                if let httpResponse = response as? HTTPURLResponse {
                    
                    
                    if httpResponse.statusCode == 200 {
                        
                        
                        DispatchQueue.main.async {
                        
                            self.imageView.image = UIImage(data: data!)
                        }
                    }
                    
                }
                
            }
            
            task.resume()
            
        }
        
    }
    

}
