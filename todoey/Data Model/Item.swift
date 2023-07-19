//
//  Item.swift
//  todoey
//
//  Created by Mehmet Talha Irmak on 26.06.2023.
//

import Foundation

class Item: Encodable, Decodable {
    var title: String = "New Item"
    var done: Bool = false
}
