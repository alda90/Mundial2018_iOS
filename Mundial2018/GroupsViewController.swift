//
//  GroupsViewController.swift
//  Mundial2018
//
//  Created by Aldair Carrillo on 27/05/18.
//  Copyright © 2018 Aldair. All rights reserved.
//

import UIKit

class GroupsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var groupsTableView: UITableView!
    
    var urlCad: String = "";
    var result1: NSString = ""
    var paisesArray: NSArray = NSArray()
    
    var grupoAArray = NSMutableArray() //create
    var grupoBArray = NSMutableArray()
    var grupoCArray = NSMutableArray()
    var grupoDArray = NSMutableArray()
    var grupoEArray = NSMutableArray()
    var grupoFArray = NSMutableArray()
    var grupoGArray = NSMutableArray()
    var grupoHArray = NSMutableArray()
    
    private let sections: NSArray = ["GRUPO A", "GRUPO B", "GRUPO C", "GRUPO D", "GRUPO E", "GRUPO F", "GRUPO G", "GRUPO H"]
    
    enum TableSection: Int {
        case grupoa = 0, grupob, grupoc, grupod, grupoe, grupof, grupog, grupoh, total
    }
    
    // This is the size of our header sections that we will use later on.
    let SectionHeaderHeight: CGFloat = 50
    
    // Data variable to track our sorted data.
    var data = [TableSection: [[String: String]]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getGroups()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*//////////////////////////////////////////////////////////////////////
     // TABLE Main Matches
     *//////////////////////////////////////////////////////////////////////
    
    func getGroups() {
        
        urlCad = urlMundial + "estadistica/grupos"
        
        
        let URL: Foundation.URL = Foundation.URL(string: urlCad)!
        
        let request:NSMutableURLRequest = NSMutableURLRequest(url:URL)
        //print(request)
        
        request.httpMethod = "GET"
        
        //let bodyData = "partido=\(idpartido)"
        
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
                    if gettingData.value(forKey: "estadistica") != nil {
                        self.paisesArray = gettingData.value(forKey: "estadistica") as! NSArray
                        self.setData()
                        self.showTableView()
                        
                    }
                } catch {
                    
                }
            }
        }
    }
    
    func setData(){
        for index in 0..<paisesArray.count{
            //add an element and the previous element together
            var grupo = ""
            let gettingGrupo = ((paisesArray[index] as AnyObject).value(forKey: "grupo") as? NSDictionary)!
            if gettingGrupo.value(forKey: "_id") != nil {
                grupo = gettingGrupo.value(forKey: "grupo") as! String
            }
            
            if grupo == "Grupo A" {
                grupoAArray.add(paisesArray[index])
            } else  if grupo == "Grupo B"{
                grupoBArray.add(paisesArray[index])
            } else  if grupo == "Grupo C"{
                grupoCArray.add(paisesArray[index])
            } else  if grupo == "Grupo D"{
                grupoDArray.add(paisesArray[index])
            } else  if grupo == "Grupo E"{
                grupoEArray.add(paisesArray[index])
            } else  if grupo == "Grupo F"{
                grupoFArray.add(paisesArray[index])
            } else  if grupo == "Grupo G"{
                grupoGArray.add(paisesArray[index])
            } else  if grupo == "Grupo H"{
                grupoHArray.add(paisesArray[index])
            }
        }
    }
    
    func showTableView() {
        groupsTableView?.delegate = self
        groupsTableView?.dataSource = self
        groupsTableView.reloadData()
        groupsTableView.isHidden = false
        groupsTableView?.tableFooterView = UIView()
        groupsTableView.backgroundColor = UIColor.clear
        //llenarImagen()
    }
    
    /*-----------------TABLE VIEW-----------------*/
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return grupoAArray.count
        } else if section == 1 {
            return grupoBArray.count
        } else if section == 2 {
            return grupoCArray.count
        } else if section == 3 {
            return grupoDArray.count
        } else if section == 4 {
            return grupoEArray.count
        } else if section == 5 {
            return grupoFArray.count
        } else if section == 6 {
            return grupoGArray.count
        } else if section == 7 {
            return grupoHArray.count
        }else {
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
            case .grupoa:
                label.text = "Grupo A"
            case .grupob:
                label.text = "Grupo B"
            case .grupoc:
                label.text = "Grupo C"
            case .grupod:
                label.text = "Grupo D"
            case .grupoe:
                label.text = "Grupo E"
            case .grupof:
                label.text = "Grupo F"
            case .grupog:
                label.text = "Grupo G"
            case .grupoh:
                label.text = "Grupo H"
            default:
                label.text = ""
            }
        }
        
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as! CeldasGralesTableViewCell
        
        let cadImg = "https://mundial-backend.herokuapp.com/img/banderas/"
        cell.imgPais.layer.cornerRadius = 30
        cell.imgPais.clipsToBounds = true
        cell.imgPais.layer.borderColor = UIColor.lightGray.cgColor
        cell.imgPais.layer.borderWidth = 1
        
        if indexPath.section == 0  && grupoAArray.count > 0 {
            
           
            
            let partidos = ((grupoAArray[indexPath.row] as AnyObject).value(forKey: "partidos") as? String)!
            let puntos = ((grupoAArray[indexPath.row] as AnyObject).value(forKey: "puntos") as? String)!
            let empatados = ((grupoAArray[indexPath.row] as AnyObject).value(forKey: "empatados") as? String)!
            let ganados = ((grupoAArray[indexPath.row] as AnyObject).value(forKey: "ganados") as? String)!
            let perdidos = ((grupoAArray[indexPath.row] as AnyObject).value(forKey: "perdidos") as? String)!
            let diferencia = ((grupoAArray[indexPath.row] as AnyObject).value(forKey: "diferencia") as? String)!
        
            
            cell.lblP.text = partidos
            cell.lblPartidos.text = ganados + "-" + empatados + "-" + perdidos
            cell.lblDif.text = diferencia
            cell.lblPuntos.text = puntos
            
            var bandera = ""
            var pais = ""
            let gettingPais = ((grupoAArray[indexPath.row] as AnyObject).value(forKey: "pais") as? NSDictionary)!
            print(gettingPais)
            if gettingPais.value(forKey: "_id") != nil {
                bandera = gettingPais.value(forKey: "bandera") as! String
                pais = gettingPais.value(forKey: "pais") as! String
            }
            
            
            cell.imgPais.sd_setImage(with: URL(string: cadImg + bandera))
            cell.lblPais.text = pais
            
            
            
            
        } else if indexPath.section == 1  && grupoBArray.count > 0 {
            

            let partidos = ((grupoBArray[indexPath.row] as AnyObject).value(forKey: "partidos") as? String)!
            let puntos = ((grupoBArray[indexPath.row] as AnyObject).value(forKey: "puntos") as? String)!
            let empatados = ((grupoBArray[indexPath.row] as AnyObject).value(forKey: "empatados") as? String)!
            let ganados = ((grupoBArray[indexPath.row] as AnyObject).value(forKey: "ganados") as? String)!
            let perdidos = ((grupoBArray[indexPath.row] as AnyObject).value(forKey: "perdidos") as? String)!
            let diferencia = ((grupoBArray[indexPath.row] as AnyObject).value(forKey: "diferencia") as? String)!
            
            
            cell.lblP.text = partidos
            cell.lblPartidos.text = ganados + "-" + empatados + "-" + perdidos
            cell.lblDif.text = diferencia
            cell.lblPuntos.text = puntos
            
            var bandera = ""
            var pais = ""
            let gettingPais = ((grupoBArray[indexPath.row] as AnyObject).value(forKey: "pais") as? NSDictionary)!
            print(gettingPais)
            if gettingPais.value(forKey: "_id") != nil {
                bandera = gettingPais.value(forKey: "bandera") as! String
                pais = gettingPais.value(forKey: "pais") as! String
            }
            
            
            cell.imgPais.sd_setImage(with: URL(string: cadImg + bandera))
            cell.lblPais.text = pais
            
            
            
            
        } else if indexPath.section == 2  && grupoCArray.count > 0 {
            
            
            let partidos = ((grupoCArray[indexPath.row] as AnyObject).value(forKey: "partidos") as? String)!
            let puntos = ((grupoCArray[indexPath.row] as AnyObject).value(forKey: "puntos") as? String)!
            let empatados = ((grupoCArray[indexPath.row] as AnyObject).value(forKey: "empatados") as? String)!
            let ganados = ((grupoCArray[indexPath.row] as AnyObject).value(forKey: "ganados") as? String)!
            let perdidos = ((grupoCArray[indexPath.row] as AnyObject).value(forKey: "perdidos") as? String)!
            let diferencia = ((grupoCArray[indexPath.row] as AnyObject).value(forKey: "diferencia") as? String)!
            
            
            cell.lblP.text = partidos
            cell.lblPartidos.text = ganados + "-" + empatados + "-" + perdidos
            cell.lblDif.text = diferencia
            cell.lblPuntos.text = puntos
            
            var bandera = ""
            var pais = ""
            let gettingPais = ((grupoCArray[indexPath.row] as AnyObject).value(forKey: "pais") as? NSDictionary)!
            print(gettingPais)
            if gettingPais.value(forKey: "_id") != nil {
                bandera = gettingPais.value(forKey: "bandera") as! String
                pais = gettingPais.value(forKey: "pais") as! String
            }
            
            
            cell.imgPais.sd_setImage(with: URL(string: cadImg + bandera))
            cell.lblPais.text = pais
            
            
            
            
        } else if indexPath.section == 3  && grupoDArray.count > 0 {
            
            
            let partidos = ((grupoDArray[indexPath.row] as AnyObject).value(forKey: "partidos") as? String)!
            let puntos = ((grupoDArray[indexPath.row] as AnyObject).value(forKey: "puntos") as? String)!
            let empatados = ((grupoDArray[indexPath.row] as AnyObject).value(forKey: "empatados") as? String)!
            let ganados = ((grupoDArray[indexPath.row] as AnyObject).value(forKey: "ganados") as? String)!
            let perdidos = ((grupoDArray[indexPath.row] as AnyObject).value(forKey: "perdidos") as? String)!
            let diferencia = ((grupoDArray[indexPath.row] as AnyObject).value(forKey: "diferencia") as? String)!
            
            
            cell.lblP.text = partidos
            cell.lblPartidos.text = ganados + "-" + empatados + "-" + perdidos
            cell.lblDif.text = diferencia
            cell.lblPuntos.text = puntos
            
            var bandera = ""
            var pais = ""
            let gettingPais = ((grupoDArray[indexPath.row] as AnyObject).value(forKey: "pais") as? NSDictionary)!
            print(gettingPais)
            if gettingPais.value(forKey: "_id") != nil {
                bandera = gettingPais.value(forKey: "bandera") as! String
                pais = gettingPais.value(forKey: "pais") as! String
            }
            
            
            cell.imgPais.sd_setImage(with: URL(string: cadImg + bandera))
            cell.lblPais.text = pais
            
            
            
            
        } else if indexPath.section == 4  && grupoEArray.count > 0 {
            
            
            let partidos = ((grupoEArray[indexPath.row] as AnyObject).value(forKey: "partidos") as? String)!
            let puntos = ((grupoEArray[indexPath.row] as AnyObject).value(forKey: "puntos") as? String)!
            let empatados = ((grupoEArray[indexPath.row] as AnyObject).value(forKey: "empatados") as? String)!
            let ganados = ((grupoEArray[indexPath.row] as AnyObject).value(forKey: "ganados") as? String)!
            let perdidos = ((grupoEArray[indexPath.row] as AnyObject).value(forKey: "perdidos") as? String)!
            let diferencia = ((grupoEArray[indexPath.row] as AnyObject).value(forKey: "diferencia") as? String)!
            
            
            cell.lblP.text = partidos
            cell.lblPartidos.text = ganados + "-" + empatados + "-" + perdidos
            cell.lblDif.text = diferencia
            cell.lblPuntos.text = puntos
            
            var bandera = ""
            var pais = ""
            let gettingPais = ((grupoEArray[indexPath.row] as AnyObject).value(forKey: "pais") as? NSDictionary)!
            print(gettingPais)
            if gettingPais.value(forKey: "_id") != nil {
                bandera = gettingPais.value(forKey: "bandera") as! String
                pais = gettingPais.value(forKey: "pais") as! String
            }
            
            
            cell.imgPais.sd_setImage(with: URL(string: cadImg + bandera))
            cell.lblPais.text = pais
            
            
        } else if indexPath.section == 5  && grupoFArray.count > 0 {
            
            
            let partidos = ((grupoFArray[indexPath.row] as AnyObject).value(forKey: "partidos") as? String)!
            let puntos = ((grupoFArray[indexPath.row] as AnyObject).value(forKey: "puntos") as? String)!
            let empatados = ((grupoFArray[indexPath.row] as AnyObject).value(forKey: "empatados") as? String)!
            let ganados = ((grupoFArray[indexPath.row] as AnyObject).value(forKey: "ganados") as? String)!
            let perdidos = ((grupoFArray[indexPath.row] as AnyObject).value(forKey: "perdidos") as? String)!
            let diferencia = ((grupoFArray[indexPath.row] as AnyObject).value(forKey: "diferencia") as? String)!
            
            
            cell.lblP.text = partidos
            cell.lblPartidos.text = ganados + "-" + empatados + "-" + perdidos
            cell.lblDif.text = diferencia
            cell.lblPuntos.text = puntos
            
            var bandera = ""
            var pais = ""
            let gettingPais = ((grupoFArray[indexPath.row] as AnyObject).value(forKey: "pais") as? NSDictionary)!
            print(gettingPais)
            if gettingPais.value(forKey: "_id") != nil {
                bandera = gettingPais.value(forKey: "bandera") as! String
                pais = gettingPais.value(forKey: "pais") as! String
            }
            
            
            cell.imgPais.sd_setImage(with: URL(string: cadImg + bandera))
            cell.lblPais.text = pais
            
            
            
            
        } else if indexPath.section == 6  && grupoGArray.count > 0 {
            
            
            let partidos = ((grupoGArray[indexPath.row] as AnyObject).value(forKey: "partidos") as? String)!
            let puntos = ((grupoGArray[indexPath.row] as AnyObject).value(forKey: "puntos") as? String)!
            let empatados = ((grupoGArray[indexPath.row] as AnyObject).value(forKey: "empatados") as? String)!
            let ganados = ((grupoGArray[indexPath.row] as AnyObject).value(forKey: "ganados") as? String)!
            let perdidos = ((grupoGArray[indexPath.row] as AnyObject).value(forKey: "perdidos") as? String)!
            let diferencia = ((grupoGArray[indexPath.row] as AnyObject).value(forKey: "diferencia") as? String)!
            
            
            cell.lblP.text = partidos
            cell.lblPartidos.text = ganados + "-" + empatados + "-" + perdidos
            cell.lblDif.text = diferencia
            cell.lblPuntos.text = puntos
            
            var bandera = ""
            var pais = ""
            let gettingPais = ((grupoGArray[indexPath.row] as AnyObject).value(forKey: "pais") as? NSDictionary)!
            print(gettingPais)
            if gettingPais.value(forKey: "_id") != nil {
                bandera = gettingPais.value(forKey: "bandera") as! String
                pais = gettingPais.value(forKey: "pais") as! String
            }
            
            
            cell.imgPais.sd_setImage(with: URL(string: cadImg + bandera))
            cell.lblPais.text = pais
            
            
            
            
        }  else if indexPath.section == 7  && grupoHArray.count > 0 {
            
            
            let partidos = ((grupoHArray[indexPath.row] as AnyObject).value(forKey: "partidos") as? String)!
            let puntos = ((grupoHArray[indexPath.row] as AnyObject).value(forKey: "puntos") as? String)!
            let empatados = ((grupoHArray[indexPath.row] as AnyObject).value(forKey: "empatados") as? String)!
            let ganados = ((grupoHArray[indexPath.row] as AnyObject).value(forKey: "ganados") as? String)!
            let perdidos = ((grupoHArray[indexPath.row] as AnyObject).value(forKey: "perdidos") as? String)!
            let diferencia = ((grupoHArray[indexPath.row] as AnyObject).value(forKey: "diferencia") as? String)!
            
            
            cell.lblP.text = partidos
            cell.lblPartidos.text = ganados + "-" + empatados + "-" + perdidos
            cell.lblDif.text = diferencia
            cell.lblPuntos.text = puntos
            
            var bandera = ""
            var pais = ""
            let gettingPais = ((grupoHArray[indexPath.row] as AnyObject).value(forKey: "pais") as? NSDictionary)!
            print(gettingPais)
            if gettingPais.value(forKey: "_id") != nil {
                bandera = gettingPais.value(forKey: "bandera") as! String
                pais = gettingPais.value(forKey: "pais") as! String
            }
            
            
            cell.imgPais.sd_setImage(with: URL(string: cadImg + bandera))
            cell.lblPais.text = pais
            
            
            
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            let gettingPais = ((grupoAArray[indexPath.row] as AnyObject).value(forKey: "pais") as? NSDictionary)!
            //print(gettingData)
            if gettingPais.value(forKey: "pais") != nil {
                pais = gettingPais.value(forKey: "pais") as! String
                idpais = gettingPais.value(forKey: "_id") as! String
            }
            
        } else if indexPath.section == 1 {
            let gettingPais = ((grupoBArray[indexPath.row] as AnyObject).value(forKey: "pais") as? NSDictionary)!
            //print(gettingData)
            if gettingPais.value(forKey: "pais") != nil {
                pais = gettingPais.value(forKey: "pais") as! String
                idpais = gettingPais.value(forKey: "_id") as! String
            }
            
        } else if indexPath.section == 2 {
            let gettingPais = ((grupoCArray[indexPath.row] as AnyObject).value(forKey: "pais") as? NSDictionary)!
            //print(gettingData)
            if gettingPais.value(forKey: "pais") != nil {
                pais = gettingPais.value(forKey: "pais") as! String
                idpais = gettingPais.value(forKey: "_id") as! String
            }
            
        } else if indexPath.section == 3 {
            let gettingPais = ((grupoDArray[indexPath.row] as AnyObject).value(forKey: "pais") as? NSDictionary)!
            //print(gettingData)
            if gettingPais.value(forKey: "pais") != nil {
                pais = gettingPais.value(forKey: "pais") as! String
                idpais = gettingPais.value(forKey: "_id") as! String
            }
            
        } else if indexPath.section == 4 {
            let gettingPais = ((grupoEArray[indexPath.row] as AnyObject).value(forKey: "pais") as? NSDictionary)!
            //print(gettingData)
            if gettingPais.value(forKey: "pais") != nil {
                pais = gettingPais.value(forKey: "pais") as! String
                idpais = gettingPais.value(forKey: "_id") as! String
            }
            
        } else if indexPath.section == 5 {
            let gettingPais = ((grupoFArray[indexPath.row] as AnyObject).value(forKey: "pais") as? NSDictionary)!
            //print(gettingData)
            if gettingPais.value(forKey: "pais") != nil {
                pais = gettingPais.value(forKey: "pais") as! String
                idpais = gettingPais.value(forKey: "_id") as! String
            }
            
        } else if indexPath.section == 6 {
            let gettingPais = ((grupoGArray[indexPath.row] as AnyObject).value(forKey: "pais") as? NSDictionary)!
            //print(gettingData)
            if gettingPais.value(forKey: "pais") != nil {
                pais = gettingPais.value(forKey: "pais") as! String
                idpais = gettingPais.value(forKey: "_id") as! String
            }
            
        } else if indexPath.section == 7 {
            let gettingPais = ((grupoHArray[indexPath.row] as AnyObject).value(forKey: "pais") as? NSDictionary)!
            //print(gettingData)
            if gettingPais.value(forKey: "pais") != nil {
                pais = gettingPais.value(forKey: "pais") as! String
                idpais = gettingPais.value(forKey: "_id") as! String
            }
            
        }
    
        
    
        
        performSegue(withIdentifier: "players", sender: self)
    }
   

}
