//
//  EstadiumsViewController.swift
//  Mundial2018
//
//  Created by Aldair Carrillo on 29/05/18.
//  Copyright © 2018 Aldair. All rights reserved.
//

import UIKit

class EstadiumsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, apiCallsProtocol {
    
    private var apiCall = RestApiCalls()
    var stadiums: [Stadium] = [Stadium]()
    
    @IBOutlet weak var estadiosTableView: UITableView!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
        // Do any additional setup after loading the view.
        apiCall.delegate = self
        apiCall.getStadiums(targetVC: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getResponse(response: Response) {
        do {
          
            self.stadiums = response.stadiums!
            self.showTableView()

        } catch {
            print("ERROR")
        }
    }
    
    func getErrorResponse(error: NSString) {
        print("error: \(error)")
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
        
        return stadiums.count
       
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "citiesCell", for: indexPath) as! CeldasGralesTableViewCell
        
        
       
        let vw = cell.viewBackEstadiums
        vw!.layer.shadowColor = UIColor.black.cgColor
        vw!.layer.shadowOpacity = 1
        vw!.layer.shadowOffset = .zero
        vw!.layer.shadowRadius = 3
        
        
        // Similar to above, first check if there is a valid section of table.
        // Then we check that for the section there is a row.
        if stadiums.count > 0 {
            
            cell.lblEstadio.text = self.stadiums[indexPath.row].name
            cell.lblCapacidad.text = "\(self.stadiums[indexPath.row].capacity ?? 0)"
            cell.lblSede.text = self.stadiums[indexPath.row].city
            let photo = self.stadiums[indexPath.row].photo ?? ""
            
            cell.imgEstadio.sd_setImage(with: URL(string: photo )) { (image, error, cache, urls) in
                if error != nil {
                    cell.imgEstadio.image = UIImage(named: "logo")
                } else {
                    cell.imgEstadio.image = image
                }
            }
            
            
        }
        
        
        return cell
    }

}
