//
//  Data.swift
//  todoey
//
//  Created by Mehmet Talha Irmak on 14.07.2023.
//

import Foundation
import RealmSwift

class Data: Object {
    @Persisted var name: String = ""
    @Persisted var age: Int = 0
}
