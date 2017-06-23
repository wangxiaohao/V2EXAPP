//
//  PublicFucn.swift
//  V2EXios
//
//  Created by 王浩 on 2017/6/20.
//  Copyright © 2017年 haowang. All rights reserved.
//

import Foundation


/**
 颜色编码
 
 - parameter hexString: string
 
 - returns: uicolor
 */
public func hexStringToColor(_ hexString: String) -> UIColor{
    var cString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    
    if cString.characters.count < 6 {return UIColor.black}
    if cString.hasPrefix("0X") {cString = cString.substring(from: cString.characters.index(cString.startIndex, offsetBy: 2))}
    if cString.hasPrefix("#") {cString = cString.substring(from: cString.characters.index(cString.startIndex, offsetBy: 1))}
    if cString.characters.count != 6 {return UIColor.black}
    
    var range: NSRange = NSMakeRange(0, 2)
    
    let rString = (cString as NSString).substring(with: range)
    range.location = 2
    let gString = (cString as NSString).substring(with: range)
    range.location = 4
    let bString = (cString as NSString).substring(with: range)
    
    var r: UInt32 = 0x0
    var g: UInt32 = 0x0
    var b: UInt32 = 0x0
    Scanner.init(string: rString).scanHexInt32(&r)
    Scanner.init(string: gString).scanHexInt32(&g)
    Scanner.init(string: bString).scanHexInt32(&b)
    
    return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: CGFloat(1))
    
}



/// 正则匹配
///
/// - Parameter str: <#str description#>
/// - Returns: <#return value description#>
public func regularTheString(str : NSMutableAttributedString)->NSTextCheckingResult?{
    
    let regular = "<img([^<]+)(/>)"
    let reg = try? NSRegularExpression(pattern: regular, options: [.caseInsensitive,.dotMatchesLineSeparators])
    let result  = reg?.firstMatch(in: str.string, options: [], range: NSRange(location: 0, length: (str.string as NSString).length))
    return result
}
public func regularTheUrl(str:NSMutableAttributedString)->[NSTextCheckingResult]{
   let urlregular = "(http|ftp|https):\\/\\/[\\w\\-_]+(\\.[\\w\\-_]+)+([\\w\\-\\.,@?^=%&amp;:/~\\+#]*[\\w\\-\\@?^=%&amp;/~\\+#])?"
   let reg = try? NSRegularExpression(pattern: urlregular, options: [.caseInsensitive,.dotMatchesLineSeparators])
   let result  = reg?.matches(in: str.string, options: [], range: NSRange(location: 0, length: (str.string as NSString).length))
    return result ?? []
    
}
