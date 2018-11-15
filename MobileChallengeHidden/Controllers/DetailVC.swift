//
//  DetailVC.swift
//  MobileChallengeHidden
//
//  Created by imac dt on 15/11/2018.
//  Copyright © 2018 Libasse MBAYE. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    fileprivate let id = "DetailVC"
    let screenSize: CGRect = UIScreen.main.bounds
    var depot: Depot?
    /*=================================================*/
    var imgUser = UIImageView()
    var namuser = UILabel()
    var namedepot = UILabel()
    var desc = UILabel()
    /*=================================================*/

    override func viewDidLoad() {
        super.viewDidLoad()

        /*=================================================*/
        view.backgroundColor = UIColor.white
        /*=================================================*/
        imgUser.frame = CGRect(x:(screenSize.width - 90)/2,y:80,width:90,height:90)
        imgUser.layer.masksToBounds = false
        imgUser.layer.cornerRadius = imgUser.frame.height/2
        imgUser.clipsToBounds = true
        do {
            let url = URL(string: (depot!.avatar))
            
            
            imgUser.sd_setImage(with: url) { (image, error, cache, urls) in
                if (error != nil) {
                    self.imgUser.image = UIImage(named: "placeholder")
                } else {
                    self.imgUser.image = image
                }
            }
        }catch{
            print("Unexpected non-vending-machine-related error: \(error)")
        }
        view.addSubview(imgUser)
        
        namuser.frame = CGRect(x:(screenSize.width - 120)/2,y:180,width:120,height:35)
        namuser.textColor = UIColor.black
        namuser.numberOfLines = 2
        namuser.font = UIFont(name: "HelveticaNeue-Bold", size: 18.0)
        namuser.text = depot!.user
        view.addSubview(namuser)
        
        namedepot.frame = CGRect(x:20,y:230,width:screenSize.width - 30,height:40)
        namedepot.textColor = UIColor.black
        namedepot.numberOfLines = 2
        namedepot.font = UIFont(name: "HelveticaNeue-Bold", size: 18.0)
        namedepot.text = depot!.name
        view.addSubview(namedepot)
        
        desc.frame = CGRect(x:20,y:270,width:screenSize.width - 30,height:screenSize.height)
        desc.textColor = UIColor.black
        desc.textAlignment = .left
        desc.numberOfLines = 0
        desc.font = UIFont(name: "HelveticaNeue", size: 18.0)
        desc.text = depot!.description
        desc.sizeToFit()
        view.addSubview(desc)
    }

}
