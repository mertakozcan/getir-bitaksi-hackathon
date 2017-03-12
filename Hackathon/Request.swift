//
//  Request.swift
//  Hackathon
//
//  Created by Mert Aközcan on 10/03/2017.
//  Copyright © 2017 Mert Aközcan. All rights reserved.
//

import Foundation

class Request {
    
    enum Figure {
        case Circle(Int, Int, Int, String)
        case Rectangle(Int, Int, Int, Int, String)
    }
    
    var figures = [Figure]()
    
    func processRequest() {
        let semaphore = DispatchSemaphore(value: 0);
        var request = URLRequest(url: URL(string: "https://getir-bitaksi-hackathon.herokuapp.com/getElements")!)
        request.httpMethod = "POST"
        let postString = "email=mertakozcan@gmail.com&name=MertAkozcan&gsm=05365178244"
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("error=\(error)")
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("response = \(response)")
            }
        
            let jsonWithObjectRoot = try? JSONSerialization.jsonObject(with: data, options: [])
            
            if let dictionary = jsonWithObjectRoot as? [String: Any] {
                if let elements = dictionary["elements"] as? [[String: Any]] {
                    for object in elements {
                        if let type = object["type"] as? String {
                            if type == "circle" {
                                self.figures.append(Figure.Circle(
                                                           object["xPosition"] as! Int,
                                                           object["yPosition"] as! Int,
                                                           object["r"] as! Int,
                                                           object["color"] as! String))
                            } else if type == "rectangle" {
                                self.figures.append(Figure.Rectangle(
                                                              object["xPosition"] as! Int,
                                                              object["yPosition"] as! Int,
                                                              object["width"] as! Int,
                                                              object["height"] as! Int,
                                                              object["color"] as! String))
                            } else {
                                print("Unknown object")
                            }
                        }
                    }
                }
            }
            semaphore.signal()
        }
        task.resume()
        semaphore.wait()
    }
    
}
