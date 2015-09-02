//
//  BeastedListViewController.swift
//  iOSPractice
//
//  Created by Wei Chung Chuo on 8/14/15.
//  Copyright © 2015 Wei Chung Chuo. All rights reserved.
//

import UIKit


class BeastedListViewController: UITableViewController {

    
    //set variable beasts as an array that call Beast.all function.
    var beasts: [Beast] = Beast.all()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //set variable "cell" and pin it to identifier called "BeastedCell", then set the textLabel to each row of data and return it.
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // dequeue the cell from our storyboard
        let cell = tableView.dequeueReusableCellWithIdentifier("BeastedCell")!
        
        // set "date" as "createdAt"
        let date = beasts[indexPath.row].createdAt //get the time, in this case the time an object was created.
        //format date
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEE MMM dd" //format style.
        
        let printDate = dateFormatter.stringFromDate(date)
        
        // if the cell has a text label, set it to the model that is corresponding to the row in array
        cell.textLabel?.text = beasts[indexPath.row].objective + "            " + printDate

        // return cell so that Table View knows what to draw in each row
        return cell
    }
    
    //override the function tableView so it take a return of integer. Var beasts is set to invoke Beast.all function to query and count all rows in the data.
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        beasts = Beast.all()
        return beasts.count
    }
    

}