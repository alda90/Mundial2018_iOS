//
//  MatchViewController.swift
//  Mundial2018
//
//  Created by Aldair Carrillo on 23/05/18.
//  Copyright © 2018 Aldair. All rights reserved.
//

import UIKit

class MatchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var urlCad: String = "";
    var result1: NSString = ""
    var incsArray: NSArray = NSArray()
    
    @IBOutlet weak var incidenciasTableView: UITableView!
    
    
    @IBOutlet weak var imgLocal: UIImageView!
    @IBOutlet weak var imgVisita: UIImageView!
    
    @IBOutlet weak var lblLocal: UILabel!
    @IBOutlet weak var lblVisita: UILabel!
    
    @IBOutlet weak var lblInfo: UILabel!
    
    @IBOutlet weak var lblGLocal: UILabel!
    @IBOutlet weak var lblGLocalp: UILabel!
    
    @IBOutlet weak var lblGVisita: UILabel!
    @IBOutlet weak var lblGVisitap: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblLocal.text = plocal
        lblVisita.text = pvisitante
        lblGLocal.text = pglocal
        lblGVisita.text = pgvisitante
        lblGLocalp.text = pglocalp
        lblGVisitap.text = pgvisitantep
        
        if(pestatus == "PROGRAMADO") {
            lblInfo.text = phora
        }else {
            lblInfo.text = pestatus
        }
        
        if(pconclusion != "PENALES") {
            lblGLocalp.isHidden = true
            lblGVisitap.isHidden = true
        }
        
        let cadImg = "https://mundial-backend.herokuapp.com/img/banderas/"
        
        imgLocal.sd_setImage(with: URL(string: cadImg + pbanderal))
        imgVisita.sd_setImage(with: URL(string: cadImg + pbanderav))

        imgLocal.layer.cornerRadius = 50
        imgLocal.clipsToBounds = true
        imgLocal.layer.borderColor = UIColor.lightGray.cgColor
        imgLocal.layer.borderWidth = 3
        
        imgVisita.layer.cornerRadius = 50
        imgVisita.clipsToBounds = true
        imgVisita.layer.borderColor = UIColor.lightGray.cgColor
        imgVisita.layer.borderWidth = 3
        //cargarBarController()
        
        self.navigationItem.title = npartido
        self.parent?.navigationController?.setNavigationBarHidden(false, animated: true)
        
        let tapl = UITapGestureRecognizer(target: self, action: #selector(MatchViewController.tappedLocal))
        imgLocal.addGestureRecognizer(tapl)
        imgLocal.isUserInteractionEnabled = true
        
        let tapv = UITapGestureRecognizer(target: self, action: #selector(MatchViewController.tappedVisita))
        imgVisita.addGestureRecognizer(tapv)
        imgVisita.isUserInteractionEnabled = true
        
        getIncsMatches()
    }
    
    @objc func tappedLocal()
    {
        print("Tapped on Image")
        
        pais = plocal
        idpais = pidlocal
        
        performSegue(withIdentifier: "lalineacion", sender: self)
    }
    
    @objc func tappedVisita()
    {
        print("Tapped on Image")
        
        pais = pvisitante
        idpais = pidvisitante
        
        performSegue(withIdentifier: "lalineacion", sender: self)
    }

 func cargarBarController() {
        
        let nav = self.navigationController!.navigationBar
        nav.tintColor = UIColor.white
        //nav.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.hidesBackButton = true
        
        /* let menuButton: UIImage = UIImage(named: "menu")!
         let btnMenu: UIBarButtonItem = UIBarButtonItem(image: menuButton, style: UIBarButtonItemStyle.done, target: self, action: #selector(ViewController.showMenu(_:)))
         btnMenu.tintColor = UIColor.white
         
     
         self.navigationItem.setRightBarButtonItems([btnMenu], animated: true)*/
    }
    
    /*//////////////////////////////////////////////////////////////////////
     // TABLE Main Matches
     *//////////////////////////////////////////////////////////////////////
    
    func getIncsMatches() {
        
        urlCad = urlMundial + "incidencia/partido"
        
        
        let URL: Foundation.URL = Foundation.URL(string: urlCad)!
        
        let request:NSMutableURLRequest = NSMutableURLRequest(url:URL)
        //print(request)
        
        request.httpMethod = "POST"
        
        let bodyData = "partido=\(idpartido)"
        
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
                    if gettingData.value(forKey: "incidencia") != nil {
                        self.incsArray = gettingData.value(forKey: "incidencia") as! NSArray
                        self.showTableView()
                        
                    }
                } catch {
                    
                }
            }
        }
    }
    
    func showTableView() {
        incidenciasTableView?.delegate = self
        incidenciasTableView?.dataSource = self
        incidenciasTableView.reloadData()
        incidenciasTableView.isHidden = false
        incidenciasTableView?.tableFooterView = UIView()
        incidenciasTableView.backgroundColor = UIColor.clear
        //llenarImagen()
    }
    
    /*-----------------TABLE VIEW-----------------*/
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if incsArray.count > 0 {
            return incsArray.count
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "incCell", for: indexPath) as! CeldasGralesTableViewCell
        
     
        
        
        if incsArray.count > 0 {
            
            cell.imgIn.isHidden = true
            cell.imgOut.isHidden = true
            cell.lblSubs.isHidden = true
            
            cell.lblMin.text = ((incsArray[indexPath.row] as AnyObject).value(forKey: "minuto") as? String)!
        
            var njugador = ""
            let gettingPlayer = ((incsArray[indexPath.row] as AnyObject).value(forKey: "jugador") as? NSDictionary)!
            print(gettingPlayer)
            if gettingPlayer.value(forKey: "_id") != nil {
                njugador = gettingPlayer.value(forKey: "nombre") as! String
            
            }
            
            cell.lblPlayer.text = njugador
            
            
            var incidencia = ((incsArray[indexPath.row] as AnyObject).value(forKey: "incidencia") as? String)!
            
            if(incidencia == "Inicio"){
                cell.lblPlayer.text = "Inicio"
                cell.imgInc.image = UIImage(named: "inicio")
            } else if (incidencia == "Amonestacion J"  || incidencia == "Amonestacion T"){
                cell.imgInc.image = UIImage(named: "yellow")
            } else if (incidencia == "Expulsion J"  || incidencia == "Expulsion T"){
                cell.imgInc.image = UIImage(named: "red")
            } else if (incidencia == "Gol"){
                cell.imgInc.image = UIImage(named: "soccer")
            } else if (incidencia == "Penal"){
                cell.imgInc.image = UIImage(named: "penal")
            } else if (incidencia == "Autogol"){
                cell.imgInc.image = UIImage(named: "soccer")
                cell.lblPlayer.text = njugador + " (a)"
            } else if (incidencia == "Sustitucion"){
                cell.imgInc.image = UIImage(named: "inout")
                cell.imgIn.isHidden = false
                cell.imgOut.isHidden = false
                cell.lblSubs.isHidden = false
                var nsustituto = ""
                let gettingSust = ((incsArray[indexPath.row] as AnyObject).value(forKey: "sustituto") as? NSDictionary)!
                if gettingSust.value(forKey: "_id") != nil {
                    nsustituto = gettingSust.value(forKey: "nombre") as! String
                }
                
                cell.lblSubs.text = njugador
                cell.lblPlayer.text = nsustituto
            } else {
                cell.lblPlayer.text = "Final"
                cell.imgInc.image = UIImage(named: "inicio")
            }
            
            if(incidencia == "Expulsion T" || incidencia == "Amonestacion T") {
                var ntecnico = ""
                let gettingTec = ((incsArray[indexPath.row] as AnyObject).value(forKey: "tecnico") as? NSDictionary)!
                if gettingTec.value(forKey: "_id") != nil {
                    ntecnico = gettingTec.value(forKey: "nombre") as! String
                }
                
                cell.lblPlayer.text = ntecnico
            }
            
          
            
        }
        return cell
    }
    
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }



}
