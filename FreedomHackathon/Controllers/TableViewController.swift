//
//  TableViewController.swift
//  FreedomHackathon
//
//  Created by Alikhan Kopzhanov on 10.11.2024.
//

import UIKit

class TableViewController: UITableViewController {
    
    let colorRed = UIColor.red
    let colorGreen = UIColor.green
    var spec = ""
    var CVarray:[CV] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = spec
    }
    
        // MARK: - Table view data source
        
        override func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 1
        }
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            return CVarray.count
        }
        
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            
            let nameLabel = cell.viewWithTag(1000) as! UILabel
            nameLabel.text = CVarray[indexPath.row].fullName
            
            let locationLabel = cell.viewWithTag(1001) as! UILabel
            locationLabel.text = CVarray[indexPath.row].country
            
            let skillLabel = cell.viewWithTag(1002) as! UILabel
            skillLabel.text = CVarray[indexPath.row].skills
            
            let circleView = cell.viewWithTag(1003)!
            circleView.layer.cornerRadius = circleView.layer.bounds.width / 2
            circleView.layer.borderWidth = 1.0
            circleView.clipsToBounds = true
            
            let percentageLabel = cell.viewWithTag(1004) as! UILabel
            percentageLabel.text = CVarray[indexPath.row].percent
            
            let percentageInt = Int((CVarray[indexPath.row].percent).dropLast())!
            percentageLabel.textColor = colorRed.toColor(colorGreen, percentage: CGFloat((percentageInt)))
            
            circleView.layer.borderColor = colorRed.toColor(colorGreen, percentage: CGFloat((percentageInt))).cgColor
            
            return cell
        }
        
        override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 130
        }
        
        //    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        let movieInfoVC = storyboard?.instantiateViewController(withIdentifier: "MovieInfoViewController") as! MovieInfoViewController
        //
        //        movieInfoVC.movie = movies[indexPath.row]
        //
        //        navigationController?.show(movieInfoVC, sender: self)
        //    }
        
    }
    
    extension UIColor {
        func toColor(_ color: UIColor, percentage: CGFloat) -> UIColor {
            let percentage = max(min(percentage, 100), 0) / 100
            switch percentage {
            case 0: return self
            case 1: return color
            default:
                var (r1, g1, b1, a1): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
                var (r2, g2, b2, a2): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
                guard self.getRed(&r1, green: &g1, blue: &b1, alpha: &a1) else { return self }
                guard color.getRed(&r2, green: &g2, blue: &b2, alpha: &a2) else { return self }

                return UIColor(red: CGFloat(r1 + (r2 - r1) * percentage),
                               green: CGFloat(g1 + (g2 - g1) * percentage),
                               blue: CGFloat(b1 + (b2 - b1) * percentage),
                               alpha: CGFloat(a1 + (a2 - a1) * percentage))
            }
        }
    }
