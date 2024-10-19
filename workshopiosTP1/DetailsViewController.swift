//
//  DetailsViewController.swift
//  workshopiosTP1
//
//  Created by iMac on 19/10/2024.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController{
    

   //var
    var movieTitle:String?
    
    
    
    // widgets
    @IBOutlet weak var movieImage: UIImageView!
    
    
    @IBOutlet weak var movieLabel: UILabel!
    
    
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        movieImage.image = UIImage(named: movieTitle!)
        movieLabel.text = movieTitle
        // Do any additional setup after loading t
    }
    
    //function
 
    func insertItem(){
        
        
        //3 etapes primordiaux au CRUB
        //appdelegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // persistent container
        let persistentContainer = appDelegate.persistentContainer
        
        //COPY managedContext
        let managedContext = persistentContainer.viewContext
        
        //article vide
        let entityDescription = NSEntityDescription.entity(forEntityName: "Movie", in: managedContext)
        
        
        //obj
        let object = NSManagedObject(entity: entityDescription!, insertInto: managedContext)
        
        //add valeur
        object.setValue(movieTitle, forKey: "movieName")
        
        
        //push
        do{
            try managedContext.save()
            print("INSERT SUCCESSFULLY")
        }catch  {
            print("Failed: insert error !!!")
        }
        
        
        
        
    }
    
    
    //ifexist
    
    func checkMovie() -> Bool {
         var movieExist = false
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // persistent container
        let persistentContainer = appDelegate.persistentContainer
        
        //COPY managedContext
        let managedContext = persistentContainer.viewContext
        
        let request = NSFetchRequest<NSManagedObject>(entityName: "Movie")
        let predicate = NSPredicate(format: "movieName = %@ ", movieTitle!)
        
        request.predicate = predicate
        
        do {
            let result = try managedContext.fetch(request)
            if result.count > 0 {
                
                movieExist = true
            }
            
        } catch  {
            print("Fetching error ")
        }
        
        return movieExist
        
    }
    
    
    
    
    
    
   //IBaction
    @IBAction func savemovie(_ sender: Any) {
        
        if checkMovie() {
            let alert = UIAlertController(title: "warnning", message: "Movie already exist ", preferredStyle: .alert)
            let action = UIAlertAction(title: "Got it!", style: .cancel, handler: nil)
            alert.addAction(action)
            
            self.present(alert, animated: true)
           
        }
        else {
            
            insertItem()
        }
    }
    

}
