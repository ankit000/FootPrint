//
//  MyJourneyHelper.swift
//  Footprint
//
//  Created by Abhinay Maurya on 09/12/16.
//  Copyright © 2016 ONS. All rights reserved.
//

import Foundation

struct MyJourney
{
    let title:String!
    let subTitle:String!
    let myWork:[[String:String]]!
    let section1:[String:String]!
    let section2:[String:String]!
    let imageURL:String?
}

final class MyJourneyHelper
{
    static let dataSource = MyJourney(title: "My Journey", subTitle: "Is the very legacy of footprint", myWork: [
            ["title":"500+","subtitle":"Designes"],
            ["title":"5000+","subtitle":"Customers"],
            ["title":"100K+","subtitle":"Pair of shoe"],
            ["title":"Many million memories","subtitle":""]
        ],
        section1: [Key.Question:"Who am I", Key.Description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."], section2: [Key.Question:"How I started", Key.Description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."], imageURL:"")
}

extension MyJourneyHelper
{
    struct Key {
        static let Question = "question"
        static let Description = "description"
    }
}
