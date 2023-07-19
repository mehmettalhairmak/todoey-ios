//
//  Category.swift
//  todoey
//
//  Created by Mehmet Talha Irmak on 14.07.2023.
//

import Foundation
import RealmSwift

class Category: Object {
    @Persisted var name: String = ""
    @Persisted var items = List<Item>()
}
