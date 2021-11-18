//
//  MessageCell.swift
//  Nytimersapp
//
//  Created by hasan al halabi on 26/10/2021.
//

import UIKit

class MessageCell: UITableViewCell {

    
    @IBOutlet weak var titleLable: UILabel!
   
    @IBOutlet weak var imagev: UIImageView!
    @IBOutlet weak var DateText: UILabel!
    @IBOutlet weak var leftImagevide: UIImageView!
    @IBOutlet weak var ByName: UILabel!
    
    override func prepareForReuse() {
        imagev.image = nil
    }
    public var news : Post!{
        didSet{
            self.imagev.load(urlString: news.media?.first?.metadata[0].url ?? "https://1000logos.net/wp-content/uploads/2017/04/Symbol-New-York-Times.png")
            self.titleLable.text = news.title
            self.DateText.text = news.published_date
            self.ByName.text = news.byline
            self.leftImagevide.load(urlString:  news.media?.first?.metadata[0].url ?? "https://1000logos.net/wp-content/uploads/2017/04/Symbol-New-York-Times.png")
        }
    }
   
    override func awakeFromNib() {
       
        
        super.awakeFromNib()
        
        // Initialization code
        imagev.layer.borderWidth = 1
            imagev.layer.masksToBounds = false
            imagev.layer.borderColor = UIColor.black.cgColor
            imagev.layer.cornerRadius = imagev.frame.height/2
            imagev.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
}
