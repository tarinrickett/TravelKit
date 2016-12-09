//
//  SavedData.swift
//  Project
//
//  Created by Tarin Rickett on 11/26/16.
//  Copyright © 2016 Mobile Application Development. All rights reserved.
//

import UIKit

class SavedData: NSObject, NSCoding {
    
    //keys
    static let suggestedToDosKey = "suggestedToDos"
    static let todosKey = "todos"
    static let suggestedToGosKey = "suggestedToGos"
    static let togosKey = "togos"
    static let ticketBookKey = "ticketBook"
    static let photoJournalKey = "photoJournal"
    static let nameKey = "name"
    
    //varbs
    var suggestedToDos: [SuggestedToDoItem]
    var todos: [ToDoItem]
    var suggestedToGos: [SuggestedToGoItem]
    var togos: [ToGoItem]
    var ticketBook: [TicketItem]
    var photoJournal: [PhotoItem]
    var name: String
    
    //defaults
    override init() {
        suggestedToDos = []
        todos = []
        suggestedToGos = []
        togos = []
        ticketBook = []
        photoJournal = []
        name = ""
    }
    
    //decodes
    required init(coder aDecoder: NSCoder) {
        suggestedToDos = aDecoder.decodeObject(forKey: SavedData.suggestedToDosKey) as! [SuggestedToDoItem]
        todos = aDecoder.decodeObject(forKey: SavedData.todosKey) as! [ToDoItem]
        suggestedToGos = aDecoder.decodeObject(forKey: SavedData.suggestedToGosKey) as! [SuggestedToGoItem]
        togos = aDecoder.decodeObject(forKey: SavedData.togosKey) as! [ToGoItem]
        ticketBook = aDecoder.decodeObject(forKey: SavedData.ticketBookKey) as! [TicketItem]
        photoJournal = aDecoder.decodeObject(forKey: SavedData.photoJournalKey) as! [PhotoItem]
        name = aDecoder.decodeObject(forKey: SavedData.nameKey) as! String
    }
    
    //encodes
    func encode(with aCoder: NSCoder) {
        aCoder.encode(suggestedToDos, forKey: SavedData.suggestedToDosKey)
        aCoder.encode(todos, forKey: SavedData.todosKey)
        aCoder.encode(suggestedToGos, forKey: SavedData.suggestedToGosKey)
        aCoder.encode(togos, forKey: SavedData.togosKey)
        aCoder.encode(ticketBook, forKey: SavedData.ticketBookKey)
        aCoder.encode(photoJournal, forKey: SavedData.photoJournalKey)
        aCoder.encode(name, forKey: SavedData.nameKey)
    }
    
}

