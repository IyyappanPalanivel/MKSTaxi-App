//
//  HistoryTvc.swift
//  MKSTaxi App
//
//  Created by develop on 28/03/22.
//

import UIKit

class HistoryTvc: UITableViewCell {

    @IBOutlet weak var cornerVw: UIView!
    @IBOutlet weak var carnameLbl: UILabel!
    @IBOutlet weak var dateTineLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var fromAddresslbl: UILabel!
    
    @IBOutlet weak var hgt: NSLayoutConstraint!
    @IBOutlet weak var greenVw: UIView!
    @IBOutlet weak var redVw: UIView!
    @IBOutlet weak var bookTypeLbl: UILabel!
    @IBOutlet weak var toAddressLbl: UILabel!
    
    @IBOutlet weak var mobilenoLbl: UILabel!
    @IBOutlet weak var regNolbl: UILabel!
    @IBOutlet weak var vechNameLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var new: UIStackView!
    
    @IBOutlet weak var drivelb: UILabel!
    @IBOutlet weak var drivedetail: UIView!
    
    @IBOutlet weak var cancelBtn: UIButton!
    
    @IBOutlet weak var cancelhgt: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        greenVw.layer.cornerRadius = greenVw.frame.width / 2
        redVw.layer.cornerRadius = redVw.frame.width / 2
        cornerVw.addshadow(withShadow: .lightGray, withradius: 2)
        cornerVw.cornerRadius(withradius: 8, withBackgroundColor: .clear, widthjBorderWidth: 0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
