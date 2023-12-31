//
//  PPAppointmentsTableViewCell.swift
//  E health App
//
//  Created by Ranjan on 03/09/21.
//

import UIKit

class PPAppointmentsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var viewBG:UIView!{
        didSet {
            viewBG.backgroundColor =  .white
            viewBG.layer.cornerRadius = 7.0
            viewBG.clipsToBounds = true
            
            viewBG.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            viewBG.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            viewBG.layer.shadowOpacity = 1.0
            viewBG.layer.shadowRadius = 7.0
            viewBG.layer.masksToBounds = false
        }
    }
    
    @IBOutlet weak var imgPatientProfile:UIImageView! {
        didSet {
            imgPatientProfile.layer.cornerRadius = 8
            imgPatientProfile.clipsToBounds = true
            /*imgPatientProfile.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            imgPatientProfile.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            imgPatientProfile.layer.shadowOpacity = 1.0
            imgPatientProfile.layer.shadowRadius = 7.0
            imgPatientProfile.layer.masksToBounds = false*/
        }
    }
    
    @IBOutlet weak var lblPatientName:UILabel!
    @IBOutlet weak var btnAppointmentDateTime:UIButton!
    @IBOutlet weak var btnPatientAddress:UIButton!
    
    @IBOutlet weak var imgEye: UIImageView! {
        didSet{
            imgEye.layer.cornerRadius = 5.0
            imgEye.clipsToBounds = true
            imgEye.isHidden = true
        }
    }
    
    @IBOutlet weak var btn_notes:UIButton! {
        didSet {
            /*lbl_notes.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            lbl_notes.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            lbl_notes.layer.shadowOpacity = 1.0
            lbl_notes.layer.shadowRadius = 15.0
            lbl_notes.layer.masksToBounds = false*/
            btn_notes.setTitle("Notes", for: .normal)
            btn_notes.setTitleColor(.white, for: .normal)
            btn_notes.layer.cornerRadius = 15
            btn_notes.clipsToBounds = true
            btn_notes.backgroundColor = UIColor(red: 56.0/255.0, green: 126.0/255.0, blue: 70.0/255.0, alpha: 1)
        }
    }
    
    // 56 126 70

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
