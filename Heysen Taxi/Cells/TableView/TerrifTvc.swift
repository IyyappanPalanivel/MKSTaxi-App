//
//  TerrifTvc.swift
//  MKSTaxi App
//
//  Created by develop on 22/03/22.
//

import UIKit

class TerrifTvc: UITableViewCell {

    @IBOutlet weak var cornerVw: UIView!
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var amountLbl: UILabel!
    
    @IBOutlet weak var roundVw: UIView!
    @IBOutlet weak var roundVw2: UIView!
    @IBOutlet weak var desclbl: UILabel!
    @IBOutlet weak var seatsLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cornerVw.addshadow(withShadow: .lightGray, withradius: 2)
        cornerVw.cornerRadius(withradius: 8, withBackgroundColor: .clear, widthjBorderWidth: 0)
        roundVw.layer.cornerRadius = roundVw.frame.width / 2
        roundVw2.layer.cornerRadius = roundVw2.frame.width / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
