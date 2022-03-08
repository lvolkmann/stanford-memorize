//
//  MemorizeTheme.swift
//  Memorize
//
//  Created by Landon Volkmann on 2/27/22.
//

import Foundation

struct MemoryTheme<CardContent> where CardContent: Equatable {
    
    var name: String
    var contentSet: Array<CardContent>
    var numberOfPairs: Int
    var color: String
    var id: Int

}
