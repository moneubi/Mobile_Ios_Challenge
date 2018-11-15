//
//  DepotCell.swift
//  MobileChallengeHidden
//
//  Created by imac dt on 15/11/2018.
//  Copyright © 2018 Libasse MBAYE. All rights reserved.
//
import UIKit
import SDWebImage


class DepotCell: UITableViewCell {
    let screenSize: CGRect = UIScreen.main.bounds
    var imguser = UIImageView()
    var imgstart = UIImageView()
    var txt_name = UILabel()
    var txt_user = UILabel()
    var txt_description = UILabel()
    var txt_etoile = UILabel()
    var view = UIView();
    var viewRond = UIView()
    var viewStart = UIView();
    var calculEtoile: Float = 0.0
    
    func setDepot(dept: Depot){
        
        do {
            let url = URL(string: (dept.avatar))
            
            
            imguser.sd_setImage(with: url) { (image, error, cache, urls) in
                if (error != nil) {
                    self.imguser.image = UIImage(named: "placeholder")
                } else {
                    self.imguser.image = image
                }
            }
        }catch{
            print("Unexpected non-vending-machine-related error: \(error)")
        }
        txt_name.text = dept.name
        txt_user.text = dept.user
        txt_description.text = dept.description
        
        let nbretoile = dept.etoile
        calculEtoile = Float(nbretoile/1000)
        txt_etoile.text = "\(calculEtoile)"
        //txt_description.sizeToFit()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        viewRond.frame = CGRect(x:0,y:0,width:screenSize.width,height:250)
        viewRond.backgroundColor = UIColor(red:CGFloat(221/255.0), green:CGFloat(221/255.0), blue:CGFloat(221/255.0), alpha:1.0)
        addSubview(viewRond)
        
        view.frame = CGRect(x:0,y:0,width:screenSize.width,height:240)
        view.backgroundColor = UIColor.white
        viewRond.addSubview(view)
        
        txt_name.frame = CGRect(x:15,y:25,width:screenSize.width - 35,height:35)
        txt_name.textColor = UIColor.black
        txt_name.numberOfLines = 2
        txt_name.font = UIFont(name: "HelveticaNeue-Bold", size: 18.0)
        view.addSubview(txt_name)
        
        txt_description.frame = CGRect(x:15,y:65,width:screenSize.width - 35,height:105)
        txt_description.textColor = UIColor.black
        txt_description.textAlignment = .left
        txt_description.numberOfLines = 5
        txt_description.font = UIFont(name: "HelveticaNeue", size: 18.0)
        view.addSubview(txt_description)
        
        imguser.frame = CGRect(x:15,y:185,width:40,height:40)
        imguser.layer.masksToBounds = false
        imguser.layer.cornerRadius = imguser.frame.height/2
        imguser.clipsToBounds = true
        view.addSubview(imguser)
        
        /* Name user */
        txt_user.frame = CGRect(x:65,y:194,width:200,height:25)
        txt_user.textColor = UIColor.black
        txt_user.numberOfLines = 1
        txt_user.font = UIFont(name: "HelveticaNeue-Bold", size: 18.0)
        view.addSubview(txt_user)
        /* Fin */
        
        viewStart.frame = CGRect(x:265,y:185,width:screenSize.width - 280,height:40)
        view.addSubview(viewStart)
        
        imgstart.frame = CGRect(x:30,y:10,width:20,height:20)
        imgstart.clipsToBounds = true
        self.imgstart.image = UIImage(named: "start")
        viewStart.addSubview(imgstart)
        
        txt_etoile.frame = CGRect(x:58,y:10,width:60,height:25)
        txt_etoile.textColor = UIColor.black
        txt_etoile.numberOfLines = 1
        txt_etoile.font = UIFont(name: "HelveticaNeue-Bold", size: 18.0)
        viewStart.addSubview(txt_etoile)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
