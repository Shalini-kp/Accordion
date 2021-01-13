//
//  ViewController.swift
//  Accordian
//
//  Copyright © 2018 Shalini. All rights reserved.
//

import UIKit

class AccordianViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var accordianTableView: UITableView!
    
    var activityArray = [String:[String]]()
    var activity_Array = [String]()
    var arrayForBool:NSMutableArray = ["0","0","0","0","0"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityArray=["A":["a","b"],"B":["c"],"C":["d"],"D":["e","f","g"]]
        activity_Array = ["A","B","C","D"]
        
        accordianTableView.tableFooterView = UIView()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.activityArray.keys.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (arrayForBool.object(at: section) as AnyObject).boolValue == true
        {
            return (self.activityArray[activity_Array[section]]?.count)!
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 58
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (arrayForBool.object(at: indexPath.section) as AnyObject).boolValue == true {
            return 62
        }
        return 0;
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        var height = 2
        
        if section == (activity_Array.count - 1) {
            height = 0
        }
        return CGFloat(height)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let head = UITableViewHeaderFooterView()
        let headerView = UIView(frame: CGRect(x:0, y:0, width:accordianTableView.frame.size.width, height:60))
        headerView.layer.borderColor = UIColor.darkGray.cgColor
        headerView.layer.cornerRadius = 20.0
        headerView.layer.borderWidth = 0.2
//        headerView.layer.masksToBounds = false
        headerView.clipsToBounds = true
        headerView.tag = section
        
        let headerString = UILabel(frame: CGRect(x: 20, y: 10, width: accordianTableView.frame.size.width, height: 40)) as UILabel
        headerString.text = activity_Array[section]
        headerString.textColor = UIColor.black
        headerString.font = UIFont(name: "DIN Alternate", size: 18.0)
        headerView.addSubview(headerString)
        
        //   let collapsed : Bool! = (arrayForBool.object(at: section) as AnyObject).boolValue
        //        if collapsed == true {
        //            // headerView.frame = CGRect(x:accordianTableView.frame.origin.x + 15, y:20, width:accordianTableView.frame.size.width - 30, height:55)
        //            headerString.textColor = UIColor.white
        //            headerString.font =  UIFont(name: "DIN Alternate", size: 19.0)
        //            headerView.backgroundColor = UIColor.probitecColor
        //            headerView.layer.borderColor = UIColor.white.cgColor
        //            let imageView = UIImageView(frame: CGRect(x: accordianTableView.frame.size.width - 90, y: 22, width: 17, height: 10))
        //            imageView.image = resizeImageWithAspect(image: UIImage(named: "upArrow")!, scaledToMaxWidth: 17, maxHeight: 10)
        //            headerView.addSubview(imageView)
        //        } else {
        //   headerView.frame = CGRect(x:accordianTableView.frame.origin.x, y:0, width:accordianTableView.frame.size.width - 30, height:55)
        
        //headerView.layer.borderWidth = 1.2
        //headerView.layer.borderColor = UIColor.white.cgColor
        
        //need to check
        let imageView = UIImageView()
        imageView.image = UIImage(named: "RightArrowWhite")!
        let collapsed : Bool! = (arrayForBool.object(at: section) as AnyObject).boolValue
        if collapsed == false {
            headerView.backgroundColor = UIColor.white
            imageView.transform = imageView.transform.rotated(by: 0)
            imageView.frame = CGRect(x: accordianTableView.frame.size.width - 50, y: 20, width: 20, height: 20)
        } else {
            UIView.animate(withDuration: 0.2, animations: {
                imageView.frame = CGRect(x: self.accordianTableView.frame.size.width - 45, y: 20, width: 20, height: 20)
                imageView.transform = imageView.transform.rotated(by: (CGFloat.pi / 2))
            })
        }
        
        headerView.addSubview(imageView)
        
        let headerTapped = UITapGestureRecognizer (target: self, action:#selector(sectionHeaderTapped))
        headerView.addGestureRecognizer(headerTapped)
        
        head.addSubview(headerView)
        return head
    }
    
    @objc func sectionHeaderTapped(recognizer: UITapGestureRecognizer) {
        print("Tapping working")
        let indexPath : NSIndexPath = NSIndexPath(row: 0, section:(recognizer.view?.tag as Int?)!)
        if (indexPath.row == 0) {
            for (index,_) in arrayForBool.enumerated() {
                if ((arrayForBool.object(at: index) as AnyObject).boolValue == true) && (index != (recognizer.view?.tag as Int?)!){
                    self.arrayForBool[index] = false
                }
            }
            accordianTableView.reloadData()
            var collapsed : Bool! = (arrayForBool.object(at: indexPath.section) as AnyObject).boolValue
            collapsed = !collapsed;
            arrayForBool.replaceObject(at: indexPath.section, with: collapsed)
            
            //reload specific section animated
            let range = NSMakeRange(indexPath.section, 1)
            let sectionToReload = NSIndexSet(indexesIn: range)
            
            if collapsed == true && !(activityArray[activity_Array[indexPath.section]]?.isEmpty)!{
                self.accordianTableView.reloadSections(sectionToReload as IndexSet, with:UITableView.RowAnimation.automatic)
                self.accordianTableView.scrollToRow(at: indexPath as IndexPath, at: .top, animated: true)
            } else {
                UIView.animate(withDuration: 0.1, animations: {
                    self.accordianTableView.scrollsToTop = true
                })
            }
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "accordianTableCellId", for: indexPath) as! AccordianTableViewCell
        
        let manyCells : Bool = (arrayForBool.object(at: indexPath.section) as AnyObject).boolValue
        
        if manyCells {
            
            cell.accordianTitleText.text = "\((activityArray[activity_Array[indexPath.section]])?[indexPath.row] ?? "")"
//            let cellSectionCount = activityArray[activity_Array[indexPath.section]]?.count ?? 0
            
//            if (indexPath.last != (cellSectionCount - 1)) {
//                let progress = UIProgressView(frame: CGRect(x: 0, y: 70, width: accordianTableView.frame.size.width, height: 6))
//                progress.tintColor = UIColor.white
//                cell.contentView.addSubview(progress)
//            }
        }
        
        return cell
    }

}

