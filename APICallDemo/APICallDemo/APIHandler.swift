//
//  APIHandler.swift
//  WindScribeDemo
//
//  Created by Nidhi Jariwala on 2021-06-03.
//

import Foundation
typealias CompletionBlock = (_ success: Bool, _ response: Any?) -> Void

class APIHandler{
    static let shared = APIHandler()
    
    func getServerData(completion: @escaping(CompletionBlock)) {
        guard let url = URL(string: Constants.serviceURL) else { return }
        let request = NSMutableURLRequest(url: url)
        let session = URLSession.shared
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            
            guard let data = data else { return }
            do {
                guard let json = (try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)) as? [String: Any] else {
                    print("Not containing JSON")
                    return
                }
                let serverData = ServerModel(json: json)
                
                completion(true, serverData)
            }
        }
        task.resume()
    }
}
