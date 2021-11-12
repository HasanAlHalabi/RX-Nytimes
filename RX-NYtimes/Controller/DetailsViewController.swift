//
//  DetailsViewController.swift
//  RX-NYtimes
//
//  Created by hasan al halabi on 12/11/2021.
//

import UIKit

class DetailsViewController: UIViewController {
    var byLine = String ()
        var titletext1 = String ()
        var abstrack1 = String ()
        var imagelink = String ()
        var updated = String ()
    var keyword = String ()
    @IBOutlet weak var updatedtime: UILabel!
    @IBOutlet weak var keys: UILabel!
    @IBOutlet weak var abstark: UILabel!
    @IBOutlet weak var byName: UILabel!
    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var tilelabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        updatedtime.text = updated
        
                imageV.load(urlString: imagelink)
        tilelabel.text = titletext1
        abstark.text = abstrack1
        byName.text = byLine
        keys.text = keyword
        // Do any additional setup after loading the view.
    }
    

  

}
