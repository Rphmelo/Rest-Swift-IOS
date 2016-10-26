//
//  ViewController.swift
//  Aula_Json_Rest
//
//  Created by Usuário Convidado on 15/09/16.
//  Copyright © 2016 Felipe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var lblRua: UILabel!
    @IBOutlet weak var lblCid: UILabel!
    @IBOutlet weak var lblBai: UILabel!
    @IBOutlet weak var lblEst: UILabel!
    
    
    
    
    @IBAction func btChamar(sender: AnyObject) {
        //cria uma configuração de sessao padrão
        let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
        //cria uma sessao com a configuração default
        session = NSURLSession(configuration: sessionConfig)
        //URL de acesso a API do itunes do top Free App
        
        let cep = "http://viacep.com.br/ws/" + txtCep.text! + "/json"
        
        let url = NSURL(string: cep)
        let task = session!.dataTaskWithURL(url!) { (data:NSData?, response:NSURLResponse?, error:NSError?) in
            //ações que serão executadas quando a execução da task se completa
            //let dado = NSString(data:data!,encoding: NSUTF8StringEncoding)
            //print(dado)
            
            var dicLocal = self.retornarDado(data!)
            
            dispatch_async(dispatch_get_main_queue(), {
                
              self.lblRua.text = dicLocal["logradouro"]
              self.lblCid.text = dicLocal["localidade"]
              self.lblBai.text = dicLocal["bairro"]
              self.lblEst.text = dicLocal["uf"]
                
            })
            
        }
        
        task.resume()
        
    }
    
    
    @IBOutlet weak var txtCep: UITextField!
    
    
    
    var session: NSURLSession?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func retornarDado(data: NSData) -> [String:String] {
        var dicEndereco:[String:String] = [:]
        
        do{
            //faz a leitura dos valores do Json, NSJSONSerialization faz o Parser do Json
            
            let json = try NSJSONSerialization.JSONObjectWithData(data, options: []) as! [String:String]
            dicEndereco = json
            
        }catch let error as NSError{
            print("Falha ao carregar: \(error.description)")
        }
        return dicEndereco
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    
}

