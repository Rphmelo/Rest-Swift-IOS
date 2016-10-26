//
//  ListaTableViewController.swift
//  Top 10 - Free App - Com TableView
//
//  Created by Usuário Convidado on 29/09/16.
//  Copyright © 2016 Usuário Convidado. All rights reserved.
//

import UIKit

class ListaTableViewController: UITableViewController {

    var aplicativoArray = [Aplicativo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: configuration)
        let urlApi = "http://itunes.apple.com/br/rss/topfreeapplications/limit=10/json"
        
        
        if let url = NSURL(string: urlApi) {
            
            session.dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
                // checando o erro
                if error != nil {
                    print("The error is: \(error!)")
                    return
                } else if let jsonData = data {
                    do {
                        let parsedJSON = try NSJSONSerialization.JSONObjectWithData(jsonData, options: []) as! [String:AnyObject]
                        // print(parsedJSON)
                        
                        //******  veja o uso da palavra chave guard(protetor) em: *********
                        // https://thatthinginswift.com/guard-statement-swift/
                        //https://code.tutsplus.com/pt/tutorials/swift-2-exit-early-with-guard--cms-24326
                        
                        guard let feed = parsedJSON["feed"] as? [String:AnyObject]  else { return }
                        guard let apps = feed["entry"] as? [[String:AnyObject]] else { return }
                        
                        for app in apps{
                            let objApp = Aplicativo()
                            guard let imname = app["im:name"] as? [String:AnyObject] else { return }
                            guard let nomeApp = imname["label"] as? String else { return }
                            objApp.nome = nomeApp
                            self.aplicativoArray.append(objApp)
                            
                        }
                        
                        //usando let ao invés de guard
                        /*
                        if let feed = parsedJSON["feed"] as? [String:AnyObject]{
                            if let apps = feed["entry"] as? [[String:AnyObject]] {
                                
                                for app in apps{
                                    let objApp = Aplicativo()
                                    if let imname = app["im:name"] as? [String:AnyObject]{
                                        if let nomeApp = imname["label"] as? String{
                                            objApp.nome = nomeApp
                                            self.aplicativoArray.append(objApp)
                                       }
                                    }
                                }
                                
                            }
                        }
                        */
                        
                        
                        dispatch_async(dispatch_get_main_queue()) {
                            self.tableView.reloadData()
                        }
                        
                    } catch let error as NSError {
                        print(error.description)
                    }
                }
            }).resume()
        }


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aplicativoArray.count
    }

   override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...
        cell.textLabel?.text = aplicativoArray[indexPath.row].nome
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
