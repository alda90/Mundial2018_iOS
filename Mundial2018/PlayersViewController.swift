//
//  PlayersViewController.swift
//  Mundial2018
//
//  Created by Aldair Carrillo on 28/05/18.
//  Copyright © 2018 Aldair. All rights reserved.
//

import UIKit

class PlayersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var urlCad: String = "";
    var result1: NSString = ""
    var playersArray: NSArray = NSArray()
    
    
    @IBOutlet weak var playersTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = pais
        self.parent?.navigationController?.setNavigationBarHidden(false, animated: true)
        
        getPlayers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*//////////////////////////////////////////////////////////////////////
     // TABLE Players
     *//////////////////////////////////////////////////////////////////////
    
    func getPlayers() {
        
        urlCad = urlMundial + "jugador/pais"
        
        
        let URL: Foundation.URL = Foundation.URL(string: urlCad)!
        
        let request:NSMutableURLRequest = NSMutableURLRequest(url:URL)
        //print(request)
        
        request.httpMethod = "POST"
        
        let bodyData = "idpais=\(idpais)"
        
        request.httpBody = bodyData.data(using: String.Encoding.utf8)
        
        
        NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue.main)
        {
            (response, data, error) in
            self.result1 = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!
            
            if !(data == nil){
                do {
                    //var error = NSErrorPointer()
                    let gettingData = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    //print(gettingData)
                    if gettingData.value(forKey: "jugador") != nil {
                        self.playersArray = gettingData.value(forKey: "jugador") as! NSArray
                    
                        self.showTableView()
                    }
                } catch {
                    
                }
            }
        }
    }

    
    func showTableView() {
        playersTableView?.delegate = self
        playersTableView?.dataSource = self
        playersTableView.reloadData()
        playersTableView.isHidden = false
        playersTableView?.tableFooterView = UIView()
        playersTableView.backgroundColor = UIColor.clear
        //llenarImagen()
    }
    
    /*-----------------TABLE VIEW-----------------*/
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if playersArray.count > 0 {
            return playersArray.count
        }
        else {
            return 0
        }
    }
    

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playersCell", for: indexPath) as! CeldasGralesTableViewCell
        
        
        let cadImg = "https://mundial-backend.herokuapp.com/img/jugadores/"
        
        
        // Similar to above, first check if there is a valid section of table.
        // Then we check that for the section there is a row.
        if playersArray.count > 0 {
            
    
            //let img = "5aef86ed17436d0f304fe8a5-137.png"
            let img = ((playersArray[indexPath.row] as AnyObject).value(forKey: "img") as? String)!
         
            cell.pLblNum.text = ((playersArray[indexPath.row] as AnyObject).value(forKey: "numero") as? String)!
            cell.pLblPos.text = ((playersArray[indexPath.row] as AnyObject).value(forKey: "posicion") as? String)!
            cell.pLblPlayer.text = ((playersArray[indexPath.row] as AnyObject).value(forKey: "nombre") as? String)!
            
            
            cell.pImgPlayer.layer.cornerRadius = 27
            cell.pImgPlayer.clipsToBounds = true
            cell.pImgPlayer.layer.borderColor = UIColor.lightGray.cgColor
            cell.pImgPlayer.layer.borderWidth = 3
            
            cell.pImgPlayer.sd_setImage(with: URL(string: cadImg + img))
            
            
        }
        
        
        
        return cell
    }
    
    

}
