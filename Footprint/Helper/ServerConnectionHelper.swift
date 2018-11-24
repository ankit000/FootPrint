//
//  ServerConnectionHelper.swift
//  Footprint
//
//  Created by Abhinay on 29/08/18.
//  Copyright © 2018 ONS. All rights reserved.
//

import Foundation

final class ServerConnectionHelper
{
    typealias PostRequestCompletionHandler = (_ success:Bool, _ json:[String:Any]?) -> ()
    
    static func getPostString(params:[String:Any]) -> String
    {
        var data = [String]()
        for(key, value) in params
        {
            data.append(key + "=\(value)")
        }
        return data.map { String($0) }.joined(separator: "&")
    }
    
    static func postConnectionWithUrl(urlString:String, paramas parameters:[String:Any], handler:@escaping PostRequestCompletionHandler)
    {
        //Url
        guard let serviceUrl = URL(string: urlString) else { return }
        
        //Request
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        
        //Http Body
        let postString = getPostString(params: parameters)
        request.httpBody = postString.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error != nil{
                handler(false, nil)
            }else{
                if let data = data {
                    DispatchQueue.main.async {
                        do {
                            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
                            {
                                handler(true, json)
                            }else{
                                handler(false, nil)
                            }
                            
                        }catch {
                            handler(false, nil)
                        }
                    }
                }
            }
            
        }.resume()
    }
}
