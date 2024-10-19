//
//  favoriteViewController.swift
//  workshopiosTP1
//
//  Created by iMac on 19/10/2024.
//

import UIKit
import CoreData

class favoriteViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    
    
    //var
    var favorite = [String]()
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorite.count //  6 element
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "mCell")
        let contentView = cell?.contentView
        let label = contentView?.viewWithTag(1) as! UILabel
        let imageView = contentView?.viewWithTag(2) as! UIImageView
        
        label.text = favorite[indexPath.row]
        
        imageView.image = UIImage (named: favorite[indexPath.row])
        
        return cell!

    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            deletItem( index: indexPath.row)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        // Do any additional setup after loading the view.
    }  
    
    func fetchData(){
        
        //3 etapes primordiaux au CRUB
        //appdelegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // persistent container
        let persistentContainer = appDelegate.persistentContainer
        
        //COPY managedContext
        let managedContext = persistentContainer.viewContext
        
        
        
        // Requete
        let request = NSFetchRequest<NSManagedObject>(entityName: "Movie")
        
        //execution
        
        do{
            
                let result = try managedContext.fetch(request)
            
                for item in result {
                
                favorite.append(item.value(forKey: "movieName") as! String)
                            }
        }catch {
            print("FETCHING ERROR !!!!!")
        }
        
    }
        
        
    
    
           
    
    func deletItem(index: Int) {
        //3 etapes primordiaux au CRUB
        //appdelegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // persistent container
        let persistentContainer = appDelegate.persistentContainer
        
        //COPY managedContext
        let managedContext = persistentContainer.viewContext
        
        let request = NSFetchRequest<NSManagedObject>(entityName: "Movie")
        let predicate = NSPredicate(format: "movieName = %@ ", favorite[index] )
        
        request.predicate = predicate
        
        
        do {
            let result = try managedContext.fetch(request)
            if result.count > 0 {
                
                let obj = result[0] // NSManagedObject
                managedContext.delete(obj)
                print("DELETED SUCCESSEFULLY! ")
            }
            
        } catch  {
            print("Fetching error!!")
        }
        
        
        
    }
    
    
    
    
    
    
    
    
  
    
    

    


}
