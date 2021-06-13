//
//  Week.swift
//  UI-234
//
//  Created by にゃんにゃん丸 on 2021/06/13.
//

import SwiftUI

struct Week:Identifiable  {
    var id = UUID().uuidString
    
    var day : String
    var date : String
    var amountSpent : CGFloat
}

