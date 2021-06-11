    //
//  MatchViewController.swift
//  Mundial2018
//
//  Created by Aldair Carrillo on 23/05/18.
//  Copyright © 2018 Aldair. All rights reserved.
//

import UIKit

class MatchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var incidenciasTableView: UITableView!
    @IBOutlet weak var viewBackScore: UIView!
    @IBOutlet weak var imgLocal: UIImageView!
    @IBOutlet weak var imgVisita: UIImageView!
    
    @IBOutlet weak var lblLocal: UILabel!
    @IBOutlet weak var lblVisita: UILabel!
    
    @IBOutlet weak var lblInfo: UILabel!
    
    @IBOutlet weak var lblGLocal: UILabel!
    @IBOutlet weak var lblGLocalp: UILabel!
    
    @IBOutlet weak var lblGVisita: UILabel!
    @IBOutlet weak var lblGVisitap: UILabel!
    
    private var team1: Team!
    private var team2: Team!
    private var goals: [Goal] = [Goal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        team1 = varMatch?.team1
        team2 = varMatch?.team2
        
        goals.append(contentsOf: varMatch?.goals1 ?? [])
        goals.append(contentsOf: varMatch?.goals2 ?? [])
        
        let v1Et = varMatch?.score1et ?? -1
        let v2Et = varMatch?.score2et ?? -1
        let v1P = varMatch?.score1p ?? -1
        let v2P = varMatch?.score2p ?? -1
        
        let gLocal = "\(varMatch?.score1 ?? 0)"
        let gVisita = "\(varMatch?.score2 ?? 0)"
        let gLocalEt = "\(v1Et)"
        let gVisitaEt = "\(v2Et)"
        let gLocalp = "(\(v1P))"
        let gVisitap = "(\(v2P))"

        lblLocal.text = team1.name
        lblVisita.text = team2.name
        lblGLocal.text = gLocal
        lblGVisita.text = gVisita
        
        if v1Et != -1 {
            lblGLocal.text = gLocalEt
            lblGLocal.text = gVisitaEt
            if v1P != -1 {
                lblGLocalp.text = gLocalp
                lblGVisitap.text =  gVisitap
            }
            
        }
        
        lblInfo.text = "FINISHED"
        
        if(v1P == -1) {
            lblGLocalp.isHidden = true
            lblGVisitap.isHidden = true
        }
        
        
        
        
        imgLocal.image = UIImage(named: team1.code)
        imgVisita.image = UIImage(named: team2.code)

        imgLocal.layer.cornerRadius = 50
        imgLocal.clipsToBounds = true
        imgLocal.layer.borderColor = UIColor.lightGray.cgColor
        imgLocal.layer.borderWidth = 3
        
        imgVisita.layer.cornerRadius = 50
        imgVisita.clipsToBounds = true
        imgVisita.layer.borderColor = UIColor.lightGray.cgColor
        imgVisita.layer.borderWidth = 3

        
        viewBackScore.layer.shadowColor = UIColor.black.cgColor
        viewBackScore.layer.shadowOpacity = 1
        viewBackScore.layer.shadowOffset = .zero
        viewBackScore.layer.shadowRadius = 3
        
        self.navigationItem.title = varMatch?.group ?? ""
        self.parent?.navigationController?.setNavigationBarHidden(false, animated: true)
        
        let tapl = UITapGestureRecognizer(target: self, action: #selector(MatchViewController.tappedLocal))
        imgLocal.addGestureRecognizer(tapl)
        imgLocal.isUserInteractionEnabled = true
        
        let tapv = UITapGestureRecognizer(target: self, action: #selector(MatchViewController.tappedVisita))
        imgVisita.addGestureRecognizer(tapv)
        imgVisita.isUserInteractionEnabled = true
        
        self.showTableView()
    }
   
    @objc func tappedLocal()
    {
        print("Tapped on Image")
        
//
//        performSegue(withIdentifier: "lalineacion", sender: self)
    }
    
    @objc func tappedVisita()
    {
        print("Tapped on Image")
        
//
//        performSegue(withIdentifier: "lalineacion", sender: self)
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
        return goals.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "incCell", for: indexPath) as! CeldasGralesTableViewCell
        
        if goals.count > 0 {
            
            cell.imgIn.isHidden = true
            cell.imgOut.isHidden = true
            cell.lblSubs.isHidden = true
            
            cell.lblMin.text = "\(goals[indexPath.row].minute)"
            cell.lblPlayer.text = goals[indexPath.row].name
            
            let owngoal = goals[indexPath.row].owngoal ?? false
            
            if owngoal {
                cell.lblPlayer.text = "\(goals[indexPath.row].name) (a)"
            }
            cell.imgInc.image = UIImage(named: "soccer")
            
//            var incidencia = ((incsArray[indexPath.row] as AnyObject).value(forKey: "incidencia") as? String)!
//
//            if(incidencia == "Inicio"){
//                cell.lblPlayer.text = "Inicio"
//                cell.imgInc.image = UIImage(named: "inicio")
//            } else if (incidencia == "Amonestacion J"  || incidencia == "Amonestacion T"){
//                cell.imgInc.image = UIImage(named: "yellow")
//            } else if (incidencia == "Expulsion J"  || incidencia == "Expulsion T"){
//                cell.imgInc.image = UIImage(named: "red")
//            } else if (incidencia == "Gol"){
//                cell.imgInc.image = UIImage(named: "soccer")
//            } else if (incidencia == "Penal"){
//                cell.imgInc.image = UIImage(named: "penal")
//            } else if (incidencia == "Autogol"){
//                cell.imgInc.image = UIImage(named: "soccer")
//                cell.lblPlayer.text = njugador + " (a)"
//            } else if (incidencia == "Sustitucion"){
//                cell.imgInc.image = UIImage(named: "inout")
//                cell.imgIn.isHidden = false
//                cell.imgOut.isHidden = false
//                cell.lblSubs.isHidden = false
//                var nsustituto = ""
//                let gettingSust = ((incsArray[indexPath.row] as AnyObject).value(forKey: "sustituto") as? NSDictionary)!
//                if gettingSust.value(forKey: "_id") != nil {
//                    nsustituto = gettingSust.value(forKey: "nombre") as! String
//                }
//
//                cell.lblSubs.text = njugador
//                cell.lblPlayer.text = nsustituto
//            } else {
//                cell.lblPlayer.text = "Final"
//                cell.imgInc.image = UIImage(named: "inicio")
//            }
            
//            if(incidencia == "Expulsion T" || incidencia == "Amonestacion T") {
//                var ntecnico = ""
//                let gettingTec = ((incsArray[indexPath.row] as AnyObject).value(forKey: "tecnico") as? NSDictionary)!
//                if gettingTec.value(forKey: "_id") != nil {
//                    ntecnico = gettingTec.value(forKey: "nombre") as! String
//                }
//
//                cell.lblPlayer.text = ntecnico
//            }
            
          
            
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
        self.navigationController!.navigationBar.barTintColor = UIColor.darkGray
        self.navigationController!.navigationBar.tintColor = UIColor.white
        self.navigationController!.navigationBar.isTranslucent = false
    }



}
