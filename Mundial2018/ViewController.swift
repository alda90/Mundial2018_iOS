//
//  ViewController.swift
//  Mundial2018
//
//  Created by Aldair Carrillo on 21/05/18.
//  Copyright © 2018 Aldair. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var urlCad: String = "";
    var result1: NSString = ""
    var matchesArray: NSArray = NSArray()
    //var idtarget: String = "";
    //var idobjeto: String = "";
    
    var countCont = 0
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var mainMatchesTableView: UITableView!
    
    var date: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
        statusBar?.backgroundColor = UIColor.clear
        
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
        
        scrollView.scrollToTop()
        
        mainMatchesTableView.isHidden = true
        
        countCont = 0
        //date = "2018-06-14"
        compareDates()
        getMainMatches()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func compareDates(){
        let dateFormat = "yyyy-MM-dd"
        let today = Date()
        let iniDate = "2018-06-14"
        let finDate = "2018-07-15"
        let jun29Date = "2018-06-29"
        let jul04Date = "2018-07-04"
        let jul05Date = "2018-07-05"
        let jul08Date = "2018-07-08"
        let jul09Date = "2018-07-09"
        let jul12Date = "2018-07-12"
        let jul13Date = "2018-07-13"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        
        let strDate = dateFormatter.date(from: iniDate)
        let str2Date = dateFormatter.date(from: finDate)
        let str29Date = dateFormatter.date(from: jun29Date)
        let str04Date = dateFormatter.date(from: jul04Date)
        let str05Date = dateFormatter.date(from: jul05Date)
        let str08Date = dateFormatter.date(from: jul08Date)
        let str09Date = dateFormatter.date(from: jul09Date)
        let str12Date = dateFormatter.date(from: jul12Date)
        let str13Date = dateFormatter.date(from: jul13Date)
        if today < strDate! {
            date = "2018-06-14"
        }else if today > str2Date! {
            date = "2018-07-15"
        } else if today == str29Date {
            date = "2018-06-30"
        } else if today == str04Date {
            date = "2018-07-06"
        } else if today == str05Date {
            date = "2018-07-06"
        } else if today == str08Date {
            date = "2018-07-10"
        } else if today == str09Date {
            date = "2018-07-10"
        } else if today == str12Date {
            date = "2018-07-14"
        }  else if today == str13Date {
            date = "2018-07-14"
        } else {
            getDates()
        }
        
    }
    
    func getDates() {
        let dateFormat = "yyyy-MM-dd"
        let today = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        print(dateFormatter.string(from: today))
        let strDate = dateFormatter.string(from: today)
        
        switch strDate {
        case "2018-06-14":
            date = "2018-06-14";
            break;
        case "2018-06-15":
            date = "2018-06-15";
            break;
        case "2018-06-16":
            date = "2018-06-16";
            break;
        case "2018-06-17":
            date = "2018-06-17";
            break;
        case "2018-06-18":
            date = "2018-06-18";
            break;
        case "2018-06-19":
            date = "2018-06-19";
            break;
        case "2018-06-20":
            date = "2018-06-20";
            break;
        case "2018-06-21":
            date = "2018-06-21";
            break;
        case "2018-06-22":
            date = "2018-06-22";
            break;
        case "2018-06-23":
            date = "2018-06-23";
            break;
        case "2018-06-24":
            date = "2018-06-24";
            break;
        case "2018-06-25":
            date = "2018-06-25";
            break;
        case "2018-06-26":
            date = "2018-06-26";
            break;
        case "2018-06-27":
            date = "2018-06-27";
            break;
        case "2018-06-28":
            date = "2018-06-28";
            break;
        case "2018-06-30":
            date = "2018-06-30";
            break;
        case "2018-07-01":
            date = "2018-07-01";
            break;
        case "2018-07-02":
            date = "2018-07-02";
            break;
        case "2018-07-03":
            date = "2018-07-03";
            break;
        case "2018-07-06":
            date = "2018-07-06";
            break;
        case "2018-07-07":
            date = "2018-07-07";
            break;
        case "2018-07-10":
            date = "2018-07-10";
            break;
        case "2018-07-11":
            date = "2018-07-11";
            break;
        case "2018-07-14":
            date = "2018-07-14";
            break;
        default:
            date = "2018-07-15";
        }
    }
    
    /*//////////////////////////////////////////////////////////////////////
     // TABLE Main Matches
     *//////////////////////////////////////////////////////////////////////
    
    func getMainMatches() {
        
        urlCad = urlMundial + "partido/fecha"
        
        
        let URL: Foundation.URL = Foundation.URL(string: urlCad)!
        
        let request:NSMutableURLRequest = NSMutableURLRequest(url:URL)
        //print(request)
        
        request.httpMethod = "POST"
        
        let bodyData = "fecha=\(date)"
        
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
                    if gettingData.value(forKey: "partido") != nil {
                        self.matchesArray = gettingData.value(forKey: "partido") as! NSArray
                        self.showTableView()
                        
                    }
                } catch {
                    
                }
            }
        }
    }
    
    func showTableView() {
        mainMatchesTableView?.delegate = self
        mainMatchesTableView?.dataSource = self
        mainMatchesTableView.reloadData()
        mainMatchesTableView.isHidden = false
        mainMatchesTableView?.tableFooterView = UIView()
        mainMatchesTableView.backgroundColor = UIColor.clear
        //llenarImagen()
    }
    
    /*-----------------TABLE VIEW-----------------*/
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if matchesArray.count > 0 {
            return matchesArray.count
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainMatchesCell", for: indexPath) as! CeldasGralesTableViewCell
        
        cell.imgLocal.layer.cornerRadius = 50
        cell.imgLocal.clipsToBounds = true
        cell.imgLocal.layer.borderColor = UIColor.lightGray.cgColor
        cell.imgLocal.layer.borderWidth = 3
        
        cell.imgVisitante.layer.cornerRadius = 50
        cell.imgVisitante.clipsToBounds = true
        cell.imgVisitante.layer.borderColor = UIColor.lightGray.cgColor
        cell.imgVisitante.layer.borderWidth = 3
        
        print(((matchesArray[indexPath.row] as AnyObject).value(forKey: "partido") as? String)!)
        print(((matchesArray[indexPath.row] as AnyObject).value(forKey: "local") as? NSDictionary)!)
        
        
        
        
        //cell.viewContenidos.layer.borderColor = UIColor.lightGray.cgColor
        //cell.viewContenidos.layer.borderWidth = 2
        
        
        if matchesArray.count > 0 {
            
            
            cell.gLocal.text = ((matchesArray[indexPath.row] as AnyObject).value(forKey: "goleslocal") as? String)!
            cell.gVisita.text = ((matchesArray[indexPath.row] as AnyObject).value(forKey: "golesvisitante") as? String)!
            cell.gLocalp.text = ((matchesArray[indexPath.row] as AnyObject).value(forKey: "goleslocal") as? String)!
            cell.gVisitap.text = "(" + ((matchesArray[indexPath.row] as AnyObject).value(forKey: "golesvisitantep") as? String)! + ")"
            cell.gLocalp.text = "p. (" + ((matchesArray[indexPath.row] as AnyObject).value(forKey: "goleslocalp") as? String)! + ")"
            
            
            var estatus = ((matchesArray[indexPath.row] as AnyObject).value(forKey: "estatus") as? String)!
            
            if(estatus == "PROGRAMADO"){
                cell.lblInfo.text = ((matchesArray[indexPath.row] as AnyObject).value(forKey: "hora") as? String)!
            } else {
                cell.lblInfo.text = ((matchesArray[indexPath.row] as AnyObject).value(forKey: "estatus") as? String)!
            }
            
            var conc = ((matchesArray[indexPath.row] as AnyObject).value(forKey: "conclusion") as? String)!
            
            if(conc != "PENALES") {
                cell.gLocalp.isHidden = true
                cell.gVisitap.isHidden = true
            }
            
            var paisl = ""
            var banderal = ""
            var idl = ""
            let gettingLocal = ((matchesArray[indexPath.row] as AnyObject).value(forKey: "local") as? NSDictionary)!
            //print(gettingData)
            if gettingLocal.value(forKey: "pais") != nil {
                //self.matchesArray = gettingLocal.value(forKey: "partido") as! NSArray
                print(gettingLocal.value(forKey: "bandera") as! String)
                paisl = gettingLocal.value(forKey: "pais") as! String
                banderal = gettingLocal.value(forKey: "bandera") as! String
                idl = gettingLocal.value(forKey: "_id") as! String
            }
            
            let cadImg = "https://mundial-backend.herokuapp.com/img/banderas/"
            
            cell.imgLocal.sd_setImage(with: URL(string: cadImg + banderal))
            cell.lblLocal.text = paisl
            
            ////////////////////////////////////  VISITANTE
            
            var paisv = ""
            var banderav = ""
            var idv = ""
            let gettingVisita = ((matchesArray[indexPath.row] as AnyObject).value(forKey: "visitante") as? NSDictionary)!
            //print(gettingData)
            if gettingVisita.value(forKey: "pais") != nil {
                //self.matchesArray = gettingLocal.value(forKey: "partido") as! NSArray
                
                paisv = gettingVisita.value(forKey: "pais") as! String
                banderav = gettingVisita.value(forKey: "bandera") as! String
                idv = gettingVisita.value(forKey: "_id") as! String
            }
            
            cell.imgVisitante.sd_setImage(with: URL(string: cadImg + banderav))
            cell.lblVisita.text = paisv
          
        }
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        idpartido = (matchesArray[indexPath.row] as AnyObject).value(forKey: "_id") as! String
        npartido = (matchesArray[indexPath.row] as AnyObject).value(forKey: "partido") as! String
        pfecha = (matchesArray[indexPath.row] as AnyObject).value(forKey: "fecha") as! String
        phora = (matchesArray[indexPath.row] as AnyObject).value(forKey: "hora") as! String
        pestatus = (matchesArray[indexPath.row] as AnyObject).value(forKey: "estatus") as! String
        pglocal = (matchesArray[indexPath.row] as AnyObject).value(forKey: "goleslocal") as! String
        pgvisitante = (matchesArray[indexPath.row] as AnyObject).value(forKey: "golesvisitante") as! String
        pglocalp = (matchesArray[indexPath.row] as AnyObject).value(forKey: "goleslocalp") as! String
        pgvisitantep = (matchesArray[indexPath.row] as AnyObject).value(forKey: "golesvisitantep") as! String
        pconclusion = (matchesArray[indexPath.row] as AnyObject).value(forKey: "conclusion") as! String
        
        let gettingLocal = ((matchesArray[indexPath.row] as AnyObject).value(forKey: "local") as? NSDictionary)!
        //print(gettingData)
        if gettingLocal.value(forKey: "pais") != nil {
            plocal = gettingLocal.value(forKey: "pais") as! String
            pbanderal = gettingLocal.value(forKey: "bandera") as! String
            pidlocal = gettingLocal.value(forKey: "_id") as! String
        }
        
        let gettingVisita = ((matchesArray[indexPath.row] as AnyObject).value(forKey: "visitante") as? NSDictionary)!
        //print(gettingData)
        if gettingVisita.value(forKey: "pais") != nil {
            pvisitante = gettingVisita.value(forKey: "pais") as! String
            pbanderav = gettingVisita.value(forKey: "bandera") as! String
            pidvisitante = gettingVisita.value(forKey: "_id") as! String
        }
        
        // self.performSegue(withIdentifier: "tour", sender: self)
        
        //let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "idMatch") as? MatchViewController
        //mapViewControllerObj?.link = link
        
        //self.present(mapViewControllerObj!, animated: true, completion: nil)
        
        performSegue(withIdentifier: "mainmatch", sender: self)
    }
    
    

}

extension UIScrollView {
    func scrollToTop() {
        let desiredOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(desiredOffset, animated: true)
    }
}
