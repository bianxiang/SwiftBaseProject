//
//  RegexHelper.swift
//  zuber
//
//  Created by duzhe on 15/11/14.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import Foundation

//正则表达式
infix operator =~ {
    associativity none
    precedence 130
}
struct RegexHelper {
    let regex: NSRegularExpression?
    
    init(_ pattern: String) throws{
        regex = try NSRegularExpression(pattern: pattern,
        options: NSRegularExpression.Options.caseInsensitive)
    }
    
    func match(_ input: String) -> Bool {
        if let matches = regex?.matches(in: input,
            options: NSRegularExpression.MatchingOptions(),
            range: NSMakeRange(0, input.characters.count)) {
            return matches.count > 0
        } else {
            return false
        }
    }
    
}
func =~(lhs:String,rhs:String)->Bool{
    do {
        return try RegexHelper(rhs).match(lhs)
    } catch {
        return false
    }
}


//  /[~!@#$%^&\*()+=`\\\|\}\]\[\{;:\"'<,\.\?\/>]/  匹配到提示姓名错误

