//
//  Review+CoreDataClass.swift
//  Bookworm
//
//  Created by Zaid Neurothrone on 2022-12-10.
//
//

import CoreData
import Foundation

@objc(Review)
public class Review: NSManagedObject {
  @nonobjc public class func fetchRequest() -> NSFetchRequest<Review> {
    return NSFetchRequest<Review>(entityName: String(describing: Review.self))
  }

  @NSManaged public var id: Int32
  @NSManaged public var author: String
  @NSManaged public var title: String
  @NSManaged public var text: String
  @NSManaged public var rating: Int32

}

extension Review : Identifiable {}
