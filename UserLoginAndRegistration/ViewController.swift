//
//  ViewController.swift
//  UserLoginAndRegistration
//
//  Created by Leroy Klotz on 10/30/15.
//  Copyright © 2015 Leroy Klotz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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

