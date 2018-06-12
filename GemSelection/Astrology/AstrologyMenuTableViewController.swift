//
//  AstrologyMenuTableViewController.swift
//  GemSelection
//
//  Created by Bhavin on 12/06/18.
//  Copyright © 2018 atlas. All rights reserved.
//

import UIKit

class AstrologyMenuTableViewController: UITableViewController {

    var cellId = "astrologyCell"
    var menuItems: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("COUNT IS ************")
        print(menuItems?.count)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Accept-Language": "en",
            "Authorization": "Basic NjAxNjk2Ojg1MTBlNTM3YmNjNDI0ZTE1NGEzODYwZTcwZTkyMjA5=="
        ]
        
        let postData = NSMutableData(data: "day=26".data(using: String.Encoding.utf8)!)
        postData.append("&month=3".data(using: String.Encoding.utf8)!)
        postData.append("&year=2018".data(using: String.Encoding.utf8)!)
        postData.append("&hour=23".data(using: String.Encoding.utf8)!)
        postData.append("&min=52".data(using: String.Encoding.utf8)!)
        postData.append("&lat=37.3382".data(using: String.Encoding.utf8)!)
        postData.append("&lon=-121.8863".data(using: String.Encoding.utf8)!)
        postData.append("&tzone=-7".data(using: String.Encoding.utf8)!)
        postData.append("&date=03-27-2018".data(using: String.Encoding.utf8)!)
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://json.astrologyapi.com/v1/planets")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse)
            }
        })
        
        dataTask.resume()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (menuItems?.count)!
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)

        cell.textLabel?.text = menuItems?[indexPath.row]
        // Configure the cell...

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
