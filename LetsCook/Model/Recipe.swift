//
//  Recipe.swift
//  LetsCook
//
//  Created by Anu Agrawal on 5/9/21.
//

import Foundation
struct Recipe{
    var title:String?
    var ingredients:String?
    var thumbnail:String?
    var link:String?
    init(data dict:[String:Any]) {
        self.title = dict["title"] as? String ?? "NO TITLE"
        self.ingredients = dict["ingredients"] as? String ?? "NO INGREDIENTS"
        self.thumbnail = dict["thumbnail"] as? String ?? "NO IMAGE"
        self.link = dict["href"] as? String ?? ""
    }
}
