//
//  NewsFeed.swift
//  AmsterdamMuseum
//
//  Created by James Bryan Graves on 10/02/15.
//  Copyright (c) 2015 James Bryan Graves. All rights reserved.
//

import Foundation

class NewsFeed {
	
	let requestURL = "http://hearushere.nl/cards.json"
	
	var cards: [Card]!
	var people: Dictionary<String, Person>!
	var zones: [BeaconZone]!
	
	init() {
		zones = []
		cards = []
		people = Dictionary()
	}
	
	func load(completionHandler:(NSError?) -> Void) {
		let fileURL = NSBundle.mainBundle().URLForResource("AmsterdamMuseum", withExtension: "json")
		if let data = NSData(contentsOfURL: fileURL!) {
			var error: NSError?
			var dict: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
			
			var cardDicts: NSArray = dict["cards"] as NSArray
			for cardDict in cardDicts {
				let card = Card(dict: cardDict as NSDictionary)
				self.cards.append(card)
			}
			
			var peopleDicts: NSArray = dict["people"] as NSArray
			for personDict in peopleDicts {
				let person = Person(dict: personDict as NSDictionary)
				self.people[person.id] = person
			}
			
			var zonesDict = dict["zones"] as NSDictionary
			for name in zonesDict.allKeys {
				var zoneDict = zonesDict[name as NSString] as NSDictionary
				let zone = BeaconZone(name: name as String, dict: zoneDict as NSDictionary)
				self.zones.append(zone)
			}
			
			completionHandler(nil)
		}
	}
}
