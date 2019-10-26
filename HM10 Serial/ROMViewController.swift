//
//  ROMViewController.swift
//  Serial
//
//  Created by Vincent Liu on 10/21/19.
//  Copyright © 2019 BME Team 15 idk. All rights reserved.
//

import Charts
import UIKit
import CoreData


class ROMViewController: UIViewController {
    @IBOutlet weak var chtChart: LineChartView!
    @IBOutlet weak var recover: UITextField!
    var numbers : [Double] = []//[90, 88, 120, 150]
    var dates : [Date] = []
    var numbers2 : [Double] = []//[85, 100, 115, 130, 145, 160, 175]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveData()
        linreg()
        updateGraph()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //get data from db
    func retrieveData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Recording")
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                numbers.append(data.value(forKey: "maxAngle") as! Double)
                dates.append(data.value(forKey: "date") as! Date)
            }
        } catch {
            print("failed")
        }
    }
    
    //estimate recovery
    func linreg() {
        var sum_x: Double = 0
        var sum_y: Double = 0
        var sum_xy: Double = 0
        var sum_xx: Double = 0
        let count = Double(numbers.count)
        
        for i in 0..<numbers.count {
            sum_x += Double(i)
            sum_y += numbers[i]
            sum_xy += (numbers[i] * Double(i))
            sum_xx += (Double(i) * Double(i))
        }
        //y = mx + b
        let m = (count * sum_xy - sum_x * sum_y) / (count * sum_xx - sum_x * sum_x)
        let b = (sum_y - m * sum_x) / count
        
        numbers2.append(b)
        if m > 0 {
            var j = 0
            while abs(180 - numbers2[numbers2.count-1]) > 10 && numbers2[numbers2.count-1] <= 190{
                j += 1
                numbers2.append(Double(j) * m + b)
            }
            let days = numbers2.count - 1
            let reday = Calendar.current.date(byAdding: .day, value: days, to: dates[0])
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let asdf = formatter.string(from: reday!)
            recover.text = "Estimated Recovery: " + asdf
        } else {
            // you aren't recovering lol
            for i in 1..<numbers.count {
                numbers2.append(Double(i) * m + b)
            }
            recover.text = "Estimated Recovery: Never"
        }
    }
    
    func updateGraph(){
        var lineChartEntry  = [ChartDataEntry]() //this is the Array that will eventually be displayed on the graph.
        var lineChartEntry2 = [ChartDataEntry]()
        
        for i in 0..<numbers.count {
            let value = ChartDataEntry(x: Double(i), y: numbers[i]) // here we set the X and Y status in a data chart entry
            lineChartEntry.append(value) // here we add it to the data set
        }
        let line1 = LineChartDataSet(entries: lineChartEntry, label: "Extension") //Here we convert lineChartEntry to a LineChartDataSet
        line1.colors = [NSUIColor.blue] //Sets the colour to blue
        
        for j in 0..<numbers2.count {
            let value2 = ChartDataEntry(x: Double(j), y: numbers2[j])
            lineChartEntry2.append(value2)
        }
        let line2 = LineChartDataSet(entries: lineChartEntry2, label: "LinReg")
        line2.colors = [NSUIColor.red]
        
        let data = LineChartData() //This is the object that will be added to the chart
        data.addDataSet(line1) //Adds the line to the dataSet
        data.addDataSet(line2)
        
        chtChart.data = data //finally - it adds the chart data to the chart and causes an update
        chtChart.chartDescription?.text = "ROM LinReg" // Here we set the description for the graph
    }
}
