//
//  UIImage+Cake.swift
//  Cake List
//
//  Created by Ray Hunter on 22/04/2019.
//  Copyright © 2019 Stewart Hart. All rights reserved.
//

import UIKit
import AVFoundation

//
//  I would normally use AlamoFire to load the image
//
extension UIImageView {
    func setUrlImage(url: URL){
        
        //
        //  Default policy is to cache
        //
        let request = URLRequest(url: url)
        let urlSession = URLSession.shared
        
        let targetBounds = self.bounds
        
        urlSession.dataTask(with: request) { [weak self] (data, response, error) in
            
            guard let data = data,
            let image = UIImage(data: data) else {
                print("Failed to load image data at url: \(url), error: \(String(describing: error))")
                if let defaultImage = UIImage(named: "NoImageAvailable"){
                    self?.resizeAndShow(image: defaultImage, in: targetBounds)
                }
                
                return
            }
            
            self?.resizeAndShow(image: image, in: targetBounds)
        }.resume()
    }
    
    
    private func resizeAndShow(image: UIImage, in targetBounds: CGRect){
        assert(Thread.current != Thread.main)
        
        //
        //  Resize: fill maintaining aspect ratio
        //
        let aspectWidth = targetBounds.size.width / image.size.width
        let aspectHeight = targetBounds.size.height / image.size.height
        let aspectRatio = max( aspectWidth, aspectHeight );
        
        var scaledImageRect = CGRect()
        scaledImageRect.size.width = image.size.width * aspectRatio;
        scaledImageRect.size.height = image.size.height * aspectRatio;
        scaledImageRect.origin.x = (targetBounds.size.width - scaledImageRect.size.width) / 2.0
        scaledImageRect.origin.y = (targetBounds.size.height - scaledImageRect.size.height) / 2.0
        
        UIGraphicsBeginImageContext(targetBounds.size)
        image.draw(in: scaledImageRect)
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        DispatchQueue.main.async {
            self.image = resizedImage
        }
    }
    
}
