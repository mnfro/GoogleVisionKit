//
//  VisionClient.swift
//  GoogleVisionKit
//
//  Created by mnfro on 05/2020.
//  Copyright © 2020 Manfredi Schiera (@mnfro). All rights reserved.
//

import Cocoa

protocol VisionClientRequest {
    
    var apiKey: String { get set }
    func getVisionData( _ base64image: String, completion: @escaping (Data?) -> ())
}

class VisionClient: VisionClientRequest {
    
    let session = URLSession(configuration: .default)
    var apiKey: String = "API_KEY_GOES_HERE"  // <-- CHANGE THIS
    
    func getVisionData(_ base64image: String, completion: @escaping (Data?) -> ()) {
        
        let requestJson: [String: Any] = [
            "requests" : [
                "image" : [ "content": base64image ],
                "features" : [ "type" : "DOCUMENT_TEXT_DETECTION" ]
            ]
        ]
        
        let data = try! JSONSerialization.data(withJSONObject: requestJson, options: .prettyPrinted)
        
        let url = URL(string: "https://vision.googleapis.com/v1/images:annotate?key=\(apiKey)")
        var request = URLRequest(url: url!)
        request.httpBody = data
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        session.dataTask(with: request) { (data, response, error) in
            
           guard let data = data,                               // check for Data
                let response = response as? HTTPURLResponse,    // check for HTTP response
                (200 ..< 300) ~= response.statusCode,           // check for valid Status Code
                error == nil else {                             // check for no errors
                    completion(nil)
                    return
            }
            
            completion(data)
            
        }.resume()
    }
    
    
}
