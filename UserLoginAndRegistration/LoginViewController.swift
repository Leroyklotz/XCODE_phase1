//
//  LoginViewController.swift
//  UserLoginAndRegistration
//
//  Created by Leroy Klotz 10/30/15.
//  Copyright © 2015 Leroy Klotz. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {

    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func LoginButtonTapped(sender: AnyObject) {
        
        let userEmail = userEmailTextField.text;
        let userPassword = userPasswordTextField.text;
        
        let userEmailStored = NSUserDefaults.standardUserDefaults().stringForKey("userEmail");
        let userPasswordStored = NSUserDefaults.standardUserDefaults().stringForKey("userPassword");
        
        func displayMyAlertMessage(userMessage:String)
        {
            let myAlert = UIAlertController(title:"Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert);
            
            let okAction = UIAlertAction(title:"Ok", style: UIAlertActionStyle.Default, handler:nil);
            
            myAlert.addAction(okAction);
            
            self.presentViewController(myAlert, animated:true, completion:nil);
        }
        
        if (userEmail!.isEmpty || userPassword!.isEmpty)
        {
            // Display alert message
            
            displayMyAlertMessage("All fields are required");
            
            return;
        } // Check if all fields are entered
        
        if(userEmailStored != userEmail)
        {
            // Display an alert message
            
            displayMyAlertMessage("Email adress not known");
            
            return;
        } // Check if known email adress
        
        if(userPasswordStored != userPassword)
        {
            // Display an alert message
            
            displayMyAlertMessage("Incorrect password");
            
            return;
        } // Check if correct password
        
        if(userEmailStored == userEmail)
        {
            if(userPasswordStored == userPassword)
            {
                // Login is successfull
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isUserLoggedIn"); // Set status isUserLoggedIn = True
                NSUserDefaults.standardUserDefaults().synchronize();
                self.dismissViewControllerAnimated(true, completion: nil);
            }
        } // If correct email adress and correct password, present loginView
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
