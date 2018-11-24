//
//  SignUpVC.swift
//  Footprint
//
//  Created by Abhinay on 22/08/18.
//  Copyright © 2018 ONS. All rights reserved.
//

import UIKit

enum SignUpCellType:Int{
    case Name = 0, Email, DOB, Password, ConfirmPassword
}

struct SignUpRecord {
    let placeHolder:String!
    var text:String!
}

class SignUpVC:UICollectionViewController, UICollectionViewDelegateFlowLayout
{
    //MARK:- Priavte Constant
    fileprivate let cellId = "RegisterCell"
    
    //MARK:- Priavte Vars
    fileprivate var dataSource = [SignUpRecord]()
    
    //MARK:- Widget
    fileprivate let headerImage:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = #imageLiteral(resourceName: "footprintHeader")
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    fileprivate let backButton:UIButton = {
        let backBtn = UIButton()
        backBtn.titleLabel?.font = UIFont(name: FootprintConstant.Font.BlackTie.FamilyName, size: 17)
        backBtn.setTitle("", for: .normal)
        return backBtn
    }()
    
    let footerButton:UIButton = {
        let btn = UIButton()
        btn.setTitle("REGISTER", for: .normal)
        btn.backgroundColor = FootprintConstant.Color.FootprintGreenColor
        return btn
    }()
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetting()
        pageAppearance()
    }
    
    //MARK:- Private Methods
    fileprivate func initialSetting()
    {
        view.addSubview(headerImage)
        view.addSubview(backButton)
        view.addSubview(footerButton)
        
        backButton.addTarget(self, action: #selector(didClickOnBack), for: .touchUpInside)
        footerButton.addTarget(self, action: #selector(didClickOnRegistration), for: .touchUpInside)
        
        setLayout()
        setData()
        
        collectionView?.register(RegisterCell.self, forCellWithReuseIdentifier: cellId)
        
       
    }
    fileprivate func pageAppearance(){
        collectionView?.backgroundColor = FootprintConstant.Color.FootprintBlueColor
    }
    
    fileprivate func setLayout()
    {
        headerImage.widthAnchor.constraint(equalTo: headerImage.heightAnchor, multiplier: 8/3, constant: 0).isActive = true
        headerImage.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 240/667, constant: 0).isActive = true
        headerImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        let topAnchor = self.statusBarHeight() + 48.0
        let backButtonLeadingAnchor = self.statusBarHeight() + 5.0
        
        view.addConstraint(visualFormat: "H:|[v0]|", forViews: collectionView!)
        view.addConstraint(visualFormat: "V:|-\(topAnchor)-[v0]-30-[v1]-5-[v2(50)]-20-|", forViews: headerImage, collectionView!, footerButton)
        
        view.addConstraint(visualFormat: "H:|-15-[v0(30)]|", forViews: backButton)
        view.addConstraint(visualFormat: "V:|-\(backButtonLeadingAnchor)-[v0(30)]|", forViews: backButton)
        
        view.addConstraint(visualFormat: "H:|-15-[v0]-15-|", forViews: footerButton)
    }
    
    fileprivate func setData(){
        dataSource.append(SignUpRecord(placeHolder: "Name", text: ""))
        dataSource.append(SignUpRecord(placeHolder: "Email", text: ""))
        dataSource.append(SignUpRecord(placeHolder: "DOB", text: ""))
        dataSource.append(SignUpRecord(placeHolder: "Password", text: ""))
        dataSource.append(SignUpRecord(placeHolder: "Confirm Password", text: ""))
    }
    
    fileprivate func refreshPage(){
        collectionView?.reloadData()
    }
    
    fileprivate func clearData()
    {
        dataSource.removeAll()
        setData()
        collectionView?.reloadData()
    }
    
    fileprivate func registrationProcess()
    {
        var dict = [String:String]()
        
        for index in 0..<dataSource.count
        {
            let cellType = SignUpCellType(rawValue: index)!
            
            switch cellType
            {
                case .Name:
                    dict["FirstName"] = dataSource[index].text
                case .Email:
                    dict["Email"] = dataSource[index].text
                case .DOB:
                    dict["Dob"] = dataSource[index].text
                case .Password:
                    dict["Password"] = dataSource[index].text
                case .ConfirmPassword:
                    dict["ConfirmPassword"] = dataSource[index].text
            }
            
        }
        print(dict)
        
        //Server process
        showLoadIndicator(title: "Processing...")
        LoginPageHelper.registerUser(userDict: dict) {[weak self] (status, responseCode, message, guid) in
            self?.hideLoadIndicator()
            
            if responseCode == FootprintConstant.APIResponseCode.RegistrationSuccess
            {
                if let userGuid = guid
                {
                    //Save record in local
                    let userRecord = UserRecord(userEmail: dict["Email"], userGUID: userGuid, userDOB: dict["Dob"])
                    UserRecordHelper.sharedInstance.userRecord = userRecord
                    UserRecordHelper.sharedInstance.isLogin = true
                    
                    self?.showOkAlert(title: FootprintConstant.Alert.Success, message: message, completionHandler: { (status) in
                        //Navigate to home page
                        self?.moveToStoryboard(name: FootprintConstant.Storyboard.Main)
                       // self?.present(LeftMenuNVC.instantiate(), animated: true, completion: nil)
                    })
                }else{
                    self?.showOkAlert(title: FootprintConstant.Alert.Ops, message: message, completionHandler: { (status) in
                        self?.clearData()
                    })
                }
                
               
            }else if responseCode == FootprintConstant.APIResponseCode.RegistrationError
            {
                self?.showOkAlert(title: FootprintConstant.Alert.Ops, message: message, completionHandler: { (status) in
                    self?.clearData()
                })
            }
        }
    }
    
    //MARK:- Action Methods
    @objc fileprivate func didClickOnBack(){
        navigationController?.popViewController(animated: true)
    }
    @objc fileprivate func didClickOnRegistration()
    {
        var invalidEntry = -1
        for index in 0..<dataSource.count{
            if dataSource[index].text == ""{
                invalidEntry = index
                break
            }
            
        }
        
        if invalidEntry != -1
        {
            var message:String?
            
            let cellType = SignUpCellType(rawValue: invalidEntry)!
            switch cellType
            {
                case .Name:
                    message = "Please fill the name"
                case .Email:
                    message = "Please fill the email"
                case .DOB:
                    message = "Please fill the dob"
                case .Password:
                    message = "Please fill the password"
                case .ConfirmPassword:
                    message = "Please fill the confirm password"
            }
            
            showAlert(title: FootprintConstant.Alert.Wait, message: message!)
        }
        else
        {
            
            let email = dataSource[SignUpCellType.Email.rawValue].text!
            if email.isValidEmail() == false{
                showAlert(title: FootprintConstant.Alert.Wait, message: "Email is not valid")
            }
            else
            {
                let password = dataSource[SignUpCellType.Password.rawValue].text
                let confirmPassword = dataSource[SignUpCellType.ConfirmPassword.rawValue].text
                
                
                if password != confirmPassword{
                    showAlert(title: FootprintConstant.Alert.Wait, message: "Password and confirm password do not match")
                }
                else{
                    registrationProcess()
                }
            }
            
            
            
        }
    }
    
    
    //MARK:- Collection DataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! RegisterCell
        cell.tag = indexPath.item
        cell.delegate = self
        cell.record = dataSource[indexPath.item]
        
        cell.cellType = SignUpCellType(rawValue: indexPath.item)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 54)
    }
    
    
}

extension SignUpVC
{
    static func instantiate() -> SignUpVC
    {
        let flowLayout = UICollectionViewFlowLayout()
        let vc = SignUpVC(collectionViewLayout: flowLayout)
        return vc
    }
}

extension SignUpVC:RegisterCellDelegate
{
    func didEndEditingForText(textTag:Int, text:String){
        dataSource[textTag].text = text
        refreshPage()
    }
}

protocol RegisterCellDelegate:class {
    func didEndEditingForText(textTag:Int, text:String)
}

//MARK:- UICollectionViewCell

class RegisterBaseCell:UICollectionViewCell
{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupView(){
        
    }
}

class RegisterCell: RegisterBaseCell
{
    private var datePicker:UIDatePicker?
    
    var record:SignUpRecord!{
        didSet{
            txt.placeholder = record.placeHolder
            txt.text = record.text
        }
    }
    
    var cellType:SignUpCellType!
    {
        didSet{
            txt.keyboardType = .default
            txt.isSecureTextEntry = false
            
            switch cellType
            {
            case .Name?:
                break
            case .Email?:
                txt.keyboardType = .emailAddress
                
            case .DOB?:
                if datePicker == nil{
                    datePicker = UIDatePicker()
                    datePicker?.datePickerMode = .date
                }
                txt.inputView = datePicker
                
            case .Password?, .ConfirmPassword?:
                txt.isSecureTextEntry = true
            
            case .none:
                break
            case .some(_):
                break
            }
        }
    }
    
    weak var delegate:RegisterCellDelegate?
    
    private let txt:UITextField = {
        let txt = UITextField()
        txt.borderStyle = .none
        txt.textColor = .darkGray
        return txt
    }()
    
    let containerView:UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    
    override func setupView()
    {
        addSubview(containerView)
        containerView.addSubview(txt)
        
        txt.delegate = self
        setLayout()
    }
    
    private func setLayout(){
        addConstraint(visualFormat: "H:|-15-[v0]-15-|", forViews: containerView)
        addConstraint(visualFormat: "V:|-5-[v0]-5-|", forViews: containerView)
        
        containerView.addConstraint(visualFormat: "H:|-15-[v0]|", forViews: txt)
        containerView.addConstraint(visualFormat: "V:|[v0]|", forViews: txt)
        
    }
}

extension RegisterCell:UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField){
        if datePicker != nil{
            if let date = datePicker?.date.stringInNormalFormat(){
                delegate?.didEndEditingForText(textTag: tag, text: "DOB: \(date)")
            }
            
        }else{
            delegate?.didEndEditingForText(textTag: tag, text: textField.text!)
        }
        
    }
}



