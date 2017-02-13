//
//  ViewController.swift
//  SwapCard Project
//
//  Created by Aditya Vikram Godawat on 11/02/17.
//  Copyright © 2017 Aditya Vikram Godawat. All rights reserved.
//

import UIKit
import Alamofire
import CoreData

class ViewController: UIViewController {
    
    // MARK: - Variables
    
    var users: [NSManagedObject] = []
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        getData()
        
    }
    
    // MARK: - Core Data
    
    func save(aUser: Users) {
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: "User",
                                       in: managedContext)!
        
        let user = NSManagedObject(entity: entity, insertInto: managedContext)
        
        user.setValue(aUser.cell, forKey: "cell")
        user.setValue(aUser.city, forKey: "city")
        user.setValue(aUser.dateOfBirth, forKey: "dateOfBirth")
        user.setValue(aUser.email, forKey: "email")
        user.setValue(aUser.firstName, forKey: "firstName")
        user.setValue(aUser.gender, forKey: "gender")
        user.setValue(aUser.lastName, forKey: "lastName")
        user.setValue(aUser.nationality, forKey: "nationality")
        user.setValue(aUser.phone, forKey: "phone")
        let aData = UIImagePNGRepresentation(aUser.picture)
        user.setValue(aData, forKey: "picture")
        user.setValue(aUser.postCode, forKey: "postCode")
        user.setValue(aUser.registrationDate, forKey: "registrationDate")
        user.setValue(aUser.state, forKey: "state")
        user.setValue(aUser.street, forKey: "street")
        user.setValue(aUser.title, forKey: "title")
        user.setValue(aUser.username, forKey: "username")
        
        do {
            try managedContext.save()
            users.append(user)
            _USERS.append(aUser)

        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    
    func deleteAllData(entity: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        
        do
        {
            let results = try managedContext.fetch(fetchRequest)
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }
        } catch let error as NSError {
            print("Detele all data in \(entity) error : \(error) \(error.userInfo)")
        }
    }
    
    
    func loadData() {
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "User")
        
        //3
        do {
            users = try managedContext.fetch(fetchRequest)
            parseCoreData()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    
    func parseCoreData() {
        
        _USERS = [Users]()
        
        for aUser in users {
            let USER = Users()
            USER.cell = (aUser.value(forKey: "cell") as? String)!
            USER.city = (aUser.value(forKey: "city") as? String)!
            USER.dateOfBirth = (aUser.value(forKey: "dateOfBirth") as? String)!
            USER.email = (aUser.value(forKey: "email") as? String)!
            USER.firstName = (aUser.value(forKey: "firstName") as? String)!
            USER.gender = (aUser.value(forKey: "gender") as? String)!
            USER.lastName = (aUser.value(forKey: "lastName") as? String)!
            USER.nationality = (aUser.value(forKey: "nationality") as? String)!
            USER.phone = (aUser.value(forKey: "phone") as? String)!
            let aPicture = (aUser.value(forKey: "picture") as? NSData)!
            USER.picture = UIImage(data: aPicture as Data)
            USER.postCode = (aUser.value(forKey: "postCode"))!
            USER.registrationDate = (aUser.value(forKey: "registrationDate") as? String)!
            USER.state = (aUser.value(forKey: "state") as? String)!
            USER.street = (aUser.value(forKey: "street") as? String)!
            USER.title = (aUser.value(forKey: "title") as? String)!
            USER.username = (aUser.value(forKey: "username") as? String)!
            _USERS.append(USER)
        }
        moveOn()
    }
    
    
    // MARK: - User Actions
    
    func getData() {
        
        SHOW_BLACK_SCREEN()
        
        Alamofire.request(_IP, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
            .responseJSON { (aResponse) in
                switch aResponse.result {
                case .success:
                    
                    print(aResponse.result.value!)
                    
                    let aJSON = aResponse.result.value as! NSDictionary
                    
                    if let aResults = aJSON["results"] as? [NSDictionary] {
                        
                        _USERS = [Users]()
                        self.deleteAllData(entity: "User")
                        for aResult in aResults {
                            
                            let aUser = Users()
                            
                            aUser.cell = aResult["cell"] as! String
                            
                            let dateOfBirth = aResult["dob"] as! String
                            
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                            let aDate = dateFormatter.date(from: dateOfBirth)
                            
                            let dayTimePeriodFormatter = DateFormatter()
                            dayTimePeriodFormatter.dateFormat = "d MMMM, yyyy"
                            aUser.dateOfBirth = dayTimePeriodFormatter.string(from: aDate!)
                            
                            aUser.email = aResult["email"] as! String
                            aUser.gender = (aResult["gender"] as! String).capitalized
                            
                            
                            if let aLocation = aResult["location"] as? NSDictionary {
                                aUser.city = (aLocation["city"] as! String).capitalized
                                aUser.postCode = aLocation["postcode"] as Any
                                aUser.state = (aLocation["state"] as! String).capitalized
                                aUser.street = (aLocation["street"] as! String).capitalized
                            } else {
                                
                                REMOVE_BLACK_SCREEN()
                                break
                            }
                            
                            if let aLogin = aResult["login"] as? NSDictionary {
                                aUser.username = aLogin["username"] as! String
                            } else {
                                
                                REMOVE_BLACK_SCREEN()
                                break
                            }
                            
                            if let aName = aResult["name"] as? NSDictionary {
                                aUser.firstName = (aName["first"] as! String).capitalized
                                aUser.lastName = (aName["last"] as! String).capitalized
                                aUser.title = (aName["title"] as! String).capitalized
                            } else {
                                
                                REMOVE_BLACK_SCREEN()
                                break
                            }
                            
                            aUser.nationality = aResult["nat"] as! String
                            aUser.phone = aResult["phone"] as! String
                            
                            let aDateReg = aResult["registered"] as! String
                            
                            let aRegDate = dateFormatter.date(from: aDateReg)
                            
                            aUser.registrationDate = dayTimePeriodFormatter.string(from: aRegDate!)
                            
                            if let aPicture = aResult["picture"] as? NSDictionary {
                                
                                let pictureURL = aPicture["large"] as! String
                                
                                do { let data = try Data.init(contentsOf: URL(string: pictureURL)!)
                                    aUser.picture = UIImage(data: data)
                                }
                                catch {
                                    
                                }
                            }else {
                                
                                REMOVE_BLACK_SCREEN()
                                break
                            }
                            
                            self.save(aUser: aUser)
                        }
                        
                        REMOVE_BLACK_SCREEN()
                        self.moveOn()
                        
                    } else {
                        
                        REMOVE_BLACK_SCREEN()
                        break
                    }
                    break

                case .failure(let kError):
                    
                    REMOVE_BLACK_SCREEN()
                    print("Error in Test API", kError.localizedDescription)
                    let anError = kError as NSError
                    if anError.code == -1009 {
                        let anAlert = UIAlertController(title: "Oops!", message: "You are not connected to the internet. Displaying users fetched the last time out.", preferredStyle: UIAlertControllerStyle.alert)
                        anAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (anAction) in
                            self.loadData()
                        }))
                        self.present(anAlert, animated: true, completion: nil)
                    } else {
                        self.showAlert("Error", withMessage: "Something went wrong. Please try again in sometime.")
                    }
                }
        }
    }
    
    
    func moveOn() {
        let aVC = UserListTableViewController()
        self.navigationController?.pushViewController(aVC, animated: true)
        
    }
    
    
    func showAlert(_ title:String, withMessage: String) -> Void {
        
        let anAlert = UIAlertController(title: title, message: withMessage, preferredStyle: UIAlertControllerStyle.alert)
        anAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(anAlert, animated: true, completion: nil)
        
    }
}
