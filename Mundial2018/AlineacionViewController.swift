//
//  AlineacionViewController.swift
//  Mundial2018
//
//  Created by Aldair Carrillo on 24/05/18.
//  Copyright © 2018 Aldair. All rights reserved.
//

import UIKit

class AlineacionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var urlCad: String = "";
    var result1: NSString = ""
    var alinArray: NSArray = NSArray()
    
    var titularesArray = NSMutableArray() //create
    var sustitutosArray = NSMutableArray()
    var countTit = 0
    var countSus = 0
   
    
    private let sections: NSArray = ["TITULARES", "SUPLENTES"]
    @IBOutlet weak var alineacionTableView: UITableView!
    
    // The magic enum to end our pain and suffering!
    // For the most part the order of our cases do not matter.
    // What is important is that our first case is set to 0, and that our last case is always `total`.
    enum TableSection: Int {
        case titular = 0, suplente, total
    }
    
    // This is the size of our header sections that we will use later on.
    let SectionHeaderHeight: CGFloat = 50
    
    // Data variable to track our sorted data.
    var data = [TableSection: [[String: String]]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = pais
        self.parent?.navigationController?.setNavigationBarHidden(false, animated: true)
        
        getAlineacion()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*//////////////////////////////////////////////////////////////////////
     // TABLE Main Matches
     *//////////////////////////////////////////////////////////////////////
    
    func getAlineacion() {
        
        urlCad = urlMundial + "alineacion/partidopais"
        
        
        let URL: Foundation.URL = Foundation.URL(string: urlCad)!
        
        let request:NSMutableURLRequest = NSMutableURLRequest(url:URL)
        //print(request)
        
        request.httpMethod = "POST"
        
        let bodyData = "idpartido=\(idpartido)&idpais=\(idpais)"
        
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
                    if gettingData.value(forKey: "alineacion") != nil {
                        self.alinArray = gettingData.value(forKey: "alineacion") as! NSArray
               
                        self.setData()
                        self.showTableView()
                        print("count")
                        print(self.titularesArray.count)
                        print(self.sustitutosArray.count)
                         print("titu")
                        print(self.titularesArray)
                         print("sus")
                        print(self.sustitutosArray)
                    }
                } catch {
                    
                }
            }
        }
    }
    
    func setData(){
        for index in 0..<alinArray.count{
            //add an element and the previous element together
            let est = ((alinArray[index] as AnyObject).value(forKey: "estatus") as? String)!
            
            if est == "TITULAR" {
                titularesArray.add(alinArray[index])
            } else  if est == "SUSTITUTO"{
                sustitutosArray.add(alinArray[index])
            }
        }
    }
    
    func showTableView() {
        alineacionTableView?.delegate = self
        alineacionTableView?.dataSource = self
        alineacionTableView.reloadData()
        alineacionTableView.isHidden = false
        alineacionTableView?.tableFooterView = UIView()
        alineacionTableView.backgroundColor = UIColor.clear
        //llenarImagen()
    }
    
    /*-----------------TABLE VIEW-----------------*/
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return titularesArray.count
        } else if section == 1 {
            return sustitutosArray.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // If we wanted to always show a section header regardless of whether or not there were rows in it,
        // then uncomment this line below:
        //return SectionHeaderHeight
        
        // First check if there is a valid section of table.
        // Then we check that for the section there is more than 1 row.
        
        return SectionHeaderHeight
    }
    
    // return the title of sections
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section] as? String
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: SectionHeaderHeight))
        view.backgroundColor = UIColor(red: 46.0/255.0, green: 100.0/255.0, blue: 254.0/255.0, alpha: 1)
        let label = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.bounds.width - 30, height: SectionHeaderHeight))
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor.black
        label.textAlignment = .center
        if let tableSection = TableSection(rawValue: section) {
            switch tableSection {
            case .titular:
                label.text = "TITULARES"
            case .suplente:
                label.text = "SUPLENTES"
            default:
                label.text = ""
            }
        }
        
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "alinCell", for: indexPath) as! CeldasGralesTableViewCell
        
 
            
            let cadImg = "https://mundial-backend.herokuapp.com/img/jugadores/"
            
            
            // Similar to above, first check if there is a valid section of table.
            // Then we check that for the section there is a row.
            if indexPath.section == 0  && titularesArray.count > 0 {
                
                var capitan = ((titularesArray[indexPath.row] as AnyObject).value(forKey: "capitan") as? String)!
                var jugador = ""
                var img = "5aef86ed17436d0f304fe8a5-137.png"
                var numero = ""
                var pos = ""
                let gettingPlayer = ((titularesArray[indexPath.row] as AnyObject).value(forKey: "jugador") as? NSDictionary)!
                //print(gettingPlayer)
                if gettingPlayer.value(forKey: "_id") != nil {
                    jugador = gettingPlayer.value(forKey: "nombre") as! String
                    img = gettingPlayer.value(forKey: "img") as! String
                    numero = gettingPlayer.value(forKey: "numero") as! String
                    pos = gettingPlayer.value(forKey: "posicion") as! String
                }
           
                    cell.lblNum.text = numero
                    cell.lblPos.text = pos
                    
                    
                    if(capitan == "S"){
                        cell.lblJugador.text = jugador + " (c)"
                    } else {
                        cell.lblJugador.text = jugador
                    }
                    
                    cell.imgPlayer.layer.cornerRadius = 27
                    cell.imgPlayer.clipsToBounds = true
                    cell.imgPlayer.layer.borderColor = UIColor.lightGray.cgColor
                    cell.imgPlayer.layer.borderWidth = 3
                    
                    cell.imgPlayer.sd_setImage(with: URL(string: cadImg + img))
                
                if(countTit == 10) {
                    print("playerrss" + jugador)
                }
                
                    countTit += 1
                
            } else if indexPath.section == 1  && sustitutosArray.count > 0 {
                var capitan = ((sustitutosArray[indexPath.row] as AnyObject).value(forKey: "capitan") as? String)!
                var jugador = ""
                var img = "5aef86ed17436d0f304fe8a5-137.png"
                var numero = ""
                var pos = ""
                let gettingPlayer = ((sustitutosArray[indexPath.row] as AnyObject).value(forKey: "jugador") as? NSDictionary)!
                //print(gettingPlayer)
                if gettingPlayer.value(forKey: "_id") != nil {
                    jugador = gettingPlayer.value(forKey: "nombre") as! String
                    img = gettingPlayer.value(forKey: "img") as! String
                    numero = gettingPlayer.value(forKey: "numero") as! String
                    pos = gettingPlayer.value(forKey: "posicion") as! String
                }
                
                cell.lblNum.text = numero
                cell.lblPos.text = pos
                
                
                if(capitan == "S"){
                    cell.lblJugador.text = jugador + " (c)"
                } else {
                    cell.lblJugador.text = jugador
                }
                
                cell.imgPlayer.layer.cornerRadius = 27
                cell.imgPlayer.clipsToBounds = true
                cell.imgPlayer.layer.borderColor = UIColor.lightGray.cgColor
                cell.imgPlayer.layer.borderWidth = 3
                
                cell.imgPlayer.sd_setImage(with: URL(string: cadImg + img))
                
                countSus += 1
               
                
            }
            
        
        
        return cell
    }

}
