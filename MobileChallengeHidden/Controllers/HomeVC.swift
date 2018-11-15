//
//  ViewController.swift
//  MobileChallengeHidden
//
//  Created by imac dt on 15/11/2018.
//  Copyright © 2018 Libasse MBAYE. All rights reserved.
//

import UIKit
import SwiftyJSON

class HomeVC: UITableViewController {
    /*=========================================================================*/
    var sv: UIView? = nil
    /*=========================================================================*/
    var depots:[Depot] = []
    var depot:Depot? = nil
    /*=========================================================================*/
    fileprivate let cellid = "HomeVC"
    var inc_two = 0
    var inc_three = 0
    var inc_four = 0
    /*=========================================================================*/

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*=========================================================================*/
        /* Initialisation de la tableview */
        tableView.register(DepotCell.self, forCellReuseIdentifier: cellid)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(red:CGFloat(221/255.0), green:CGFloat(221/255.0), blue:CGFloat(221/255.0), alpha:1.0)
        tableView.rowHeight = UITableView.automaticDimension
        /*=========================================================================*/
        sv = UIViewController.displaySpinne(onView: self.view)
        /*=========================================================================*/
        /*=========================================================================*/
        fetchDepot()
    }

    /*=========================================================================*/
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return depots.count
    }
    /* fin */
    
    override open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250.0
    }
    
    /* Retourner une ligne */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as! DepotCell
        let dept = depots[indexPath.row]
        cell.setDepot(dept: dept)
        cell.layoutSubviews()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        let intTotalrow = tableView.numberOfRows(inSection:indexPath.section)//first get total rows in that section by current indexPath.
        //get last last row of tablview
        if indexPath.row == intTotalrow - 1{
            
            print("Position :\(indexPath.row)")
            if (indexPath.row == 29){
                if (inc_two == 0){
                    inc_two = 1
                    fetchPAgination(page: "2")
                }
            }else if(indexPath.row == 59){
                if (inc_three == 0){
                    inc_three = 1
                    fetchPAgination(page: "3")
                }
            }else if(indexPath.row == 89){
                if (inc_four == 0){
                    inc_four = 1
                    fetchPAgination(page: "4")
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        depot = depots[indexPath.row]
        let vc = DetailVC()
        vc.depot = depot
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailVC{
            destination.depot = depot
        }
    }
    /*=========================================================================*/
    /* La méthode qui charge les dépôts */
    func fetchDepot(){
        //Url api
        let url = URL(string: "\(Common.link_api)")!
        //
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        //let body = "q=created:%3E2017-10-22&sort=stars&order=desc"
        //request.httpBody = body.data(using: String.Encoding.utf8)
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            // get main queue to operations inside of this block
            DispatchQueue.main.async(execute: {
                
                // no error of accessing php file
                if error == nil {
                    
                    do {
                        
                        // declare new parseJSON to store json
                        let json = try JSON(data: data!)
                        
                        //print("Total count :\(json["total_count"]), items : \(json["items"].arrayValue)")
                        UIViewController.removeSpinne(spinner: self.sv!)
                        let depts = json["items"].arrayValue
                            for dept in depts {
                                print("nom dépot :\(dept["name"])")
                                print("description :\(dept["description"])")
                                
                                let jsonUser = dept["owner"]
                                print("nom user :\(jsonUser["login"])")
                                print("avatar :\(jsonUser["avatar_url"])")
                                
                                let name = dept["name"].string
                                let description = dept["description"].string
                                let etoile = dept["stargazers_count"].int
                                let user = jsonUser["login"].string
                                let avatar = jsonUser["avatar_url"].string
                                
                                print("nombre d'étoiles :\(String(describing: etoile))")
                                
                                let det = Depot(name: name ?? "", description: description ?? "", etoile: etoile ?? 0, user: user ?? "", avatar: avatar ?? "")
                                
                                self.depots.append(det)
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                    UIViewController.removeSpinne(spinner: self.sv!)
                                }
                                
                                
                            }
                    } catch {
                    }
                    
                } else {
                }
            })
            
            }.resume()
    }
    /* Fin */
    
    /* Pagination */
    func fetchPAgination(page:String){
        //Url api
        let url = URL(string: "\(Common.link_api_paignate+page)")!
        //
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        //let body = "q=created:%3E2017-10-22&sort=stars&order=desc"
        //request.httpBody = body.data(using: String.Encoding.utf8)
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            // get main queue to operations inside of this block
            DispatchQueue.main.async(execute: {
                
                // no error of accessing php file
                if error == nil {
                    
                    do {
                        
                        // declare new parseJSON to store json
                        let json = try JSON(data: data!)
                        
                        //print("Total count :\(json["total_count"]), items : \(json["items"].arrayValue)")
                        let depts = json["items"].arrayValue
                        for dept in depts {
                            let jsonUser = dept["owner"]
                            
                            let name = dept["name"].string
                            let description = dept["description"].string
                            let etoile = dept["stargazers_count"].int
                            let user = jsonUser["login"].string
                            let avatar = jsonUser["avatar_url"].string
                            
                            let det = Depot(name: name ?? "", description: description ?? "", etoile: etoile ?? 0, user: user ?? "", avatar: avatar ?? "")
                            
                            self.depots.append(det)
                            DispatchQueue.main.async {
                                print("nbr ligne :\(self.depots.count)")
                                self.tableView.reloadData()
                                //UIViewController.removeSpinne(spinner: self.sv!)
                            }
                            
                            
                        }
                    } catch {
                    }
                    
                } else {
                }
            })
            
            }.resume()
    }
    /* Fin*/
    /*=========================================================================*/
}


extension UIViewController {
    class func displaySpinne(onView : UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.8)
        let ai = UIActivityIndicatorView(style: .whiteLarge)
        ai.color = UIColor.black
        
        
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        return spinnerView
    }
    
    class func removeSpinne(spinner :UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
}

