//
//  ImageClient.swift
//  DemoCollectionView
//
//  Created by Test User 1 on 19/04/18.
//  Copyright © 2018 Capgemini. All rights reserved.
//

import UIKit

class ImageClient: NSObject {
    
    func fetchImage(completion: @escaping ([Image]?) -> ()) {
        //Fetching Data
        var images:[Image]?
        let urlString = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
        let urlRequest = URLRequest(url: URL(string: urlString)!)
        
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // make the request
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            // check for any errors
            guard error == nil else {
                print("error calling GET on /todos/1")
                print(error)
                return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            
            let responseStrInISOLatin = String(data: responseData, encoding: String.Encoding.isoLatin1)
            
            guard let modifiedDataInUTF8Format = responseStrInISOLatin?.data(using: String.Encoding.utf8) else {
                return
            }
            // parse the result as JSON, since that's what the API provides
            do {
                let metaDict = try JSONSerialization.jsonObject(with: modifiedDataInUTF8Format)
                
                images = self.parseUrlResponse(jsonResponse: metaDict as! NSDictionary)
                completion(images)
    
                
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
        }
        
        task.resume()
        
    }
    
    
    func parseUrlResponse(jsonResponse:NSDictionary) ->  [Image] {
        var resultModel = [Image]()
        let array = jsonResponse.value(forKey: "rows") as! NSArray
        print(array)
        for(_,element) in array.enumerated(){
            let model = Image()
            let modelDict = element as! NSDictionary
            if let imageDescription = modelDict["description"] as? String {
                model.titleDesc = imageDescription
            }
            if let imageRefrence = modelDict["imageHref"] as? String {
                model.imageURL = imageRefrence
            }
            if let title = modelDict["title"] as? String {
                model.imageTitle = title
            }
            resultModel.append(model)
        }
        return resultModel
    }
}


