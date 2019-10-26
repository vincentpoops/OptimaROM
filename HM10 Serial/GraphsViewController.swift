//
//  GraphsViewController.swift
//  Serial
//
//  Created by Vincent Liu on 10/24/19.
//  Copyright © 2019 Balancing Rock. All rights reserved.
//

import CoreData
import UIKit

class DateTableViewCell: UITableViewCell {
    static let reuseIdentifier = "DateCell"
    @IBOutlet var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

class GraphsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    var numbers : [Date] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveData()
    }
    
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numbers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // return a cell with the peripheral name as text in the label
        let cell = tableView.dequeueReusableCell(withIdentifier: DateTableViewCell.reuseIdentifier, for: indexPath) as? DateTableViewCell
       
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let date = numbers[indexPath.row]
        let asdf = formatter.string(from: date)
        cell!.dateLabel.text = asdf
    
        return cell!
    }

    
    
}
