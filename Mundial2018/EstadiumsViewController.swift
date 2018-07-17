//
//  EstadiumsViewController.swift
//  Mundial2018
//
//  Created by Aldair Carrillo on 29/05/18.
//  Copyright © 2018 Aldair. All rights reserved.
//

import UIKit

class EstadiumsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var urlCad: String = "";
    var result1: NSString = ""
    var estadiosArray: NSArray = NSArray()
    
    @IBOutlet weak var estadiosTableView: UITableView!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getEstadios()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*//////////////////////////////////////////////////////////////////////
     // TABLE Players
     *//////////////////////////////////////////////////////////////////////
    
    func getEstadios() {
        
        urlCad = urlMundial + "estadio/"
        
        
        let URL: Foundation.URL = Foundation.URL(string: urlCad)!
        
        let request:NSMutableURLRequest = NSMutableURLRequest(url:URL)
        //print(request)
        
        request.httpMethod = "GET"
        
        //let bodyData = "idpais=\(idpais)"
        
        //request.httpBody = bodyData.data(using: String.Encoding.utf8)
        
        
        NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue.main)
        {
            (response, data, error) in
            self.result1 = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!
            
            if !(data == nil){
                do {
                    //var error = NSErrorPointer()
                    let gettingData = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    //print(gettingData)
                    if gettingData.value(forKey: "estadio") != nil {
                        self.estadiosArray = gettingData.value(forKey: "estadio") as! NSArray
                        
                        self.showTableView()
                    }
                } catch {
                    
                }
            }
        }
    }
    
    
    func showTableView() {
        estadiosTableView?.delegate = self
        estadiosTableView?.dataSource = self
        estadiosTableView.reloadData()
        estadiosTableView.isHidden = false
        estadiosTableView?.tableFooterView = UIView()
        estadiosTableView.backgroundColor = UIColor.clear
        //llenarImagen()
    }
    
    /*-----------------TABLE VIEW-----------------*/
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if estadiosArray.count > 0 {
            return estadiosArray.count
        }
        else {
            return 0
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "citiesCell", for: indexPath) as! CeldasGralesTableViewCell
        
        
        let cadImg = "https://mundial-backend.herokuapp.com/img/estadios/"
        
        
        // Similar to above, first check if there is a valid section of table.
        // Then we check that for the section there is a row.
        if estadiosArray.count > 0 {
            
            
            //let img = "5ae2a7e5f8cf74a90662f214-212.jpg"
            let img = ((estadiosArray[indexPath.row] as AnyObject).value(forKey: "img") as? String)!
            
            cell.lblEstadio.text = ((estadiosArray[indexPath.row] as AnyObject).value(forKey: "estadio") as? String)!
            cell.lblCapacidad.text = ((estadiosArray[indexPath.row] as AnyObject).value(forKey: "capacidad") as? String)!
            
            var sede = ""
            let gettingSede = ((estadiosArray[indexPath.row] as AnyObject).value(forKey: "sede") as? NSDictionary)!
            //print(gettingPlayer)
            if gettingSede.value(forKey: "_id") != nil {
                sede = gettingSede.value(forKey: "sede") as! String
            }
            
            cell.lblSede.text = sede
            
            cell.imgEstadio.sd_setImage(with: URL(string: cadImg + img))
            
            
        }
        
        
        
        return cell
    }

}
