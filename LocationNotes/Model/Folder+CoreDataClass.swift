//
//  Folder+CoreDataClass.swift
//  LocationNotes
//
//  Created by Aleksey Lavrukhin on 24.07.2020.
//  Copyright © 2020 Aleksey Lavrukhin. All rights reserved.
//
//

import Foundation
import CoreData


public class Folder: NSManagedObject {
    class func newFolder(title: String) -> Folder {
        let newFolder = Folder(context: CoreDataManager.sharedInstance.managedObjectContext)
        newFolder.title = title
        
        return newFolder
    }
    
    func addNote() -> Note {
        let newNote = Note(context: CoreDataManager.sharedInstance.managedObjectContext)
        newNote.title = title
        newNote.dateUpdate = NSDate() as Date
        newNote.folder = self
        
        return newNote
    }

}
 
