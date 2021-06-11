//
//  ViewController.swift
//  Mundial2018
//
//  Created by Aldair Carrillo on 21/05/18.
//  Copyright © 2018 Aldair. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, apiCallsProtocol {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mainMatchesTableView: UITableView!
    
    private var apiCall = RestApiCalls()
    private var matches: [Match] = [Match]()
    private var date: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
        //statusBar?.backgroundColor = UIColor.clear
        
        scrollView.scrollToTop()
        
        mainMatchesTableView.isHidden = true
        
        compareDates()
        apiCall.delegate = self
        apiCall.getFixtures(targetVC: self, date: "")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
//        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationController!.navigationBar.shadowImage = UIImage()
//        self.navigationController!.navigationBar.isTranslucent = true
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
        
        getDates()
        
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
        mainMatchesTableView?.delegate = self
        mainMatchesTableView?.dataSource = self
        mainMatchesTableView.reloadData()
        mainMatchesTableView.isHidden = false
        mainMatchesTableView?.tableFooterView = UIView()
        mainMatchesTableView.backgroundColor = UIColor.clear
    }
    
    /*-----------------TABLE VIEW-----------------*/
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matches.count
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
        
        //print(((matchesArray[indexPath.row] as AnyObject).value(forKey: "partido") as? String)!)
        //print(((matchesArray[indexPath.row] as AnyObject).value(forKey: "local") as? NSDictionary)!)
        //cell.viewContenidos.layer.borderColor = UIColor.lightGray.cgColor
        //cell.viewContenidos.layer.borderWidth = 2
        
        
        let vw = cell.viewBackground
        vw!.layer.shadowColor = UIColor.black.cgColor
        vw!.layer.shadowOpacity = 1
        vw!.layer.shadowOffset = .zero
        vw!.layer.shadowRadius = 3
        
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
            
            
            cell.gLocal.text = gLocal
            cell.gVisita.text = gVisita
            
            if v1Et != -1 {
                cell.gLocal.text = gLocalEt
                cell.gVisita.text = gVisitaEt
                if v1P != -1 {
                    cell.gLocalp.text = gLocalp
                    cell.gVisitap.text = gVisitap
                }
            }
            
            cell.lblInfo.text = "FINISHED"

            if v1P == -1 {
                cell.gLocalp.isHidden = true
                cell.gVisitap.isHidden = true
            }
            
            cell.gLocalp.isHidden = true
            cell.gVisitap.isHidden = true
           
            let team1 = self.matches[indexPath.row].team1

            cell.imgLocal.image = UIImage(named: team1.code)
            cell.lblLocal.text = team1.name
            
           
            
            ////////////////////////////////////  VISITANTE
            
            let team2 = self.matches[indexPath.row].team2
            cell.imgVisitante.image = UIImage(named: team2.code)
            cell.lblVisita.text = team2.name
            
          
        }
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        varMatch = self.matches[indexPath.row]
        performSegue(withIdentifier: "mainmatch", sender: self)
    }
    
    

}

extension UIScrollView {
    func scrollToTop() {
        let desiredOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(desiredOffset, animated: true)
    }
}
