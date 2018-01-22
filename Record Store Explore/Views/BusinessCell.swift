//
//  BusinessCell.swift
//  Record Store Explore
//
//  Created by Timo den Hartog on 15-01-18.
//  Copyright © 2018 Timo den Hartog. All rights reserved.
//

import UIKit
import YelpAPI

class BusinessCell: UITableViewCell {

    @IBOutlet weak var thumbImageView: UIImageView!
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var reviewsCountLabel: UILabel!
    
    @IBOutlet weak var adressLabel: UILabel!
        
    var business: YLPBusiness! {
        didSet {
            
            // Image retrieval (for lack of "setImageWithURL")
            
            let session = URLSession(configuration: .default)
            let URL_IMAGE = business.imageURL
            //creating a dataTask
            let getImageFromUrl = session.dataTask(with: (URL_IMAGE)!) { (data, response, error) in
                
                //if there is any error
                if let e = error {
                    //displaying the message
                    print("Error Occurred: \(e)")
                    
                } else {
                    //in case of now error, checking wheather the response is nil or not
                    if (response as? HTTPURLResponse) != nil {
                        
                        //checking if the response contains an image
                        if let imageData = data {
                            
                            //getting the image
                            let image = UIImage(data: imageData)
                            
                            //displaying the image
                            self.thumbImageView.image = image
                            
                        } else {
                            print("Image file is corrupted")
                        }
                    } else {
                        print("No response from server")
                    }
                }
            }
            
            //starting the download task
            getImageFromUrl.resume()
            
            
            ratingLabel.text = "\(String(business.rating)) Stars"
            nameLabel.text = business.name
            reviewsCountLabel.text = "\(business.reviewCount) Reviews"
            adressLabel.text = business.location.address.first
            _ = business.location.coordinate
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        thumbImageView.layer.cornerRadius = 6
        thumbImageView.clipsToBounds = true
        
        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
