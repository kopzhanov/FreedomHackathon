//
//  CV.swift
//  FreedomHackathon
//
//  Created by Alikhan Kopzhanov on 10.11.2024.
//

import Foundation
import SwiftyJSON

class CV {
    var fullName = ""
    var birthDate = ""
    var country = ""
    var education = ""
    var percent = ""
    var conformity = ""
    var experience = ""
    var skills = ""
    var link = ""
    
    init(json:JSON) {
        if let temp = json["full_name"].string{
            self.fullName = temp
        }
        if let temp = json["birth_date"].string{
            self.birthDate = temp
        }
        if let temp = json["country"].string{
            self.country = temp
        }
        if let temp = json["education"].string{
            self.education = temp
        }
        if let temp = json["percent_appropriate"].string{
            self.percent = temp
        }
        if let temp = json["conformity_assessment"].string{
            self.conformity = temp
        }
        if let temp = json["experience"].string{
            self.experience = temp
        }
        if let temp = json["high_skills"].string{
            self.skills  = temp
        }
        if let temp = json["resume_link"].string{
            self.link = temp
        }
        
    }
}

