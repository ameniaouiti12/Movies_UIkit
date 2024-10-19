//
//  ViewController.swift
//  workshopiosTP1
//
//  Created by iMac on 19/10/2024.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var data = ["El Camino","Extraction","Project Power","Six Underground", "Spenser Confidential","The Irishman"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count //  6 element
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "mCell")
        let contentView = cell?.contentView
        let label = contentView?.viewWithTag(1) as! UILabel
        let imageView = contentView?.viewWithTag(2) as! UIImageView
        
        label.text = data[indexPath.row]
        
        imageView.image = UIImage(named: data[indexPath.row])
        
        
        return cell!
        
        
    }
    
    
    
    
    //cllule OnclickListner
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let movie = data[indexPath.row]
        performSegue(withIdentifier: "mSegue", sender: movie)
        
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "mSegue"{
            
    let movie = sender as! String
        let destination =  segue.destination as! DetailsViewController
        destination.movieTitle = movie
        }
    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

