//
//  Constant.swift
//  Footprint
//
//  Created by Abhinay Maurya on 03/10/16.
//  Copyright © 2016 ONS. All rights reserved.
//

import Foundation
import UIKit

struct FootprintConstant
{
    struct Storyboard {
        static let Main = "Main"
        static let Login = "Login"
        static let Product = "Product"
        static let ShopTheLook = "ShopTheLook"
        static let MyAccount = "MyAccount"
        static let Order = "Order"
        static let Blog = "Blog"
        static let Cart = "Cart"
    }
    
    struct Screen {
        static let Size = UIScreen.main.bounds.size
        static let Frame = UIScreen.main.bounds
    }
    
    struct Color {
        static let FootprintBlueColor = UIColor(red: 5.0/255.0, green: 28.0/255.0, blue: 59.0/255.0, alpha: 1.0)
        static let FootprintGreenColor = UIColor(red: 139.0/255.0, green: 164.0/255.0, blue: 167.0/255.0, alpha: 1.0)
    }
    
    struct Animation {
        static let Duration = 0.33
    }
    
    struct CornerRadius {
        static let Default:CGFloat = 3.0
    }
    
    struct Font
    {
        struct BlackTie
        {
            static let FamilyName = "Black Tie"
            
            static let Regular = "BlackTie-Regular"
            static let Light   = "BlackTie-Light"
            static let Solid   = "BlackTie-Solid"
            
            struct Text {
                static let RadioChecked   = ""
                static let RadioUnChecked = ""
                static let Camera         = ""
                static let Home           = ""
                static let Category       = ""
                static let Map            = ""
                static let Comments       = ""
                static let User           = ""
                static let Recycle        = ""
                static let Setting        = ""
                static let Star           = ""
                static let Back           = ""
                static let Search         = ""
                static let ShoppingCart   = ""
                static let FourSquare     = ""
                static let SixSquare      = ""
                static let Flask          = ""
                static let Menu           = ""
                static let Square         = ""
                static let Share          = ""
                static let Play           = ""
                static let ThreeLine      = ""
                static let Check          = ""
                static let downArrow      = ""
                static let upArrow        = ""
            }
        }
        
        struct Montserrat {
            static let FamilyName = "Montserrat"
            
            static let Regular = "Montserrat-Regular"
            static let Solid   = "Montserrat-Solid"
        }
        
        struct AbrilFatface {
            static let FamilyName = "Abril Fatface"
        }
    }
    
    
    struct Alert {
        static let Warning = "Alert!!"
        static let Error = "Error!!"
        static let Success = "Success!!"
        static let Ops = "Ooops!!"
        static let Wait = "Wait!!"
        static let SWR = "Something went wrong"
    }
    
    struct Social
    {
        static let LinkedInAppID = "4866475"
        static let FBAppID = "1697465250582600"
    }
    
    struct API {
        //static let BaseAPI      = "http://gstextile.pk/"
        static let BaseAPI        = "https://www.gomobishop.com/Mservices/"
        static let Login          = BaseAPI + "customer/LoginUser"
        static let ForgotPassword = BaseAPI + "customer/RecoverPassword"
        static let Registration   = BaseAPI + "customer/RegisterUser"
        static let FBRegistration = BaseAPI + "customer/LoginFacebookUser"
        static let Dashboard      = BaseAPI + "catalog/GetAllCategories"
        static let TopMenu        = BaseAPI + "Catalogx/TopMenu"
        static let SubCategory    = BaseAPI + "Catalogx/Category?CategoryId="
        static let UpdateUserInfo = BaseAPI + "Customerx/info"
        static let ChangePassword = BaseAPI + "Customerx/RecoverPassword?email="
        static let CustomerInfo   = BaseAPI + "Customerx/info"
        static let ProductInfo    = BaseAPI + "Productx/ProductDetailsWithRelatedProducts?productId="
        static let BlogList       = BaseAPI + "blog/list"
        static let RewardPoint    = BaseAPI + "Customerx/GetRewardPoints"
        static let AddProductInCart = BaseAPI + "ShoppingCart/AddProductToCart_Details"
        static let ShoppingCart   = BaseAPI + "ShoppingCartx/ShopCart"
        static let RemoveCartItem = BaseAPI + "ShoppingCartx/RemoveCartProduct"
        static let UpdateShoppingCartProduct   = BaseAPI + "ShoppingCart/UpdateCartProduct"
        static let CustomerOrders = BaseAPI + "order/CustomerOrders"
        static let OrderDetail    = BaseAPI + "/customerorder/details?orderid="
        static let ColorInfo      = "http://stage.growonlinepk.com/content/colors.json"
        static let GetAllDetailsForCheckOut = BaseAPI +  "SerCheckout/GetAllDetailsForCheckOut"
        static let AddNewShipLocation = BaseAPI +  "SerCheckout/OpcSaveShippingAndBilling"
        static let OrdersTotal    = BaseAPI + "ShoppingCart/OrderTotals"
        static let ConfirmCheckout = BaseAPI + "SerCheckout/ConfirmOrder"
        static let MyWishlist     = BaseAPI + "ShoppingCartx/Wishlist"
        static let GetActiveGiftCard     = BaseAPI + "Productx/GetActiveGiftCard"
        static let SendGiftCard   = BaseAPI + "AddtoCart_Details"
    }
    
    struct APIResponseCode
    {
        static let LoginSuccess = 100
        static let RegistrationSuccess = 102
        static let FBSuccess = 100
        static let RegistrationError = 109
        
    }
    
    struct AlertMessage {
        static let NotValidEmail = "Please enter valid email"
       
    }

}

let BlackColor = UIColor.black
let WhiteColor = UIColor.white
let ClearColor = UIColor.clear
let DarkGray   = UIColor.darkGray
let Gray       = UIColor.gray
let LightGray  = UIColor.lightGray

/*font-family: 'Montserrat', sans-serif;
font-family: 'Abril Fatface', cursive;*/
