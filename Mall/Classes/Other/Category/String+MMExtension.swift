//
//  String+MMExtension.swift
//  Mall
//
//  Created by iOS on 2022/5/25.
//

import UIKit
import YYKit

extension String {

    /// 判断是否包含某字符
    func contains(find: String) -> Bool{
        return self.range(of: find) != nil
    }
        
    func containsIgnoringCase(find: String) -> Bool{
        return self.range(of: find, options: .caseInsensitive) != nil
    }
    
    /// 判断字符串是不是数字
    func isPurnInt() -> Bool {
        let scan: Scanner = Scanner(string: self)
        var val:Int = 0
        return scan.scanInt(&val) && scan.isAtEnd
    }
    
    /*
     *去掉首尾空格
     */
    func removeHeadAndTailSpace() ->String{
        let whitespace = NSCharacterSet.whitespaces
        return self.trimmingCharacters(in: whitespace)
    }
    
    
    /*
     *去掉首尾空格 包括后面的换行 \n
     */
    func removeHeadAndTailSpacePro() ->String{
        let whitespace = NSCharacterSet.whitespacesAndNewlines
        return self.trimmingCharacters(in: whitespace)
    }
    
    
    /*
     *去掉所有空格
     */
    func clearBlankString() ->String{
        return self.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
    }
    
    
    /* 字母、数字、中文正则判断（包括空格）（在系统输入法中文输入时会出现拼音之间有空格，需要忽略，当按return键时会自动用字母替换，按空格输入响应汉字）
    */
    func isInputRuleAndBlank()->Bool{
        let pattern = "^[a-zA-Z\\u4E00-\\u9FA5\\d\\s]*$"
        let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
        let isMatch = pred.evaluate(with: self)
        return isMatch
    }
    
    /**
     *  过滤字符串中的emoji
     */
    func disable_emoji()->String{
        let regex = try!NSRegularExpression.init(pattern: "[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]", options: .caseInsensitive)
        
        let modifiedString = regex.stringByReplacingMatches(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSRange.init(location: 0, length: self.count), withTemplate: "")
        return modifiedString
    }
}
