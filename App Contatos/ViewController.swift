//
//  ViewController.swift
//  App Contatos
//
//  Created by ios6570 on 3/25/17.
//  Copyright © 2017 Caelum. All rights reserved.
//

import UIKit
import LocalAuthentication
import CoreLocation

class ViewController: UIViewController, UINavigationControllerDelegate ,
UIImagePickerControllerDelegate{

   
    @IBOutlet weak var txtNome: UITextField!
    
    @IBOutlet weak var txtEndereco: UITextField!
    
    @IBOutlet weak var txtTelefone: UITextField!
    
    @IBOutlet weak var txtSite: UITextField!
    
    let contatoDao: ContatoDao
    
    var contato:Contato?
    
    var delegate: ListaContatosTableViewController?
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var txtLatitude: UITextField!
    
    @IBOutlet weak var txtLongitude: UITextField!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let context = LAContext()
    var erro: NSError?
    
    required init?(coder aDecoder: NSCoder) {
        
        contatoDao = ContatoDao.getInstance()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        
        if contato != nil {
        
            let btnEditar = UIBarButtonItem(title: "salvar", style: .plain, target: self, action: #selector(atualizarContato))
            self.navigationItem.rightBarButtonItem = btnEditar
            
            
            txtNome.text = contato?.nome
            txtEndereco.text = contato?.endereco
            txtTelefone.text = contato?.telefone
            txtSite.text = contato?.site
            
            txtLongitude.text = contato?.longitude?.description
            txtLatitude.text = contato?.latitude?.description
            
            
            if let img = contato?.imagem {
                imageView.image = img
            }
            
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(selecionarFoto(sender:)))
        self.imageView.addGestureRecognizer(tap)
        
        /*
        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &erro) else{
        
            print("não disponivel")
            return
        }
        
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Pessoas autorizadas") { (sucesso, erro) in
        
            if( !sucesso){
                //fechar app
                print("não sucesso")
                let control = UIControl()
                control.sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
            }else{
                print("sucesso")
            }
        }
        */
        
    }
    
    func atualizarContato(){
        pegarDadosFormulario()
        exibirListaContatos()
        
        self.delegate?.contatoAtualizado(contato!)
    }
    
    func pegarDadosFormulario() {
        
        contato?.nome = txtNome.text!
        contato?.endereco = txtEndereco.text!
        contato?.telefone = txtTelefone.text!
        contato?.site = txtSite.text!
        contato?.imagem = imageView.image
        
        
        if let latInt = Int(txtLatitude.text!) {
            let latitude = NSNumber(value:latInt)
            contato?.latitude = latitude
        }
        
        if let lonInt = Int(txtLongitude.text!) {
            let longitude = NSNumber(value:lonInt)
            contato?.longitude = longitude
        }
        
    }
    
    func criarContato() {
        contatoDao.adicionar(contato!)
    }
    
    func selecionarFoto(sender: AnyObject) {

        
        if(UIImagePickerController.isSourceTypeAvailable(.camera)){
            print("Camera")
        
            let alert = UIAlertController(title: "Escolha foto do contato", message: self.contato?.nome, preferredStyle: .actionSheet)
            
            
            let cancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
            
            let actionCamera = UIAlertAction(title: "Tirar foto", style: .default, handler: {
                (action) in
                self.pegaFoto(de: .camera)
            })
            
            let actionGaleria = UIAlertAction(title: "Abrir Galeria", style: .default, handler: {
                (action) in
                self.pegaFoto(de: .photoLibrary)
            })
            
            
            alert.addAction(cancelar)
            alert.addAction(actionCamera)
            alert.addAction(actionGaleria)
        }else{
        
            self.pegaFoto(de: .photoLibrary)

        }
    }
    
    
    func pegaFoto(de sourceType:UIImagePickerControllerSourceType){
    
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        
        if let imagemSelecionada = info[UIImagePickerControllerEditedImage] as? UIImage{
            self.imageView.image = imagemSelecionada
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func exibirListaContatos() {
       _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet var selectImage: UITapGestureRecognizer!
    
    @IBAction func adicionarContato(_ sender: UIBarButtonItem) {
    
        contato = Contato()
        
        pegarDadosFormulario()
        criarContato()
        exibirListaContatos()
        
        
        self.delegate?.contatoAtualizado(contato!)
    }
    
    
    @IBAction func getGpsLocation(_ sender: AnyObject) {
        
        
        let geoCord = CLGeocoder()
        
        activityIndicator.startAnimating()
        
        if let btn = sender as? UIButton{
            btn.isHidden = true
        }
        
        geoCord.geocodeAddressString(self.txtEndereco.text!, completionHandler: {
            (resultado, erro) in
            
            if erro == nil && resultado!.count > 0{
                
                let placeMark = resultado![0]
                
                let coord = placeMark.location!.coordinate
                
                self.txtLatitude.text = coord.latitude.description
                self.txtLongitude.text = coord.longitude.description
                    
                if let btn = sender as? UIButton{
                    btn.isHidden = false
                }
            
            }
        
        })
        
    }
    
}

