//
//  Graph2ViewController.swift
//  Serial
//
//  Created by Vincent Liu on 10/21/19.
//  Copyright © 2019 Balancing Rock. All rights reserved.
//

import Charts
import UIKit
import CoreData

class Graph2ViewController: UIViewController {
    @IBOutlet weak var chtChart: LineChartView!

    var numbers: [Double] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //createData()
        retrieveData()
        updateGraph()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func retrieveData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Recording")
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                numbers = data.value(forKey: "emg") as! [Double]
            }
        } catch {
            print("failed")
        }
    }
    
    /*
    func createData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let userEntity = NSEntityDescription.entity(forEntityName: "Recording", in: managedContext)!
        
        let poop = NSManagedObject(entity: userEntity, insertInto: managedContext)
        poop.setValue(180, forKey: "maxAngle")
        poop.setValue(0, forKey: "minAngle")
        poop.setValue([10, 11, 12, 13], forKey: "emg")
        poop.setValue(Date(), forKey: "date")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }*/
        
    //var numbers : [Double] = [1.72, 0.18, 1.80, 0.27, 0.06, 0.05, 0.05, 1.68, 0.27]
    
    
    func updateGraph(){
        var lineChartEntry  = [ChartDataEntry]() //this is the Array that will eventually be displayed on the graph.
            
            for i in 0..<numbers.count {
                let value = ChartDataEntry(x: Double(i), y: numbers[i]) // here we set the X and Y status in a data chart entry
                lineChartEntry.append(value) // here we add it to the data set
            }
            
            let line1 = LineChartDataSet(entries: lineChartEntry, label: "Number") //Here we convert lineChartEntry to a LineChartDataSet
            line1.colors = [NSUIColor.blue] //Sets the colour to blue
            
            let data = LineChartData() //This is the object that will be added to the chart
            data.addDataSet(line1) //Adds the line to the dataSet
            
            
            chtChart.data = data //finally - it adds the chart data to the chart and causes an update
            chtChart.chartDescription?.text = "My awesome chart" // Here we set the description for the graph
        }
        
     
}
