//
//  NoteImage+CoreDataProperties.swift
//  LocationNotes
//
//  Created by Aleksey Lavrukhin on 24.07.2020.
//  Copyright © 2020 Aleksey Lavrukhin. All rights reserved.
//
//

import Foundation
import CoreData


extension NoteImage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NoteImage> {
        return NSFetchRequest<NoteImage>(entityName: "NoteImage")
    }

    @NSManaged public var image: Data?
    @NSManaged public var note: Note?

}
