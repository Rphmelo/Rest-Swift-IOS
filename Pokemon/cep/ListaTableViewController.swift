//
//  ListaTableViewController.swift
//  _Pokemon Json
//
//  Created by Raphael de Melo Silva on 19/09/16.
//  Copyright © 2016 Raphael de Melo Silva. All rights reserved.
//

import UIKit


class ListaTableViewController: UITableViewController {
    
    var pokemonArray = [Pokemon]()
    var subStr = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: configuration)
        let urlApi = "http://api.pokemontcg.io/v1/cards?attackDamage=gt3&types=water"
        
        
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
                        
                        guard let results = parsedJSON["cards"] as? [[String:AnyObject]] else { return }
                        //print(results.count)
                        //print("******\(results)")
                        
                        for result in results {
                            let pok = Pokemon()
                            // print(result["name"])
                            pok.id = result["id"] as! String
                            pok.nome = result["name"] as! String
                            pok.hp = result["hp"] as! String
                            pok.raridade = result["rarity"] as! String
                            // pok.tipo[0] = result["types"] as! [String]
                            pok.artista = result["artist"] as! String
                            pok.imagemUrl = result["imageUrl"] as! String
                            self.pokemonArray.append(pok)
                        }
                        
                        
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
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemonArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...
        let pokItem = pokemonArray[indexPath.row]
        cell.textLabel?.text = "Id:" + pokItem.id + " - " + pokItem.nome
        cell.detailTextLabel?.text = "Hp:" + pokItem.hp + " Rarity: " + pokItem.raridade
        
        
        
         //**********verificar porque na FIAP não abre********
         //
        /*
         subStr = pokItem.imagemUrl.substringWithRange(Range<String.Index>(start: pokItem.imagemUrl.startIndex.advancedBy(5), end:pokItem.imagemUrl.endIndex ))
         let caminho = "http" +  subStr
         print(caminho)
         cell.imageView?.image = UIImage(named: caminho)
        */

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
