//
//  ImageService.swift
//  Crossmint
//
//  Created by Navpreet Kaur on 10/28/22.
//

import Foundation

class ImageService {
    func downloadImage(from url: String, image: @escaping (Data) -> Void)
    {
        guard let url = URL(string: url) else { return }
        
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            image(data)
        }
    }
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ())
    {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
