//
//  ImageView+AsyncLoad.swift
//  TechnicalTest
//
//  Created by compte temporaire on 11/04/2023.
//


import UIKit
import QuartzCore

fileprivate let imageCache = NSCache<NSString, UIImage>()
extension UIImageView {
    
    func loadImage(_ URLString: String, placeHolder: UIImage?) {
        
        image = placeHolder
        let imageServerUrl = URLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        if let cachedImage = imageCache.object(forKey: NSString(string: imageServerUrl)) {
            image = cachedImage
            return
        } else  if let url = URL(string: imageServerUrl) {
            URLSession.shared.dataTask(with: url, completionHandler: { [weak self] (data, response, error) in
                guard let self = self else { return }
                
                guard error == nil else {
                    debugPrint(error?.localizedDescription ?? "")
                    DispatchQueue.main.async {
                        self.image = placeHolder
                    }
                    return
                }
            
                DispatchQueue.main.async {
                    if let data = data,
                       let downloadedImage = UIImage(data: data) {
                            imageCache.setObject(downloadedImage, forKey: NSString(string: imageServerUrl))
                            self.image = downloadedImage
                    }
                }
            }).resume()
        }
    }
}
