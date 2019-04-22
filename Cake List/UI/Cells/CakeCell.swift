//
//  CakeCellTableViewCell.swift
//  Cake List
//
//  Created by Ray Hunter on 22/04/2019.
//  Copyright © 2019 Stewart Hart. All rights reserved.
//

import UIKit

class CakeCell: UITableViewCell {
    
    @IBOutlet var cakeImageView: UIImageView?
    @IBOutlet var titleLabel: UILabel?
    @IBOutlet var descriptionLabel: UILabel?

    @objc
    var cake: Cake?{
        didSet{
            titleLabel?.text = cake?.title;
            descriptionLabel?.text = cake?.desc;
            
            cakeImageView?.image = nil
            if let cakeImageUrlString = cake?.image,
               let cakeImageUrl = URL(string: cakeImageUrlString){
                cakeImageView?.setUrlImage(url: cakeImageUrl)
            }
        }
    }
    
}
