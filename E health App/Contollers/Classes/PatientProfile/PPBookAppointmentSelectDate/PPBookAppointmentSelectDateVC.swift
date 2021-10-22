//
//  PPBookAppointmentSelectDateVC.swift
//  E health App
//
//  Created by Ranjan on 07/09/21.
//

import UIKit
import FSCalendar

import Alamofire
import SDWebImage

class PPBookAppointmentSelectDateVC: UIViewController, FSCalendarDelegate, FSCalendarDataSource {
    
    var fetchHospitalDataForBooking:NSDictionary!
    var fetchDoctorDataForBooking:NSDictionary!
    
    @IBOutlet weak var viewNavigationbar:UIView!
    @IBOutlet weak var btnNavigationBack: UIButton!
    @IBOutlet weak var lblNavationbar:UILabel!{
        didSet {
            
            lblNavationbar.text = "APPOINTMENTS"
        }
    }
    
    @IBOutlet weak var calendar:FSCalendar!
    @IBOutlet weak var btnConfirmAppointments:UIButton!
    @IBOutlet weak var lblSelectedDate:UILabel!
    @IBOutlet weak var lblSelectedDoctor:UILabel!

    var strSelectedDate:String! = "0"
    
    
    var strHitDirect:String!
    
    
    @IBOutlet weak var viewDoctorBG:UIView! {
        didSet {
            viewDoctorBG.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            viewDoctorBG.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            viewDoctorBG.layer.shadowOpacity = 1.0
            viewDoctorBG.layer.shadowRadius = 15.0
            viewDoctorBG.layer.masksToBounds = false
            viewDoctorBG.layer.cornerRadius = 15
            viewDoctorBG.backgroundColor = .white
        }
    }
    
    @IBOutlet weak var imgDoctorProfile:UIImageView! {
        didSet {
            imgDoctorProfile.layer.cornerRadius = 50
            imgDoctorProfile.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var lblDoctorName:UILabel! {
        didSet {
            lblDoctorName.textColor = .black
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        calendar.delegate = self
        calendar.dataSource = self
        lblSelectedDate.text = "Please select date"
        lblSelectedDoctor.text = strDoc
        btnConfirmAppointments.addTarget(self, action: #selector(btnConfirmAppointmentsPress), for: .touchUpInside)
        
        self.btnNavigationBack.addTarget(self, action: #selector(btnNavigationBackMethod), for: .touchUpInside)
        // print(self.fetchHospitalDataForBooking as Any)
          // print(self.fetchDoctorDataForBooking as Any)
        // fullName
        
        // print(self.fetchDoctorDataForBooking as Any)
        if self.strHitDirect == "yes" {
            
            self.lblDoctorName.text = (self.fetchHospitalDataForBooking["fullName"] as! String)
            
            self.imgDoctorProfile.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            self.imgDoctorProfile.sd_setImage(with: URL(string: (self.fetchHospitalDataForBooking["image"] as! String)), placeholderImage: UIImage(named: "1024"))
            
        } else {
            
            self.lblDoctorName.text = (self.fetchDoctorDataForBooking["fullName"] as! String)
            
            self.imgDoctorProfile.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            self.imgDoctorProfile.sd_setImage(with: URL(string: (self.fetchDoctorDataForBooking["image"] as! String)), placeholderImage: UIImage(named: "1024"))
            
        }
        
        
        
    }

    @objc func btnNavigationBackMethod() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let foramtter = DateFormatter()
        foramtter.dateFormat = "EEE dd-MM-yyyy"
        let date = foramtter.string(from: date)
        lblSelectedDate.text = "Selected Date: " + date
        print("\(date)")
        
        self.strSelectedDate = "\(date)"
        
    }
    
    func minimumDate(for calendar: FSCalendar) -> Date {
           return Date()
    }
    
    //Set maximum Date
    func maximumDate(for calendar: FSCalendar) -> Date {
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "dd-MM-yyyy"
          return dateFormatter.date(from: "01-01-2050") ?? Date()
    }

    
    @objc func btnConfirmAppointmentsPress(){
        
        
    
        self.validationBeforeBookAnAppoitnment()
        
    }
    
    @objc func validationBeforeBookAnAppoitnment() {
        
        if self.strSelectedDate == "0" {
            
            let alert = UIAlertController(title: "Alert", message: "Please select Date", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            self.present(alert, animated: true)
            
        } else {
            self.bookAndAppointment()
        }
        
    }
    
    // MARK:- APPOINTMENT BOOK -
    @objc func bookAndAppointment() {
        ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Booking in progress...")
        
        self.view.endEditing(true)
        
        if let person = UserDefaults.standard.value(forKey: "keyLoginFullData") as? [String:Any] {
            let x : Int = (person["userId"] as! Int)
            let myString = String(x)
            
            
            
            
            
            if self.strHitDirect == "yes" {
                
                let x2 : Int = (self.fetchHospitalDataForBooking["userId"] as! Int)
                let myString2 = String(x2)
                
                
                
                let params = Patient_Book_Appoitment(action: "addappointment",
                                                     userId: String(myString),
                                                     hospitalId: String(""),
                                                     doctorId: String(myString2),
                                                     Adate: String(self.strSelectedDate),
                                                     ATime: "")
                
                print(params as Any)
                
                AF.request(APPLICATION_BASE_URL,
                           method: .post,
                           parameters: params,
                           encoder: JSONParameterEncoder.default).responseJSON { response in
                            // debugPrint(response.result)
                            
                            switch response.result {
                            case let .success(value):
                                
                                let JSON = value as! NSDictionary
                                print(JSON as Any)
                                
                                var strSuccess : String!
                                strSuccess = JSON["status"]as Any as? String
                                
                                
                                // var strSuccess2 : String!
                                // strSuccess2 = JSON["msg"]as Any as? String
                                
                                let x21 : Int = (JSON["appointmentId"] as! Int)
                                let myString21 = String(x21)
                                
                                if strSuccess == String("success") {
                                    print("yes")
                                    
                                    ERProgressHud.sharedInstance.hide()
                                    
                                    let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PPBookingInformationVC") as? PPBookingInformationVC
                                    push!.strAppointmentId = String(myString21)
                                    self.navigationController?.pushViewController(push!, animated: true)
                                    
                                    /*var strSuccess2 : String!
                                     strSuccess2 = JSON["msg"]as Any as? String
                                     
                                     let alert = UIAlertController(title: String(strSuccess).uppercased(), message: String(strSuccess2), preferredStyle: .alert)
                                     alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
                                     action in
                                     
                                     let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PPBookingInformationVC") as? PPBookingInformationVC
                                     push!.strAppointmentId = String(myString21)
                                     self.navigationController?.pushViewController(push!, animated: true)
                                     
                                     
                                     }))
                                     self.present(alert, animated: true)*/
                                    
                                } else {
                                    print("no")
                                    ERProgressHud.sharedInstance.hide()
                                    
                                    var strSuccess2 : String!
                                    strSuccess2 = JSON["msg"]as Any as? String
                                    
                                    let alert = UIAlertController(title: String(strSuccess).uppercased(), message: String(strSuccess2), preferredStyle: .alert)
                                    
                                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                                    
                                    self.present(alert, animated: true)
                                    
                                }
                                
                            case let .failure(error):
                                print(error)
                                ERProgressHud.sharedInstance.hide()
                                
                            // Utils.showAlert(alerttitle: SERVER_ISSUE_TITLE, alertmessage: SERVER_ISSUE_MESSAGE, ButtonTitle: "Ok", viewController: self)
                            }
                           }
                
                
            } else {
                
                
                let x2 : Int = (self.fetchHospitalDataForBooking["userId"] as! Int)
                let myString2 = String(x2)
                
                let x3 : Int = (self.fetchDoctorDataForBooking["userId"] as! Int)
                let myString3 = String(x3)
                
                let params = Patient_Book_Appoitment(action: "addappointment",
                                                     userId: String(myString),
                                                     hospitalId: String(myString2),
                                                     doctorId: String(myString3),
                                                     Adate: String(self.strSelectedDate),
                                                     ATime: "")
                
                print(params as Any)
                
                AF.request(APPLICATION_BASE_URL,
                           method: .post,
                           parameters: params,
                           encoder: JSONParameterEncoder.default).responseJSON { response in
                            // debugPrint(response.result)
                            
                            switch response.result {
                            case let .success(value):
                                
                                let JSON = value as! NSDictionary
                                print(JSON as Any)
                                
                                var strSuccess : String!
                                strSuccess = JSON["status"]as Any as? String
                                
                                
                                // var strSuccess2 : String!
                                // strSuccess2 = JSON["msg"]as Any as? String
                                
                                let x21 : Int = (JSON["appointmentId"] as! Int)
                                let myString21 = String(x21)
                                
                                if strSuccess == String("success") {
                                    print("yes")
                                    
                                    ERProgressHud.sharedInstance.hide()
                                    
                                    let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PPBookingInformationVC") as? PPBookingInformationVC
                                    push!.strAppointmentId = String(myString21)
                                    self.navigationController?.pushViewController(push!, animated: true)
                                    
                                    /*var strSuccess2 : String!
                                     strSuccess2 = JSON["msg"]as Any as? String
                                     
                                     let alert = UIAlertController(title: String(strSuccess).uppercased(), message: String(strSuccess2), preferredStyle: .alert)
                                     alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
                                     action in
                                     
                                     let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PPBookingInformationVC") as? PPBookingInformationVC
                                     push!.strAppointmentId = String(myString21)
                                     self.navigationController?.pushViewController(push!, animated: true)
                                     
                                     
                                     }))
                                     self.present(alert, animated: true)*/
                                    
                                } else {
                                    print("no")
                                    ERProgressHud.sharedInstance.hide()
                                    
                                    var strSuccess2 : String!
                                    strSuccess2 = JSON["msg"]as Any as? String
                                    
                                    let alert = UIAlertController(title: String(strSuccess).uppercased(), message: String(strSuccess2), preferredStyle: .alert)
                                    
                                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                                    
                                    self.present(alert, animated: true)
                                    
                                }
                                
                            case let .failure(error):
                                print(error)
                                ERProgressHud.sharedInstance.hide()
                                
                            // Utils.showAlert(alerttitle: SERVER_ISSUE_TITLE, alertmessage: SERVER_ISSUE_MESSAGE, ButtonTitle: "Ok", viewController: self)
                            }
                           }
                
            }
            
            
            
            
            
            
            
            
            
            
        }
    }
    
}
