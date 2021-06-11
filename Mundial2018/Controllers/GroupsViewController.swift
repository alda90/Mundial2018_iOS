//
//  GroupsViewController.swift
//  Mundial2018
//
//  Created by Aldair Carrillo on 27/05/18.
//  Copyright © 2018 Aldair. All rights reserved.
//

import UIKit

class GroupsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, apiCallsProtocol {
    
    
    @IBOutlet weak var groupsTableView: UITableView!
    
    private var apiCall = RestApiCalls()
    private var standings: [Standings] = [Standings]()
    
    var groupA: [Standing] = [Standing]()
    var groupB: [Standing] = [Standing]()
    var groupC: [Standing] = [Standing]()
    var groupD: [Standing] = [Standing]()
    var groupE: [Standing] = [Standing]()
    var groupF: [Standing] = [Standing]()
    var groupG: [Standing] = [Standing]()
    var groupH: [Standing] = [Standing]()
    
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
        apiCall.delegate = self
        apiCall.getGroups(targetVC: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*//////////////////////////////////////////////////////////////////////
     // TABLE Main Matches
     *//////////////////////////////////////////////////////////////////////
  
        
        func getResponse(response: Response) {
            do {
              
                self.standings = response.standings!
                self.setData()
                self.showTableView()

            } catch {
                print("ERROR")
            }
        }
        
        func getErrorResponse(error: NSString) {
            print("error: \(error)")
        }
        
        
    
    func setData(){
        for index in 0..<self.standings.count{
            //add an element and the previous element together
            var grupo = ""
            let standings = self.standings[index].standings
            
            grupo = self.standings[index].name
            
            
            if grupo == "Group A" {
                groupA = standings
            } else  if grupo == "Group B"{
                groupB = standings
            } else  if grupo == "Group C"{
                groupC = standings
            } else  if grupo == "Group D"{
                groupD = standings
            } else  if grupo == "Group E"{
                groupE = standings
            } else  if grupo == "Group F"{
                groupF = standings
            } else  if grupo == "Group G"{
                groupG = standings
            } else  if grupo == "Group H"{
                groupH = standings
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
        
    }
    
    /*-----------------TABLE VIEW-----------------*/
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return groupA.count
        } else if section == 1 {
            return groupB.count
        } else if section == 2 {
            return groupC.count
        } else if section == 3 {
            return groupD.count
        } else if section == 4 {
            return groupE.count
        } else if section == 5 {
            return groupF.count
        } else if section == 6 {
            return groupG.count
        } else if section == 7 {
            return groupH.count
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
        label.textColor = UIColor.white
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
       
        cell.imgPais.layer.cornerRadius = 30
        cell.imgPais.clipsToBounds = true
        cell.imgPais.layer.borderColor = UIColor.lightGray.cgColor
        cell.imgPais.layer.borderWidth = 1
        
        var groupT: [Standing] = [Standing]()
      
        if indexPath.section == 0  && groupA.count > 0 {
            
            groupT = groupA

            
        } else if indexPath.section == 1  && groupB.count > 0 {
            
            
            groupT = groupB

            
        } else if indexPath.section == 2  && groupC.count > 0 {
            
            groupT = groupC
            

            
        } else if indexPath.section == 3  && groupD.count > 0 {
            
            
            groupT = groupD

            
        } else if indexPath.section == 4  && groupE.count > 0 {
            
            
            groupT = groupE

            
        } else if indexPath.section == 5  && groupF.count > 0 {
            
            
            groupT = groupF

            
        } else if indexPath.section == 6  && groupG.count > 0 {
            
            groupT = groupG

            
        }  else if indexPath.section == 7  && groupH.count > 0 {
            
            groupT = groupH

        }
        
        cell.lblP.text = "\(groupT[indexPath.row].played)"
        cell.lblPartidos.text = "\(groupT[indexPath.row].won) - \(groupT[indexPath.row].drawn) - \(groupT[indexPath.row].lost)"
        let goals_for = groupT[indexPath.row].goals_for
        let goals_agaisnt = groupT[indexPath.row].goals_against
        cell.lblDif.text = "\(goals_for - goals_agaisnt)"
        cell.lblPuntos.text = "\(groupT[indexPath.row].pts)"

        let team = groupT[indexPath.row].team
        cell.imgPais.image = UIImage(named: team.code)
        cell.lblPais.text = team.name
        
        
        
        return cell
    }
    

}
