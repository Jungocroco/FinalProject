//
//  AssortmentCell.swift
//  Record Store Explore
//
//  Created by Timo den Hartog on 16-01-18.
//  Copyright © 2018 Timo den Hartog. All rights reserved.
//

import UIKit

class RecordCell: UITableViewCell {

    @IBOutlet weak var thumbImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var artistLabel: UILabel!
    
    @IBOutlet weak var labelLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var stateLabel: UILabel!

    var record: Listing! {
        didSet {
            
            // Image retrieval (for lack of "setImageWithURL")

            let recordImage = URL(string: record.release.thumbnail)!
            //creating a dataTask
            let getImageFromUrl = URLSession.shared.dataTask(with: recordImage) { (data, response, error) in

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
                            DispatchQueue.main.async {
                                self.thumbImageView.image = image
                            }
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

            titleLabel.text = record.release.title
            artistLabel.text = record.release.artist
            labelLabel.text = record.release.catalog_number
            priceLabel.text = String(record.price.value)
            stateLabel.text = record.condition

        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        thumbImageView.layer.cornerRadius = 6
        thumbImageView.clipsToBounds = true
        
        titleLabel.preferredMaxLayoutWidth = titleLabel.frame.size.width
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.preferredMaxLayoutWidth = titleLabel.frame.size.width
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
