//
//  Contato.swift
//  App Contatos
//
//  Created by ios6570 on 3/25/17.
//  Copyright © 2017 Caelum. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class Contato : NSManagedObject , MKAnnotation {

    @NSManaged var nome:String?
    @NSManaged var endereco:String?
    @NSManaged var telefone:String?
    @NSManaged var site:String?
    @NSManaged var imagem:UIImage?
    @NSManaged var latitude:NSNumber?
    @NSManaged var longitude:NSNumber?
    
    override var description: String{
        return "Nome: \(self.nome)\nEnd.: \(self.endereco)\nTelefone: \(self.telefone)\nSite: \(self.site)";
    }

    
    static func ==(lhs: Contato, rhs: Contato) -> Bool{
        
        if(lhs === rhs)
        {
            return true
        }
        /*if lhs.nome == rhs.nome {
            return true
        }*/
        
        return false
    }
    
    
    
    public var coordinate: CLLocationCoordinate2D {
        get{
            return CLLocationCoordinate2DMake(CLLocationDegrees(self.latitude!)  , CLLocationDegrees(self.longitude!) )
        }
    }
    
    
    // Title and subtitle for use by selection UI.
    public var title: String? {
        get {
           return self.nome
        }
    }
    
    public var subtitle: String? {
        get{
            return self.endereco
        }
    }
    
}


