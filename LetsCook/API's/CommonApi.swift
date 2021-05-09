//
//  CommonApi.swift
//  LetsCook
//
//  Created by Anu Agrawal on 5/9/21.
//

import Foundation

class CommonApi {
    
    
   static func callPostApi(url:String,completionHandler:@escaping(([[String:Any]]) -> Void)){
        let session = URLSession.shared
        let url = URL(string: url)!
        let task = session.dataTask(with: url) { data, response, error in

            if error != nil || data == nil {
                print("Client error!")
                return
            }

            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
            }


            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:Any]
                if let listOfRecipe = json?["results"] as? [[String:Any]]{
                    completionHandler(listOfRecipe)
                    //print(self.recipe)
                }
               
            } catch {
                print("JSON error: \(error.localizedDescription)")
            }
        }

        task.resume()
        
    }
    
    
}
