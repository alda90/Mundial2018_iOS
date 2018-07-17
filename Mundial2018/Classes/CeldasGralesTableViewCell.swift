//
//  CeldasGralesTableViewCell.swift
//  Mundial2018
//
//  Created by Aldair Carrillo on 22/05/18.
//  Copyright © 2018 Aldair. All rights reserved.
//

import UIKit

class CeldasGralesTableViewCell: UITableViewCell {
    
    
    //// Main Matches
    
    @IBOutlet weak var imgLocal: UIImageView!
    @IBOutlet weak var imgVisitante: UIImageView!
    
    @IBOutlet weak var lblLocal: UILabel!
    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var lblVisita: UILabel!
    
    @IBOutlet weak var gLocal: UILabel!
    @IBOutlet weak var gVisita: UILabel!
    
    @IBOutlet weak var gLocalp: UILabel!
    @IBOutlet weak var gVisitap: UILabel!
    
    
    //// Incidencias
    
    @IBOutlet weak var lblMin: UILabel!
    @IBOutlet weak var imgInc: UIImageView!
    @IBOutlet weak var imgIn: UIImageView!
    @IBOutlet weak var imgOut: UIImageView!
    @IBOutlet weak var lblPlayer: UILabel!
    @IBOutlet weak var lblSubs: UILabel!
    
    
    /// Alineacion
    
    @IBOutlet weak var imgPlayer: UIImageView!
    @IBOutlet weak var lblNum: UILabel!
    @IBOutlet weak var lblJugador: UILabel!
    @IBOutlet weak var lblPos: UILabel!
    
    /// Matches
    
    @IBOutlet weak var mImgLocal: UIImageView!
    @IBOutlet weak var mImgVisita: UIImageView!
    
    @IBOutlet weak var mLblLocal: UILabel!
    @IBOutlet weak var mLblGLocal: UILabel!
    @IBOutlet weak var mLblInfo: UILabel!
    @IBOutlet weak var mLblVisita: UILabel!
    @IBOutlet weak var mLblGVisita: UILabel!
    
    /// Groups
    
    @IBOutlet weak var imgPais: UIImageView!
    @IBOutlet weak var lblPais: UILabel!
    @IBOutlet weak var lblP: UILabel!
    @IBOutlet weak var lblPartidos: UILabel!
    @IBOutlet weak var lblDif: UILabel!
    @IBOutlet weak var lblPuntos: UILabel!
    
    /// Players
    
    @IBOutlet weak var pImgPlayer: UIImageView!
    @IBOutlet weak var pLblNum: UILabel!
    @IBOutlet weak var pLblPlayer: UILabel!
    @IBOutlet weak var pLblPos: UILabel!
    
    
    /// Estadios
    @IBOutlet weak var imgEstadio: UIImageView!
    @IBOutlet weak var lblEstadio: UILabel!
    @IBOutlet weak var lblCapacidad: UILabel!
    @IBOutlet weak var lblSede: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
