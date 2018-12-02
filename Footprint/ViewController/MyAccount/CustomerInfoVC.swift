//
//  CustomerInfoVC.swift
//  Footprint
//
//  Created by Abhinay Maurya on 14/12/16.
//  Copyright © 2016 ONS. All rights reserved.
//

import UIKit

class CustomerInfoVC: HeaderVC
{
    //MARK:- IBOutlet
    @IBOutlet fileprivate weak var txtFirstName: UITextField!
    @IBOutlet fileprivate weak var txtLastName: UITextField!
    @IBOutlet fileprivate weak var txtDob: UITextField!
    @IBOutlet fileprivate weak var txtEmail: UITextField!
    @IBOutlet fileprivate weak var txtCompany: UITextField!
    @IBOutlet fileprivate weak var btnMale: UIButton!
    @IBOutlet fileprivate weak var btnFemale: UIButton!
    @IBOutlet fileprivate weak var btnNewsLetter: UIButton!
    
    //MARK:- Private Var
    fileprivate let datePicker = UIDatePicker()
    fileprivate var isNewsLetterEnabled = false
    fileprivate var isMale = true
    fileprivate var date:String!
    
    //MARK:- View Life Cycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.initialSetting()
        self.pageAppearance()
        self.loadInfo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Private Methods
    fileprivate func initialSetting()
    {
        pageTitle = "CUSTOMER INFO"
        
        txtFirstName.delegate = self
        txtLastName.delegate = self
        txtEmail.delegate = self
        txtCompany.delegate = self
        
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(CustomerInfoVC.datePicked(sender:)), for: .valueChanged)
        txtDob.inputView = datePicker
        
        let userRecord = UserRecordHelper.sharedInstance.userRecord
        txtEmail.text = userRecord?.userEmail
    }
    
    fileprivate func pageAppearance(){
        btnNewsLetter.drawBorder(cornerRadius: 3.0, borderWidth: 1.0, borderColor: WhiteColor, maskToBound: true)
        btnMale.drawBorder(cornerRadius: 3.0, borderWidth: 1.0, borderColor: WhiteColor, maskToBound: true)
        btnFemale.drawBorder(cornerRadius: 3.0, borderWidth: 1.0, borderColor: WhiteColor, maskToBound: true)
    }
    
    fileprivate func setup(customerInfo:CustomerInfo?)
    {
        if let dataSource = customerInfo
        {
            txtEmail.text = dataSource.email
            txtFirstName.text = dataSource.firstName
            txtLastName.text = dataSource.lastName
            txtCompany.text = dataSource.company
            
            if let birthDate = dataSource.dateOfBirthDay{
               txtDob.text = "\(birthDate)-\(dataSource.dateOfBirthMonth!)-\(dataSource.dateOfBirthYear!)"
            }
            
            isNewsLetterEnabled = dataSource.newsletterEnabled
            isMale = dataSource.gender == "female" ? false : true
           
            isMale ? maleAction() : femaleAction()
            newsLetterAction()
        }
    }
    
    fileprivate func loadInfo()
    {
        self.showLoadIndicator(title: "Loading...")
        CustomerInfoHelper.fetchCustomerInfo {[weak self] (status, record) in
            if status{
                self?.setup(customerInfo: record)
            }else{
                self?.showAlert(title: FootprintConstant.Alert.Error, message: "Something went wrong!!")
            }
            self?.hideLoadIndicator()
        }
    }
    
    fileprivate func newsLetterAction()
    {
        if isNewsLetterEnabled{
            btnNewsLetter.setTitle(FootprintConstant.Font.BlackTie.Text.Check, for: .normal)
        }else{
            btnNewsLetter.setTitle("", for: .normal)
        }
    }
    
    @objc fileprivate func datePicked (sender:UIDatePicker){
        date = sender.date.stringInServerFormat()
        txtDob.text = date
    }
    
    
    fileprivate func saveRecord()
    {
        let email = txtEmail.text!
        let fn = txtFirstName.text!
        let ln = txtLastName.text!
        let company = txtCompany.text!
        let gender = isMale ? "male" : "female"
        
        let dateOfBirth = txtDob.text!
        let dayMonthYear = dateOfBirth.getDayMonthYear()
        
        let day   = dayMonthYear.0
        let month = dayMonthYear.1
        let year  = dayMonthYear.2
        
        self.showLoadIndicator(title: "Updating...")
        
        CustomerInfoHelper.updateUserInfo(email: email, firstName: fn, lastName: ln, gender: gender, dob:dateOfBirth, dateOfBirthDay: day, dateOfBirthMonth: month, dateOfBirthYear: year, company: company, complitionHandler: {[weak self] (status, message) in
            
            if status{
                self?.showAlert(title: FootprintConstant.Alert.Success, message: message)
            }else{
                self?.showAlert(title: FootprintConstant.Alert.Success, message: message)
            }
            
            self?.hideLoadIndicator()
        })
    }
    
    

    //MARK:- IBAction
    @IBAction func saveAction()
    {
        if txtDob.text == "" || txtEmail.text == "" || txtFirstName.text == "" || txtLastName.text == "" || txtCompany.text == ""{
            self.showAlert(title: FootprintConstant.Alert.Warning, message: "Kindly fill all the fields")
        }else{
            saveRecord()
        }
        
    }
    
    @IBAction func maleAction()
    {
        btnMale.setTitle(FootprintConstant.Font.BlackTie.Text.Check, for: .normal)
        btnFemale.setTitle("", for: .normal)
        isMale = true
    }

    @IBAction func femaleAction() {
        btnFemale.setTitle(FootprintConstant.Font.BlackTie.Text.Check, for: .normal)
        btnMale.setTitle("", for: .normal)
        isMale = false
    }
    @IBAction func newsLetterAction(sender:UIButton){
        isNewsLetterEnabled = !isNewsLetterEnabled
        newsLetterAction()
    }
}

/* ---------------------------------- Extension ----------------------------------------- */
//MARK:- Extension
extension CustomerInfoVC
{
    struct Storyboard{
        static let ControllerID = String(describing: CustomerInfoVC.self)
        static let SegueID = "CustomerInfoSegue"
    }
    
    //MARK:- Static Metod
    static func instantiate() -> CustomerInfoVC{
        let storyboard = UIStoryboard(name: FootprintConstant.Storyboard.Main, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: Storyboard.ControllerID) as! CustomerInfoVC
    }
}

extension CustomerInfoVC:UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


