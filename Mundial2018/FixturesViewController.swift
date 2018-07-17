//
//  FixturesViewController.swift
//  Mundial2018
//
//  Created by Aldair Carrillo on 21/05/18.
//  Copyright © 2018 Aldair. All rights reserved.
//

import UIKit
import ScrollableSegmentedControl

class FixturesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
   
    @IBOutlet weak var segmentedControl: ScrollableSegmentedControl!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var matchesTableView: UITableView!
    
    
    var urlCad: String = "";
    var result1: NSString = ""
    var matchesArray: NSArray = NSArray()
    
    var date: String = ""
    var pos: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
        statusBar?.backgroundColor = UIColor.clear
        
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
        
        scrollView.scrollToTop()
        
        segmentedControl.segmentStyle = .textOnly
        setFixtures()
        compareDates()
        
        segmentedControl.underlineSelected = true
        
        segmentedControl.addTarget(self, action: #selector(FixturesViewController.segmentSelected(sender:)), for: .valueChanged)
        
        // change some colors
        segmentedControl.segmentContentColor = UIColor.white
        segmentedControl.selectedSegmentContentColor = UIColor.blue
        segmentedControl.backgroundColor = UIColor.gray
        
        

        // Do any additional setup after loading the view.
        
        //date = "2018-06-14"
        compareDates()
        segmentedControl.selectedSegmentIndex = pos
        getMatches()
    }
    
    
    func setFixtures(){
        segmentedControl.insertSegment(withTitle: "14 Jun", at: 0)
        segmentedControl.insertSegment(withTitle: "15 Jun", at: 1)
        segmentedControl.insertSegment(withTitle: "16 Jun", at: 2)
        segmentedControl.insertSegment(withTitle: "17 Jun", at: 3)
        segmentedControl.insertSegment(withTitle: "18 Jun", at: 4)
        segmentedControl.insertSegment(withTitle: "19 Jun", at: 5)
        segmentedControl.insertSegment(withTitle: "20 Jun", at: 6)
        segmentedControl.insertSegment(withTitle: "21 Jun", at: 7)
        segmentedControl.insertSegment(withTitle: "22 Jun", at: 8)
        segmentedControl.insertSegment(withTitle: "23 Jun", at: 9)
        segmentedControl.insertSegment(withTitle: "24 Jun", at: 10)
        segmentedControl.insertSegment(withTitle: "25 Jun", at: 11)
        segmentedControl.insertSegment(withTitle: "26 Jun", at: 12)
        segmentedControl.insertSegment(withTitle: "27 Jun", at: 13)
        segmentedControl.insertSegment(withTitle: "28 Jun", at: 14)
        segmentedControl.insertSegment(withTitle: "30 Jun", at: 15)
        segmentedControl.insertSegment(withTitle: "1 Jul", at: 16)
        segmentedControl.insertSegment(withTitle: "2 Jul", at: 17)
        segmentedControl.insertSegment(withTitle: "3 Jul", at: 18)
        segmentedControl.insertSegment(withTitle: "6 Jul", at: 19)
        segmentedControl.insertSegment(withTitle: "7 Jul", at: 20)
        segmentedControl.insertSegment(withTitle: "10 Jul", at: 21)
        segmentedControl.insertSegment(withTitle: "11 Jul", at: 22)
        segmentedControl.insertSegment(withTitle: "14 Jul", at: 23)
        segmentedControl.insertSegment(withTitle: "15 Jul", at: 24)
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
            pos = 0
        }else if today > str2Date! {
            date = "2018-07-15"
            pos = 24
        } else if today == str29Date {
            date = "2018-06-30"
            pos = 15
        } else if today == str04Date {
            date = "2018-07-06"
            pos = 19
        } else if today == str05Date {
            date = "2018-07-06"
            pos = 19
        } else if today == str08Date {
            date = "2018-07-10"
            pos = 21
        } else if today == str09Date {
            date = "2018-07-10"
            pos = 21
        } else if today == str12Date {
            date = "2018-07-14"
            pos = 23
        }  else if today == str13Date {
            date = "2018-07-14"
            pos = 23
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
            pos = 0;
            break;
        case "2018-06-15":
            date = "2018-06-15";
            pos = 1;
            break;
        case "2018-06-16":
            date = "2018-06-16";
            pos = 2;
            break;
        case "2018-06-17":
            date = "2018-06-17";
            pos = 3;
            break;
        case "2018-06-18":
            date = "2018-06-18";
            pos = 4;
            break;
        case "2018-06-19":
            date = "2018-06-19";
            pos = 5;
            break;
        case "2018-06-20":
            date = "2018-06-20";
            pos = 6;
            break;
        case "2018-06-21":
            date = "2018-06-21";
            pos = 7;
            break;
        case "2018-06-22":
            date = "2018-06-22";
            pos = 8;
            break;
        case "2018-06-23":
            date = "2018-06-23";
            pos = 9;
            break;
        case "2018-06-24":
            date = "2018-06-24";
            pos = 10;
            break;
        case "2018-06-25":
            date = "2018-06-25";
            pos = 11;
            break;
        case "2018-06-26":
            date = "2018-06-26";
            pos = 12;
            break;
        case "2018-06-27":
            date = "2018-06-27";
            pos = 13;
            break;
        case "2018-06-28":
            date = "2018-06-28";
            pos = 14;
            break;
        case "2018-06-30":
            date = "2018-06-30";
            pos = 15;
            break;
        case "2018-07-01":
            date = "2018-07-01";
            pos = 16;
            break;
        case "2018-07-02":
            date = "2018-07-02";
            pos = 17;
            break;
        case "2018-07-03":
            date = "2018-07-03";
            pos = 18;
            break;
        case "2018-07-06":
            date = "2018-07-06";
            pos = 19;
            break;
        case "2018-07-07":
            date = "2018-07-07";
            pos = 20;
            break;
        case "2018-07-10":
            date = "2018-07-10";
            pos = 21;
            break;
        case "2018-07-11":
            date = "2018-07-11";
            pos = 22;
            break;
        case "2018-07-14":
            date = "2018-07-14";
            pos = 23;
            break;
        default:
            date = "2018-07-15";
            pos = 24;
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func segmentSelected(sender:ScrollableSegmentedControl) {
        print("Segment at index \(sender.selectedSegmentIndex)  selected")
        
        switch sender.selectedSegmentIndex {
        case 0:
            date = "2018-06-14"
            getMatches()
        case 1:
            date = "2018-06-15"
            getMatches()
        case 2:
            date = "2018-06-16"
            getMatches()
        case 3:
            date = "2018-06-17"
            getMatches()
        case 4:
            date = "2018-06-18"
            getMatches()
        case 5:
            date = "2018-06-19"
            getMatches()
        case 6:
            date = "2018-06-20"
            getMatches()
        case 7:
            date = "2018-06-21"
            getMatches()
        case 8:
            date = "2018-06-22"
            getMatches()
        case 9:
            date = "2018-06-23"
            getMatches()
        case 10:
            date = "2018-06-24"
            getMatches()
        case 11:
            date = "2018-06-25"
            getMatches()
        case 12:
            date = "2018-06-26"
            getMatches()
        case 13:
            date = "2018-06-27"
            getMatches()
        case 14:
            date = "2018-06-28"
            getMatches()
        case 15:
            date = "2018-06-30"
            getMatches()
        case 16:
            date = "2018-07-01"
            getMatches()
        case 17:
            date = "2018-07-02"
            getMatches()
        case 18:
            date = "2018-07-03"
            getMatches()
        case 19:
            date = "2018-07-06"
            getMatches()
        case 20:
            date = "2018-07-07"
            getMatches()
        case 21:
            date = "2018-07-10"
            getMatches()
        case 22:
            date = "2018-07-11"
            getMatches()
        case 23:
            date = "2018-07-14"
            getMatches()
        case 24:
            date = "2018-07-15"
            getMatches()
        default:
            date = "2018-06-14"
            getMatches()
        }
    }
    
    /*//////////////////////////////////////////////////////////////////////
     // TABLE Matches
     *//////////////////////////////////////////////////////////////////////
    
    func getMatches() {
        
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
        matchesTableView?.delegate = self
        matchesTableView?.dataSource = self
        matchesTableView.reloadData()
        matchesTableView.isHidden = false
        matchesTableView?.tableFooterView = UIView()
        matchesTableView.backgroundColor = UIColor.clear
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
        return 95
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "matchCell", for: indexPath) as! CeldasGralesTableViewCell
        
        cell.mImgLocal.layer.cornerRadius = 30
        cell.mImgLocal.clipsToBounds = true
        cell.mImgLocal.layer.borderColor = UIColor.lightGray.cgColor
        cell.mImgLocal.layer.borderWidth = 1
        
        cell.mImgVisita.layer.cornerRadius = 30
        cell.mImgVisita.clipsToBounds = true
        cell.mImgVisita.layer.borderColor = UIColor.lightGray.cgColor
        cell.mImgVisita.layer.borderWidth = 1
        
        print(((matchesArray[indexPath.row] as AnyObject).value(forKey: "partido") as? String)!)
        print(((matchesArray[indexPath.row] as AnyObject).value(forKey: "local") as? NSDictionary)!)
        
        
        
        
        //cell.viewContenidos.layer.borderColor = UIColor.lightGray.cgColor
        //cell.viewContenidos.layer.borderWidth = 2
        
        
        if matchesArray.count > 0 {
            
            
            let gLocal = ((matchesArray[indexPath.row] as AnyObject).value(forKey: "goleslocal") as? String)!
            let gVisita = ((matchesArray[indexPath.row] as AnyObject).value(forKey: "golesvisitante") as? String)!
            let gLocalp = "(" + ((matchesArray[indexPath.row] as AnyObject).value(forKey: "goleslocalp") as? String)! + ")"
            let gVisitap = "(" + ((matchesArray[indexPath.row] as AnyObject).value(forKey: "golesvisitantep") as? String)! + ")"
            
            
            var estatus = ((matchesArray[indexPath.row] as AnyObject).value(forKey: "estatus") as? String)!
            
            if(estatus == "PROGRAMADO" || estatus == "POR EMPEZAR"){
                cell.mLblInfo.text = ((matchesArray[indexPath.row] as AnyObject).value(forKey: "hora") as? String)!
            } else {
                cell.mLblInfo.text = ((matchesArray[indexPath.row] as AnyObject).value(forKey: "estatus") as? String)!
            }
            
            var conc = ((matchesArray[indexPath.row] as AnyObject).value(forKey: "conclusion") as? String)!
            
            if(conc == "Penales") {
               cell.mLblGLocal.text = gLocal + gLocalp
                cell.mLblGVisita.text = gVisita + gVisitap
            } else {
                cell.mLblGLocal.text = gLocal
                cell.mLblGVisita.text = gVisita
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
            
            cell.mImgLocal.sd_setImage(with: URL(string: cadImg + banderal))
            cell.mLblLocal.text = paisl
            
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
            
            cell.mImgVisita.sd_setImage(with: URL(string: cadImg + banderav))
            cell.mLblVisita.text = paisv
            
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
        
        performSegue(withIdentifier: "match", sender: self)
    }

}




