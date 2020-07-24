//
//  Note+CoreDataClass.swift
//  LocationNotes
//
//  Created by Aleksey Lavrukhin on 24.07.2020.
//  Copyright © 2020 Aleksey Lavrukhin. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit


public class Note: NSManagedObject {
    class func newNote(title: String) -> Note {
        let newNote = Note(context: CoreDataManager.sharedInstance.managedObjectContext)
        newNote.title = title
        newNote.dateUpdate = NSDate() as Date
        
        return newNote
    }
    
    func addImage(image: UIImage) {
        let noteImage = NoteImage(context: CoreDataManager.sharedInstance.managedObjectContext)
        noteImage.image = image.jpegData(compressionQuality: 1)
        
        self.noteImage = noteImage
    }
    
    func addLocation(lat: Double, lon: Double) {
        let location = Location(context: CoreDataManager.sharedInstance.managedObjectContext)
        location.latitude = lat
        location.longitude = lon
        
        self.location = location
    }
}
