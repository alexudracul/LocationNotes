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
    var notesSorted: [Note] {
        let sd = NSSortDescriptor.init(key: "dateUpdate", ascending: false)
        return self.notes?.sortedArray(using: [sd]) as! [Note]
    }
    
    class func newFolder(title: String) -> Folder {
        let newFolder = Folder(context: CoreDataManager.sharedInstance.managedObjectContext)
        newFolder.title = title
        
        return newFolder
    }
}
 
