//
//  FAQTvc.swift
//  MKSTaxi App
//
//  Created by develop on 26/03/22.
//

import UIKit

class FAQTvc: UITableViewCell {
    
    @IBOutlet weak var clickVw: UIView!
    @IBOutlet weak var cornerVw: UIStackView!
    @IBOutlet weak var downImg: UIImageView!
    @IBOutlet weak var topLbl: UILabel!
    
    @IBOutlet weak var hideVw: UIView!
    @IBOutlet weak var contentLbl: UILabel!
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
