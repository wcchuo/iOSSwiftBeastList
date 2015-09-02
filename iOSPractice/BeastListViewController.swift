//
//  BeastListViewController.swift
//  iOSPractice
//
//  Created by Wei Chung Chuo on 8/14/15.
//  Copyright © 2015 Wei Chung Chuo. All rights reserved.
//

import UIKit

class BeastListViewController: UITableViewController, CancelButtonDelegate, BeastDetailsViewControllerDelegate {
    
    //set variable beasts as an array that call Beast.all function.
    var beasts: [Beast] = Beast.all()
    var isEditing: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //set variable "cell" and pin it to identifier called "BeastCell", then set the textLabel to each row of data and return it.
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // dequeue the cell from our storyboard
        let cell = tableView.dequeueReusableCellWithIdentifier("BeastCell")!
        
        // if the cell has a text label, set it to the model that is corresponding to the row in array
        cell.textLabel?.text = beasts[indexPath.row].objective
        
        // return cell so that Table View knows what to draw in each row
        return cell
    }
    
    //override the function tableView so it take a return of integer. Var beasts is set to invoke Beast.all function to query and count all rows in the data.
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        beasts = Beast.all()
        return beasts.count
    }
    
    @IBAction func addBeastButtonPressed(sender: AnyObject) {
        isEditing = false
        performSegueWithIdentifier("DetailsSegue", sender: nil)
    }
    
    //when cancel button is touched, go back to the previous view
    func cancelButtonPressedFrom(controller: UIViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //enable swipe to left delete, touch to remove data row, then reload
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        beasts[indexPath.row].destroy()
        beasts.removeAtIndex(indexPath.row)
        tableView.reloadData()
    }
    
    //enable editing on cell touch
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("EditBeast", sender: tableView.cellForRowAtIndexPath(indexPath))
    }
    
    
    
    @IBAction func toBeastButtonPressed(sender: UIButton) {
        //sender.tag = beasts[indexPath.row]
//                beasts[indexPath.row].destroy()
//                beasts.removeAtIndex(indexPath.row)
        tableView.reloadData()
    }
    
    
    //check to see if there is a sugue identifier call "AddNewBeast", if yes, override the function prepareForSegue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "AddNewBeast" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! BeastDetailsViewController
            controller.cancelButtonDelegate = self
            controller.delegate = self
        } else if segue.identifier == "EditBeast" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! BeastDetailsViewController
            controller.cancelButtonDelegate = self
            controller.delegate = self
            if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell) {
                controller.beastToEdit = beasts[indexPath.row]
            }
        }
    }
    
    //save newly added text to the tableView then reload the row and data
    func beastDetailsViewController(controller: BeastDetailsViewController, didFinishAddingBeast beast: String) {
        dismissViewControllerAnimated(true, completion: nil)
        let beast = Beast(obj: beast, beastedCheck: "No")
        beast.save()
        tableView.reloadData()
    }
    
    //call this function when Beast is sent to update the row
    func beastDetailsViewController(controller: BeastDetailsViewController, didFinishEditingBeast beast: Beast) {
        dismissViewControllerAnimated(true, completion: nil)
        beast.save()
        tableView.reloadData()
    }
}

