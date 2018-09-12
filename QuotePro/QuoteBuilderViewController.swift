//
//  QuoteBuilderViewController.swift
//  QuotePro
//
//  Created by Kyla  on 2018-09-12.
//  Copyright © 2018 Kyla . All rights reserved.
//

import UIKit
import UserNotifications

protocol QuoteBuilderDelegate {
  func saveQuote(quote: Quote)
}
class QuoteBuilderViewController: UIViewController {
 //  Mark: Properties
  
    var delegate: QuoteBuilderDelegate! = nil
    var quoteText: String = ""
    var nameText: String = ""
    var quote: Quote?
  
  @IBOutlet weak var fullQuoteLabel: UILabel!
  @IBOutlet weak var fullNameLabel: UILabel!
  @IBOutlet weak var fullImageView: UIImageView!
  @IBOutlet weak var saveButton: UIBarButtonItem!
  


    override func viewDidLoad() {
      super.viewDidLoad()
      self.fullQuoteLabel.text = quoteText
      self.fullNameLabel.text = nameText
  
//      navigationItem.leftBarButtonItem = editButtonItem
//
//      let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
//      navigationItem.rightBarButtonItem = addButton
//      if let split = splitViewController {
//        let controllers = split.viewControllers
//        detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
//      }
      
    }
  
//  override func viewDidAppear(_ animated: Bool) {
//    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
//      return
//    }
//    let context  = appDelegate.persistentContainer.viewContext
//    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ToDo")
//
//    do {
//      toDos = try context.fetch(fetchRequest)
//      tableView.reloadData()
//    } catch {
//      print("error viewdidappear")
//    }
//  }
  
//  func save(title: String, toDoDescription: String, priorityNumber: Int32, completedSwitch: Bool) {
//    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
//      return
//    }
//    let managedContext = appDelegate.persistentContainer.viewContext
//    
//    let entity = NSEntityDescription.entity(forEntityName: "ToDo", in: managedContext)!
//    
//    let toDo = NSManagedObject(entity: entity, insertInto: managedContext)
//    
//    toDo.setValue(title, forKey: "title")
//    toDo.setValue(priorityNumber, forKey: "priorityNumber")
//    toDo.setValue(toDoDescription, forKey: "todoDescription")
//    
//    toDo.setValue(completedSwitch, forKey: "isCompleted")
//    
//    
//    do {
//      try managedContext.save()
//      toDos.append(toDo)
//      
//    } catch {
//      print("error save title: string")
//    }
//  }
  
  //  //MARK: Button Action
    @IBAction func quoteButtonTapped(_ sender: UIButton) {
      getQuote {
        // When from background thread, UI needs to be updated on main_queue
        DispatchQueue.main.async {
          self.fullQuoteLabel.text = "\"" + self.quoteText + "\"\n\n" + self.nameText
          self.quote = Quote(name: self.nameText, quote: self.quoteText)
        }
      }
    }
  
  
  @IBAction func imageButtonTapped(_ sender: UIButton) {
    getImage()
  }
  
  
  
  func getQuote(completion: @escaping() -> Void) {
/// Start background thread so that image loading does not make app unresponsive
    DispatchQueue.global(qos: .userInitiated).async {
      
      guard let endpointURL = URL(string: "https://api.forismatic.com/api/1.0/?method=getQuote&lang=en&format=json") else { return }
      
      var urlRequest = URLRequest(url: endpointURL)
      urlRequest.httpMethod = "GET"
      
      let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
        guard let dataResponse = data, error == nil else {
          print(error?.localizedDescription ?? "Response Error")
          return }
        do{
///here dataResponse received from a network request
          //          let jsonResponse = try JSONSerialization.jsonObject(with:
          //            dataResponse, options: [])
          //
          //          guard let jsonArray = jsonResponse as? [String: Any] else {
          //            return
          //          }
          let jsonResponse = try JSONSerialization.jsonObject(with: dataResponse, options: [])
          //          let jsonResponse = try JSONSerialization.jsonObject(with:
          //            dataResponse, options: [])
          guard let jsonArray = jsonResponse as? [String: Any] else {
            //          guard let jsonArray = jsonResponse as? [String: Any] else {

            return
          }
///Now get quote value
          guard let quoteText = jsonArray["quoteText"] as? String else { return }
          guard let nameText = jsonArray["quoteAuthor"] as? String else { return }
          
          self.quoteText = quoteText
          self.nameText = nameText
          completion()
          
        } catch let parsingError {
          print("Error while parsing", parsingError)
        }
      }
      task.resume()
    }
  }
  
    func getImage() {
      let imageUrlString = "https://picsum.photos/g/200/300/?random"
      let imageUrl:URL = URL(string: imageUrlString)!
  
      // Start background thread so that image loading does not make app unresponsive
      DispatchQueue.global(qos: .userInitiated).async {
  
        let imageData:NSData = NSData(contentsOf: imageUrl)!
  
        // When from background thread, UI needs to be updated on main_queue
        DispatchQueue.main.async {
          let image = UIImage(data: imageData as Data)
          self.fullImageView.image = image
          self.fullImageView.contentMode = UIViewContentMode.scaleAspectFill
        }
      }
    }

    //MARK: Navigation
  
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
       navigationController?.popViewController(animated: true)
    }
  
  
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
      delegate.saveQuote(quote: self.quote!)
      navigationController?.popViewController(animated: true)
      
    }
  
  
  }






  



