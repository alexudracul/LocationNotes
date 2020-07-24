//
//  Note+CoreDataProperties.swift
//  LocationNotes
//
//  Created by Aleksey Lavrukhin on 24.07.2020.
//  Copyright © 2020 Aleksey Lavrukhin. All rights reserved.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var title: String?
    @NSManaged public var textDescription: String?
    @NSManaged public var thumbnail: Data?
    @NSManaged public var dateUpdate: Date?
    @NSManaged public var folder: Folder?
    @NSManaged public var location: Location?
    @NSManaged public var noteImage: NoteImage?

}
