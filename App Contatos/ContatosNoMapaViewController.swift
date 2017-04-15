//
//  ContatosNoMapaViewController.swift
//  App Contatos
//
//  Created by ios6570 on 4/8/17.
//  Copyright © 2017 Caelum. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ContatosNoMapaViewController: UIViewController , MKMapViewDelegate{

    @IBOutlet weak var mapa: MKMapView!
    
    
    let lm = CLLocationManager()
    
    var lstContatos: [Contato]!
    
    let dao : ContatoDao
    
    
    required init?(coder aDecoder: NSCoder) {
        dao = ContatoDao.getInstance()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.mapa.delegate = self
        
        lm.requestWhenInUseAuthorization()
        
        let botaoLocalizacao = MKUserTrackingBarButtonItem(mapView: self.mapa)
        self.navigationItem.rightBarButtonItem = botaoLocalizacao
   
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
        }
        
        var pino : MKPinAnnotationView!
        
        if let dequeredPin = mapView.dequeueReusableAnnotationView(withIdentifier: "pino"){
            pino = dequeredPin as? MKPinAnnotationView
        }else{
            pino = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pino")
        }
        
        if let contato = annotation as? Contato{
            
            pino.canShowCallout = true
            let frame = CGRect(x: 0, y: 0, width: 32, height: 32)
            let imgView = UIImageView(frame: frame)
            imgView.image = contato.imagem
            pino.leftCalloutAccessoryView = imgView
        }
        
        return pino
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        lstContatos = dao.getAll()
        self.mapa.addAnnotations(lstContatos)
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.mapa.removeAnnotations(lstContatos)
    }

   

}
