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
    var imageActual: UIImage? {
        set {
            if newValue == nil {
                if self.noteImage != nil {
                    CoreDataManager.sharedInstance.managedObjectContext.delete(self.noteImage!)
                }
                self.noteImage = nil
            } else {
                if self.noteImage == nil {
                    self.noteImage = NoteImage(context: CoreDataManager.sharedInstance.managedObjectContext)
                }
                self.noteImage?.image = newValue!.jpegData(compressionQuality: 1)
                self.thumbnail = newValue!.jpegData(compressionQuality: 0.1)
            }
        }
        get {
            if self.noteImage != nil && noteImage?.image != nil {
                return UIImage(data: self.noteImage!.image! as Data)
            }
            return nil
        }
    }
    
    var dateUpdateString: String {
        let df = DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .short
        return df.string(from: self.dateUpdate!)
    }
    
    class func newNote(title: String, inFolder: Folder?) -> Note {
        let newNote = Note(context: CoreDataManager.sharedInstance.managedObjectContext)
        newNote.title = title
        newNote.folder = inFolder
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
