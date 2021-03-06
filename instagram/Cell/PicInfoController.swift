//
//  PicInfoController.swift
//  instagram
//
//  Created by Kevin Nguyen on 2/25/18.
//  Copyright © 2018 KevinVuNguyen. All rights reserved.
//

import UIKit
import Parse

class PicInfoController: UIViewController {

    @IBOutlet weak var UsernameLabel: UILabel!
    @IBOutlet weak var imageScreen: UIImageView!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    var post: PFObject? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let post = post as? Post{
            timeStampLabel.text = post.createdAt?.description
            captionLabel.text = post.caption
            likeCountLabel.text = String(post.likesCount)
            UsernameLabel.text = post.author.username!
            let picTemp = post.media
            
            picTemp.getDataInBackground({(imageData: Data?, error: Error?) -> Void in
                if (error == nil) {
                    let image = UIImage(data:imageData!)
                    self.imageScreen.image = image
                }
            })
            
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
