//
//  ViewController.swift
//  UserLoginAndRegistration
//
//  Created by Leroy Klotz on 10/30/15.
//  Copyright © 2015 Leroy Klotz. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var goal = [NSManagedObject]()
    
    @IBAction func addItem(sender: AnyObject) {
        
        let alert = UIAlertController(title: "New Item",
            message: "Add a new item",
            preferredStyle: .Alert)
        
        let saveAction = UIAlertAction(title: "Save",
            style: .Default,
            handler: { (action:UIAlertAction) -> Void in
                
                let textField = alert.textFields!.first
                self.saveItem(textField!.text!)
                self.tableView.reloadData()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel",
            style: .Default) { (action: UIAlertAction) -> Void in
        }
        
        alert.addTextFieldWithConfigurationHandler {
            (textField: UITextField) -> Void in
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        presentViewController(alert,
            animated: true,
            completion: nil)
    }
    
    // Delete item [self.managedObjectContext deleteObject:item];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Things I would like to do"
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            return goal.count
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath
        indexPath: NSIndexPath) -> UITableViewCell {
            
            let cell =
            tableView.dequeueReusableCellWithIdentifier("Cell")
            
            let Item = goal[indexPath.row]
            
            cell!.textLabel!.text =
                Item.valueForKey("item") as? String
            
            return cell!
    }
    
    func saveItem(name: String) {
        
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let entity =  NSEntityDescription.entityForName("Goal",
            inManagedObjectContext:managedContext)
        
        let Item = NSManagedObject(entity: entity!,
            insertIntoManagedObjectContext: managedContext)
        
        Item.setValue(name, forKey: "item")
        
        do {
            try managedContext.save()
            goal.append(Item)
        }
        catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Goal")
        
        do {
            let results =
            try managedContext.executeFetchRequest(fetchRequest)
            goal = results as! [NSManagedObject]
        }
        catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool)
    {
        let isUserloggedIn = NSUserDefaults.standardUserDefaults().boolForKey("isUserLoggedIn"); // Get status isUserLoggedIn
        
        if(!isUserloggedIn)
        {
            self.performSegueWithIdentifier("loginView", sender: self);
        } // If status isUserLoggedIn = False, present loginView
    }

    @IBAction func logoutButtonTapped(sender: AnyObject)
    {
        NSUserDefaults.standardUserDefaults().setBool(false,forKey:"isUserLoggedIn"); // Set status isUserLoggedIn to False
        NSUserDefaults.standardUserDefaults().synchronize();
        
        self.performSegueWithIdentifier("loginView", sender: self); // Present loginView
    }
}

