//
//  SignUpVC.swift
//  Footprint
//
//  Created by Abhinay on 22/08/18.
//  Copyright © 2018 ONS. All rights reserved.
//

import UIKit

enum ForgetPasswordCellType:Int{
    case Email
}

struct ForgetPasswordRecord {
    let placeHolder:String!
    var text:String!
}

class ForgotPasswordVC:UICollectionViewController, UICollectionViewDelegateFlowLayout
{
    //MARK:- Priavte Constant
    fileprivate let cellId = "ForgetPasswordCell"
    
    //MARK:- Priavte Vars
    fileprivate var dataSource = [ForgetPasswordRecord]()
    
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
        btn.setTitle("GO", for: .normal)
        btn.backgroundColor = FootprintConstant.Color.FootprintGreenColor
        return btn
    }()
    
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
        footerButton.addTarget(self, action: #selector(didClickOnGo), for: .touchUpInside)
        
        setLayout()
        setData()
        
        collectionView?.register(ForgetPassCell.self, forCellWithReuseIdentifier: cellId)
        
        
    }
    fileprivate func pageAppearance(){
        collectionView?.backgroundColor = FootprintConstant.Color.FootprintBlueColor
        self.view.backgroundColor = FootprintConstant.Color.FootprintBlueColor

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
        dataSource.append(ForgetPasswordRecord(placeHolder: "Email", text: ""))
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
    
    fileprivate func forgetPasswordProcess()
    {
        var dict = [String:String]()
        
        for index in 0..<dataSource.count
        {
            let cellType = ForgetPasswordCellType(rawValue: index)!
            
            switch cellType{
                case .Email:
                    dict["email"] = dataSource[index].text
            }
            
        }
        
        //Server process
        showLoadIndicator(title: "Processing...")
        LoginPageHelper.recoverPassword(emailDict: dict) {[weak self] (status, responseCode, message) in
            self?.hideLoadIndicator()
            
            if responseCode == 1
            {
                self?.showOkAlert(title: FootprintConstant.Alert.Ops, message: message, completionHandler: { (status) in
                    self?.clearData()
                })
            }else{
                self?.showOkAlert(title: FootprintConstant.Alert.Success, message: message, completionHandler: { (status) in
                    //Navigate to back page
                    self?.navigationController?.popViewController(animated: true)
                })
                    
            }
        }
    }
    
    //MARK:- Action Methods
    @objc fileprivate func didClickOnBack(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc fileprivate func didClickOnGo()
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
            
            let cellType = ForgetPasswordCellType(rawValue: invalidEntry)!
            switch cellType
            {
            case .Email:
                message = "Please fill the email"
            }
            
            showAlert(title: FootprintConstant.Alert.Wait, message: message!)
        }
        else
        {
            
            let email = dataSource[ForgetPasswordCellType.Email.rawValue].text!
            if email.isValidEmail() == false{
                showAlert(title: FootprintConstant.Alert.Wait, message: "Email is not valid")
            }else{
                forgetPasswordProcess()
            }
        }
    }
    
    
    //MARK:- Collection DataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ForgetPassCell
        cell.tag = indexPath.item
        cell.delegate = self
        cell.record = dataSource[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 54)
    }
    
}

extension ForgotPasswordVC
{
    static func instantiate() -> ForgotPasswordVC
    {
        let flowLayout = UICollectionViewFlowLayout()
        let vc = ForgotPasswordVC(collectionViewLayout: flowLayout)
        return vc
    }
}

extension ForgotPasswordVC:ForgetPassCellDelegate
{
    func didEndEditingForText(textTag:Int, text:String){
        dataSource[textTag].text = text
        refreshPage()
    }
}

protocol ForgetPassCellDelegate:class {
    func didEndEditingForText(textTag:Int, text:String)
}

//MARK:- UICollectionViewCell

class ForgetPassBaseCell:UICollectionViewCell
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

class ForgetPassCell: ForgetPassBaseCell
{
    var record:ForgetPasswordRecord!{
        didSet{
            txt.placeholder = record.placeHolder
            txt.text = record.text
        }
    }
    
    weak var delegate:ForgetPassCellDelegate?
    
    private let txt:UITextField = {
        let txt = UITextField()
        txt.borderStyle = .none
        txt.textColor = .darkGray
        txt.keyboardType = .emailAddress
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

extension ForgetPassCell:UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField){
        delegate?.didEndEditingForText(textTag: tag, text: textField.text!)
    }
}



