//
//  forgotPasswordVC.swift
//  E health App
//
//  Created by Ranjan on 21/08/21.
//

import UIKit

class forgotPasswordVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var viewNavigationbar:UIView!
    @IBOutlet weak var btnNavigationBack:UIButton!
    @IBOutlet weak var lblNavationbar:UILabel!{
        didSet {
            
            lblNavationbar.text = "FORGOT PASSWORD"
        }
    }
    
    @IBOutlet weak var viewImgBG:UIView!{
        didSet{
            
            viewImgBG.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            viewImgBG.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            viewImgBG.layer.shadowOpacity = 1.0
            viewImgBG.layer.shadowRadius = 15.0
            viewImgBG.layer.masksToBounds = false
            viewImgBG.layer.cornerRadius = 30.0
            //viewImgBG.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var imgBackground:UIImageView!{
        didSet {
            
            imgBackground.image = UIImage(named: "forgot")
        }
    }

    @IBOutlet weak var lblText:UILabel!{
        didSet{
            lblText.text = """
                            Please enter your email address.
                            You will receive a link to create a new
                            password via email.
                            """
        }
    }
    
    @IBOutlet weak var txtEmail:UITextField!{
        didSet {
            
            Utils.txtUitextField(textField: txtEmail, placeholderName: "Email Address", setLeftPadding: 20)
            
            if let myImage = UIImage(systemName: "envelope"){
                txtEmail.withImage(direction: .Right, image: myImage, colorSeparator: UIColor.white, colorBorder: UIColor.black)
            }
    
            txtEmail.delegate = self
            
        }
    }
    
    @IBOutlet weak var btnSubmit:UIButton!{
        
        didSet{
            btnSubmit.layer.cornerRadius = 27.5
            btnSubmit.clipsToBounds = true
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnNavigationBack.addTarget(self, action: #selector(btnNavigationBackPress), for: .touchUpInside)
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = .white
        
    }
    @objc func btnNavigationBackPress(){
        self.navigationController?.popViewController(animated: true)
    }
}
