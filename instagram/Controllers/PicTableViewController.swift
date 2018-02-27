//
//  PicTableViewController.swift
//  instagram
//
//  Created by Kevin Nguyen on 2/24/18.
//  Copyright © 2018 KevinVuNguyen. All rights reserved.
//

import UIKit
import Parse

class PicTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    let query = PFQuery(className: "Post")
    var picList: [PFObject] = []
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Made it inside viewdidLoad")
        self.title = "Instagram"
        tableView.dataSource = self
        tableView.delegate = self
        getQuery()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.onTimer), userInfo: nil, repeats: true)
        let refreshControl = UIRefreshControl()
        tableView.insertSubview(refreshControl, at: 0)
    }

    func getQuery() {
        print("made it inside getQuery")
        self.query.includeKey("author")
        print("Made it after query include key")
        self.query.limit = 20
        self.query.findObjectsInBackground{(object: [PFObject]?, error: Error?) in
            if object != nil {
                for i in object! {
                    print(i)
                }
                print("Size of object", object!.count)
                self.picList = object!
                self.tableView.reloadData()
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    @objc func onTimer() {
        getQuery()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print("Made it inside numberOfRowsInSection")
        print("Number of rows is", picList.count)
        return picList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("made it inside tableview cell for row at")
        let cell = tableView.dequeueReusableCell(withIdentifier: "picCell", for: indexPath) as! picCell
        let post = picList[indexPath.row] as! Post
        print("The new caption: ", post.caption)
        cell.descriptionLabel.text = post.caption
        let userPicture = post.media
        userPicture.getDataInBackground({
            (imageData: Data?, error: Error?) -> Void in
            if (error == nil) {
                let image = UIImage(data:imageData!)
                cell.imageDescript.image = image
            }
        })
        cell.authorName.text = post.author.username!
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell){
            let singlePic = picList[indexPath.row]
            let detailViewController = segue.destination as! PicInfoController
            detailViewController.post = singlePic
        }
    }// sending data to another view controller

}
