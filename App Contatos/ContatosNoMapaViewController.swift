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

class ContatosNoMapaViewController: UIViewController {

    @IBOutlet weak var mapa: MKMapView!
    
    
    let lm = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        lm.requestWhenInUseAuthorization()
        
        let botaoLocalizacao = MKUserTrackingBarButtonItem(mapView: self.mapa)
        self.navigationItem.rightBarButtonItem = botaoLocalizacao
   
    }

   

}
