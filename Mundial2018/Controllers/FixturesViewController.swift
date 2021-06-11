//
//  FixturesViewController.swift
//  Mundial2018
//
//  Created by Aldair Carrillo on 21/05/18.
//  Copyright © 2018 Aldair. All rights reserved.
//

import UIKit
import ScrollableSegmentedControl

class FixturesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, apiCallsProtocol {
    
   
    @IBOutlet weak var segmentedControl: ScrollableSegmentedControl!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var matchesTableView: UITableView!
    
    private var apiCall = RestApiCalls()
    var matches: [Match] = [Match]()
    
    var date: String = ""
    var pos: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
        
        compareDates()
        segmentedControl.selectedSegmentIndex = pos

    }
    
    override func viewDidAppear(_ animated: Bool) {
        apiCall.delegate = self
        apiCall.getFixtures(targetVC: self, date: date)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
//        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationController!.navigationBar.shadowImage = UIImage()
//        self.navigationController!.navigationBar.isTranslucent = true
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
        
        getDates()
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
        }
        
    }
    
    func getDates() {
        let dateFormat = "yyyy-MM-dd"
        let today = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        print(dateFormatter.string(from: today))
        let strDate = dateFormatter.string(from: today)
        
        
        date = strDate
        
        switch strDate {
        case "2018-06-14":
            pos = 0;
            break;
        case "2018-06-15":
            pos = 1;
            break;
        case "2018-06-16":
            pos = 2;
            break;
        case "2018-06-17":
            pos = 3;
            break;
        case "2018-06-18":
            pos = 4;
            break;
        case "2018-06-19":
            pos = 5;
            break;
        case "2018-06-20":
            pos = 6;
            break;
        case "2018-06-21":
            pos = 7;
            break;
        case "2018-06-22":
            pos = 8;
            break;
        case "2018-06-23":
            pos = 9;
            break;
        case "2018-06-24":
            pos = 10;
            break;
        case "2018-06-25":
            pos = 11;
            break;
        case "2018-06-26":
            pos = 12;
            break;
        case "2018-06-27":
            pos = 13;
            break;
        case "2018-06-28":
            pos = 14;
            break;
        case "2018-06-30":
            pos = 15;
            break;
        case "2018-07-01":
            pos = 16;
            break;
        case "2018-07-02":
            pos = 17;
            break;
        case "2018-07-03":
            pos = 18;
            break;
        case "2018-07-06":
            pos = 19;
            break;
        case "2018-07-07":
            pos = 20;
            break;
        case "2018-07-10":
            pos = 21;
            break;
        case "2018-07-11":
            pos = 22;
            break;
        case "2018-07-14":
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
            apiCall.getFixtures(targetVC: self, date: date)
        case 1:
            date = "2018-06-15"
            apiCall.getFixtures(targetVC: self, date: date)
        case 2:
            date = "2018-06-16"
            apiCall.getFixtures(targetVC: self, date: date)
        case 3:
            date = "2018-06-17"
            apiCall.getFixtures(targetVC: self, date: date)
        case 4:
            date = "2018-06-18"
            apiCall.getFixtures(targetVC: self, date: date)
        case 5:
            date = "2018-06-19"
            apiCall.getFixtures(targetVC: self, date: date)
        case 6:
            date = "2018-06-20"
            apiCall.getFixtures(targetVC: self, date: date)
        case 7:
            date = "2018-06-21"
            apiCall.getFixtures(targetVC: self, date: date)
        case 8:
            date = "2018-06-22"
            apiCall.getFixtures(targetVC: self, date: date)
        case 9:
            date = "2018-06-23"
            apiCall.getFixtures(targetVC: self, date: date)
        case 10:
            date = "2018-06-24"
            apiCall.getFixtures(targetVC: self, date: date)
        case 11:
            date = "2018-06-25"
            apiCall.getFixtures(targetVC: self, date: date)
        case 12:
            date = "2018-06-26"
            apiCall.getFixtures(targetVC: self, date: date)
        case 13:
            date = "2018-06-27"
            apiCall.getFixtures(targetVC: self, date: date)
        case 14:
            date = "2018-06-28"
            apiCall.getFixtures(targetVC: self, date: date)
        case 15:
            date = "2018-06-30"
            apiCall.getFixtures(targetVC: self, date: date)
        case 16:
            date = "2018-07-01"
            apiCall.getFixtures(targetVC: self, date: date)
        case 17:
            date = "2018-07-02"
            apiCall.getFixtures(targetVC: self, date: date)
        case 18:
            date = "2018-07-03"
            apiCall.getFixtures(targetVC: self, date: date)
        case 19:
            date = "2018-07-06"
            apiCall.getFixtures(targetVC: self, date: date)
        case 20:
            date = "2018-07-07"
            apiCall.getFixtures(targetVC: self, date: date)
        case 21:
            date = "2018-07-10"
            apiCall.getFixtures(targetVC: self, date: date)
        case 22:
            date = "2018-07-11"
            apiCall.getFixtures(targetVC: self, date: date)
        case 23:
            date = "2018-07-14"
            apiCall.getFixtures(targetVC: self, date: date)
        case 24:
            date = "2018-07-15"
            apiCall.getFixtures(targetVC: self, date: date)
        default:
            date = "2018-06-14"
            apiCall.getFixtures(targetVC: self, date: date)
        }
    }
    

    
    func getResponse(response: Response) {
        do {
          
            self.matches = response.fixtures![0].matches
            self.showTableView()

        } catch {
            print("ERROR")
        }
    }
    
    func getErrorResponse(error: NSString) {
        print("error: \(error)")
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
        if matches.count > 0 {
            return matches.count
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
        

        
        if matches.count > 0 {
            
            let v1Et = self.matches[indexPath.row].score1et ?? -1
            let v2Et = self.matches[indexPath.row].score2et ?? -1
            let v1P = self.matches[indexPath.row].score1p ?? -1
            let v2P = self.matches[indexPath.row].score2p ?? -1
            
            
            let gLocal = "\(self.matches[indexPath.row].score1)"
            let gVisita = "\(self.matches[indexPath.row].score2)"
            let gLocalEt = "\(v1Et)"
            let gVisitaEt = "\(v2Et)"
            let gLocalp = "(\(v1P))"
            let gVisitap = "(\(v2P))"
            
            cell.mLblInfo.text = "FINISHED"
            cell.mLblGLocal.text = gLocal
            cell.mLblGVisita.text = gVisita
        
            if v1Et != -1 {
                if v1P != -1 {
                    cell.mLblGLocal.text = gLocalEt + gLocalp
                    cell.mLblGVisita.text = gVisitaEt + gVisitap
                } else {
                    cell.mLblGLocal.text = gLocalEt
                    cell.mLblGVisita.text = gVisitaEt
                }
                
            }
            
            
            let team1 = self.matches[indexPath.row].team1

            cell.mImgLocal.image = UIImage(named: team1.code)
            cell.mLblLocal.text = team1.name
            
            ////////////////////////////////////  VISITANTE
            let team2 = self.matches[indexPath.row].team2
            cell.mImgVisita.image = UIImage(named: team2.code)
            cell.mLblVisita.text = team2.name
            
        }
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        varMatch = self.matches[indexPath.row]
        performSegue(withIdentifier: "match", sender: self)
    }

}




