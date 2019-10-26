//
//  Graph1ViewController.swift
//  Serial
//
//  Created by Vincent Liu on 10/21/19.
//  Copyright © 2019 Balancing Rock. All rights reserved.
//

import UIKit
import Charts

class Graph1ViewController: UIViewController {
    @IBOutlet weak var chtChart: LineChartView!
    
    var numbers : [Double] = [0.12, 1.03, 1.71, 0.06, 0.05, 0.73, 1.77, 0.66, 0.05]
    override func viewDidLoad() {
        super.viewDidLoad()
        updateGraph()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
            
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
