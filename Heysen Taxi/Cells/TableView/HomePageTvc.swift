//
//  HomePageTvc.swift
//  MKSTaxi App
//
//  Created by develop on 23/03/22.
//

import UIKit

class HomePageTvc: UITableViewCell {

    @IBOutlet weak var seatsAmountLbl: UILabel!
    @IBOutlet weak var carImg: UIImageView!
    @IBOutlet weak var carnameLbl: UILabel!
    @IBOutlet weak var cornerVw: UIView!
    
    @IBOutlet weak var totalLbl: UILabel!
    @IBOutlet weak var bookbtn: UILabel!
    @IBOutlet weak var hideVw: UIStackView!
    @IBOutlet weak var basefareLbl: UILabel!
    @IBOutlet weak var driverLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        cornerVw.addshadow(withShadow: .lightGray, withradius: 4)
        cornerVw.cornerRadius(withradius: 8, withBackgroundColor: .clear, widthjBorderWidth: 0)
        bookbtn.cornerRadius(withradius: 8, withBackgroundColor: .clear, widthjBorderWidth: 0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
