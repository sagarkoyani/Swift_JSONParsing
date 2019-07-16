//
//  ViewController.swift
//  Swift_JSONParsing
//
//  Created by Apple on 24/05/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    struct JSONStruct:Decodable {
        let name:String
        let capital:String
    }
    
    @IBOutlet weak var tableView: UITableView!
     var tableviewtemp=[[String:Any]]()
    var isDataAvailable:Bool=false
    var arrData=[JSONStruct]()
    override func viewDidLoad() {
        super.viewDidLoad()
    tableviewtemp.append(["name":"Sagar"])
        isDataAvailable=false
        tableView.delegate=self
        tableView.dataSource=self
        getdata()
        }
    func getdata(){
        let url=URL(string: "http://restcountries.eu/rest/v2/all")
        let url1=URL.init(string:"http://restcountries.eu/rest/v2/all")
        print(url!)
        URLSession.shared.dataTask(with: url!) {
        (data, response, error) in
        
        do{
            
        if error == nil {
            self.arrData=try JSONDecoder().decode([JSONStruct].self, from: data!)
            print("arrData=\(self.arrData)")
            self.dataRetrived()
            for mainarr in self.arrData{
                print(mainarr.name,":",mainarr.capital)
            }
            
        } // IF ERROR == NIL
                       }
        catch{
            print("Error in  get Json Data.")
        }
        }.resume() // URLSESSION
        
    } //Function
 
    func dataRetrived(){
        tableviewtemp=arrData
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableviewtemp.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "cell")
        var name:UILabel=cell?.viewWithTag(101) as! UILabel
        var capital:UILabel=cell?.viewWithTag(102) as! UILabel
        if isDataAvailable == true {
            name.text=arrData[indexPath.row].name
            capital.text=arrData[indexPath.row].capital
        }else{
            name.text="name"
            capital.text="Capital"
        }
        
        return cell!
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84
    }
}

