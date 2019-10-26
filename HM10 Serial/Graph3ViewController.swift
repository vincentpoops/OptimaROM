//
//  Graph3ViewController.swift
//  Serial
//
//  Created by Vincent Liu on 10/21/19.
//  Copyright © 2019 Balancing Rock. All rights reserved.
//
import Charts
import UIKit

class Graph3ViewController: UIViewController {
    @IBOutlet weak var chtChart: LineChartView!
    
    //var numbers : [Double] = [0.27, 1.68, 0.05, 0.06, 0.27, 1.80, 0.18, 1.72]
    var numbers: [Double]!
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
    
    
    @IBAction func saveChart(_ sender: Any) {
        UIImageWriteToSavedPhotosAlbum(chtChart.getChartImage(transparent: false)!, nil, nil, nil)
    }
        
}
