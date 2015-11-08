//
//  Form.swift
//  UPROPE
//
//  Created by Computer on 11/7/15.
//  Copyright © 2015 Computer. All rights reserved.
//

import Foundation

class Form {
    
    
    var respondent: Party
    var petitioner: Party
    var dateMarried: NSDate
    var cityMarried:String
    var stateMarried: String
    var brokenMarriage: Bool
    var separation: Separation?
    var children: [Child]?
    
    
    init(respondent: Party, petitioner: Party, dateMarried: NSDate, cityMarried: String, stateMarried: String, brokenMarriage: Bool, separation: Separation?, children: [Child]?) {
        
        self.respondent = respondent
        self.petitioner = petitioner
        self.dateMarried = dateMarried
        self.cityMarried = cityMarried
        self.stateMarried = stateMarried
        self.brokenMarriage = brokenMarriage
        self.separation = separation
        self.children = children
        
    }

}


class Separation {
    var date: NSDate
    var moved: Bool?
    var divided: Bool?
    var filed: Bool?
    var agreed: Bool?
    var other: String?
    
    init(date: NSDate, moved: Bool, divided: Bool, filed: Bool, agreed: Bool, other: String) {
        self.date = date
        self.moved = moved
        self.divided = divided
        self.filed = filed
        self.agreed = agreed
        self.other = other
    }
}

class Party {
    var firstName: String
    var lastName: String
    var birthDate: NSDate
    var lastKnownState: String
    var lastKnownCounty: String
    var partyType: String
    
    init(firstName: String, lastName: String, birthDate: NSDate, lastKnownState: String, lastKnownCounty: String, partyType: String) {
        
        self.firstName = firstName
        self.lastName = lastName
        self.birthDate = birthDate
        self.lastKnownState = lastKnownState
        self.lastKnownCounty = lastKnownCounty
        self.partyType = partyType
    }
}

class Child {
    var firstName: String
    var lastName: String
    var age: Int
    var legalParents: [Party]
    
    init(firstName: String, lastName: String, age: Int, legalParents: [Party]) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        self.legalParents = legalParents
    }
}

class Jurisdiction {

    var respLivesWA: Bool?
    var bothLivedWAPetRemains: Bool?
    var petMilitary: Bool?
    var petAndRepConceiveChildWA: Bool?
    var otherJurisReason: String?

    init(respLivesWA: Bool?, bothLivedWAPetRemains: Bool?, petMilitary: Bool?, petAndRepConceiveChildWA: Bool?, otherJurisReason: String?) {
        self.respLivesWA = respLivesWA
        self.bothLivedWAPetRemains = bothLivedWAPetRemains
        self.petMilitary = petMilitary
        self.petAndRepConceiveChildWA = petAndRepConceiveChildWA
        self.otherJurisReason = otherJurisReason
    }

}

class Property {
    
    var petitionProperty: [String]
    var respondentProperty: [String]
    var otherProperty: [String]
    
    init(petitionProperty: [String]?,respondentProperty: [String]?,otherProperty: [String]?) {
        if let petitionProperty = petitionProperty
        {
            self.petitionProperty = petitionProperty
        } else {
            self.petitionProperty = []
        }
        if let respondentProperty = respondentProperty
        {
            self.respondentProperty = respondentProperty
        } else {
            self.respondentProperty = []
        }

        if let otherProperty = otherProperty
        {
            self.otherProperty = otherProperty
        } else {
            self.otherProperty = []
        }
    }
}
