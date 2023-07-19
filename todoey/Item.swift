//
//  Item.swift
//  todoey
//
//  Created by Mehmet Talha Irmak on 14.07.2023.
//

import Foundation
import RealmSwift

class Item: Object {
    @Persisted var title: String = ""
    @Persisted var done: Bool = false
    @Persisted var dateCreated: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
