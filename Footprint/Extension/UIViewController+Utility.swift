//
//  UIViewController+MBProgressHud.swift
//  LiqudeHire
//
//  Created by Abhinay on 16/03/16.
//  Copyright © 2016 ONS. All rights reserved.
//

import UIKit
import MBProgressHUD
import LGSideMenuController

//MARK:- MBProgressHUD
extension UIViewController
{
    typealias AlertCompletionHandler = (_ okClicked:Bool) -> Void
    
    func showLoadIndicator(title text:String) {
        DispatchQueue.main.async {
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.label.text = text
        }
        
    }
    
    func showLoadIndicator(title text:String, subTitle subText:String) {
        DispatchQueue.main.async {
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.label.text = text
            hud.detailsLabel.text = subText
        }
        
    }
    
    
    func hideLoadIndicator(){
         DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }

    
    func showAlert(title titleText:String, message messageText:String)
    {
        let alert = UIAlertController (title:titleText, message: messageText, preferredStyle: .alert)
        let okAction = UIAlertAction (title: "OK", style: .cancel, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func showAlert(title alertTitle:String, message alertMessage:String, completionHandler:@escaping AlertCompletionHandler )
    {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            completionHandler(false)
        })
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            completionHandler(true)
        }
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showOkAlert(title alertTitle:String, message alertMessage:String, completionHandler:@escaping AlertCompletionHandler )
    {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
       
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            completionHandler(true)
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }


    
    //MARK:- Share
    func socialShare(sharingText: String?, sharingImage: UIImage?, sharingURL: URL?)
    {
        var sharingItems = [Any]()
        
        if let text = sharingText {
            sharingItems.append(text)
            
        }
        if let image = sharingImage {
            sharingItems.append(image)
        }
        if let url = sharingURL {
            sharingItems.append(url)
        }
        
        let activityViewController = UIActivityViewController(activityItems: sharingItems, applicationActivities: nil)
        activityViewController.excludedActivityTypes = [UIActivityType.copyToPasteboard,UIActivityType.airDrop,UIActivityType.addToReadingList,UIActivityType.assignToContact,UIActivityType.postToTencentWeibo,UIActivityType.postToVimeo,UIActivityType.print,UIActivityType.saveToCameraRoll,UIActivityType.postToWeibo]
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    
     func moveToStoryboard(name:String)
    {
        let window = UIApplication.shared.keyWindow!
        
        UIView.animate(withDuration: 0.05) {
            let vc = HomeViewController.instantiate()
            window.rootViewController = vc
        }
       
    }



    
    func statusBarHeight() -> CGFloat {
        return UIApplication.shared.statusBarFrame.size.height
    }
}


class Router {
    
    class func pushViewController<T: UIViewController>(withStoryboardID storyboardID: String, type: T.Type) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let window = (UIApplication.shared.delegate!.window!)! as UIWindow
        let mainVC = window.rootViewController as! LGSideMenuController
        let navi = mainVC.rootViewController as! UINavigationController
        mainVC.addChildViewController(navi)
        if let viewController =  storyboard.instantiateViewController(withIdentifier: storyboardID) as? T {
            navi.pushViewController(viewController, animated: true)
        }
    }
    
    class func pushViewController(viewControler: UIViewController) {
        let window = (UIApplication.shared.delegate!.window!)! as UIWindow
        let mainVC = window.rootViewController as! LGSideMenuController
        let navi = mainVC.rootViewController as! UINavigationController
        mainVC.addChildViewController(navi)
        navi.pushViewController(viewControler, animated: true)
    }
    
    class func showModalViewController(viewController: UIViewController, completion: (() -> Void)?) {
        let window = (UIApplication.shared.delegate!.window!)! as UIWindow
        let mainVC = window.rootViewController as! LGSideMenuController
        let navi = mainVC.rootViewController as! UINavigationController
        mainVC.addChildViewController(navi)
        viewController.modalPresentationStyle = .overFullScreen
        navi.present(viewController, animated: true, completion: completion)
    }
}
