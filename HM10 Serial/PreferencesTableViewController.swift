//
//  PreferencesTableViewController.swift
//  HM10 Serial
//
//  Created by Alex on 10-08-15.
//  Copyright (c) 2015 Balancing Rock. All rights reserved.
//

import CoreData
import UIKit

final class PreferencesTableViewController: UIViewController, UITableViewDelegate {
    
//MARK: Variables

    var numbers : [Date] = []


//MARK: Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveData()
    }

    // Pulls data from CoreData
    func retrieveData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Recording")
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                numbers.append(data.value(forKey: "date") as! Date)
            }
        } catch {
            print("failed")
        }
    }
    
    //
    //func numberOfSections(in tableView: UITableView) -> Int {
        //return 1
    //}
    
    //func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // return numbers.count
    //}
    /*
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // return a cell with the peripheral name as text in the label
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let label = cell.viewWithTag(1) as! UILabel
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        label.text = formatter.string(from: numbers[(indexPath as NSIndexPath).row])
        return cell
    }*/
    
    
    /*override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        var dasd = numbers[(indexPath as NSIndexPath).row]
        // deselect row
        tableView.deselectRow(at: indexPath, animated: true)

    }*/
    
    
//MARK: IBActions

    
    @IBAction func done(_ sender: AnyObject) {
        // dismissssssss
        dismiss(animated: true, completion: nil)
    }
}
