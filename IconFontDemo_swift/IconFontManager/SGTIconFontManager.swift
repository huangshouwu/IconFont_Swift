//
//  SGTIconFontManager.swift
//  SGT
//
//  Created by huang shervin on 2019/5/6.
//  Copyright © 2019年 huang shervin. All rights reserved.
//

import UIKit

private var _manager:SGTIconFontManager?

class SGTIconFontManager: NSObject {
    
    class func manager() -> SGTIconFontManager{
        if _manager == nil {
            _manager = SGTIconFontManager.init()
        }
        return _manager!
    }
    
    /** iconfont下载地址：https://www.iconfont.cn/collections/index?spm=a313x.7781069.1998910419.3 */
    lazy var iconFontDictionary: Dictionary<String,String> = {
        let dic:Dictionary<String,String> = SGTIconFontManager.iconFontDictionaryWithURL(fileURL: URL.init(fileURLWithPath: Bundle.main.path(forResource: "demo_index", ofType: "html")!))
        return dic
    }()
    
    class func configIconFont() -> Void{
        TBCityIconFont.setFontName(SGTIconFontManager.fontName())
    }
    
    class func fontName() -> String! {
        return "iconfont"
    }
    
    class func IconFontName(name:String!,size:Int,color:UIColor) -> UIImage?{
       return UIImage.icon(with: TBCityIconInfo.init(text: SGTIconFontManager.IconFontName(name: name), size: size, color: color))
    }
    
    class func IconFontName(name:String!) ->String? {
        let dic = SGTIconFontManager.manager().iconFontDictionary
        if dic.count != 0{
            return dic[name]
        }else {
            return ""
        }
    }
    
    class func iconFontDictionaryWithURL(fileURL:URL) ->Dictionary<String,String>! {
        var resultDic:Dictionary<String,String> = Dictionary.init()
        
        var htmlData:Data?
        do {
            try htmlData = Data.init(contentsOf: fileURL)
        }catch{
            
        }
        if htmlData != nil {
            let htmlParser = TFHpple.init(htmlData: htmlData!)
            let result:Array<TFHppleElement>? = (htmlParser?.search(withXPathQuery: "//div[@class='content unicode']") as! Array<TFHppleElement>)
            if result != nil && result!.count > 0 {
                for item in result! {
                    var subArray:Array<TFHppleElement>? = (item.children(withClassName: "icon_lists dib-box") as? Array<TFHppleElement>)
                    if subArray != nil && (subArray?.count)! > 0{
                        subArray = subArray?.first!.children(withClassName: "dib") as? Array<TFHppleElement>
                        for subItem in subArray! {
                            let names:Array<TFHppleElement>? = (subItem.children(withClassName: "name") as? Array<TFHppleElement>)
                            let codes:Array<TFHppleElement>? = (subItem.children(withClassName: "code-name") as? Array<TFHppleElement>)
                            if names != nil && codes != nil {
                                let name = names![0].firstChild.content
                                let code = codes![0].firstChild.content
                                resultDic[name!] = SGTIconFontManager.UXxxxFrom(xxx: code!)
                            }
                        }
                    }
                }
            }
        }
        return resultDic
    }
    
    /**
     将16进制数
     在线编码解码网址：http://bianma.55cha.com
     在线进制转换网址：http://tool.oschina.net/hexconvert/
     */
    class func UXxxxFrom(xxx:String?) -> String?{
        if xxx?.contains("&#x") != false{
            var tempXXX = xxx?.replacingOccurrences(of: "&#x", with: "")
            tempXXX = tempXXX?.replacingOccurrences(of: ";", with: "")
            let s_10:UTF32Char = UTF32Char(strtoul(tempXXX?.cString(using: String.Encoding.utf8), nil, 16));//16进制转10进制
            let new_s = SGTIconFontManager.stringForIcon(char32: s_10)
            
            return new_s;
        }else {
            return xxx;
        }
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////
    //此处参考 http://www.it1352.com/853009.html
    class func stringForIcon(char32:UTF32Char) -> String?{
        if (char32 & 0xFFFF0000) != 0{
            return SGTIconFontManager.stringFromUTF32Char(char32: char32);
        }else {
            return SGTIconFontManager.stringFromUTF16Char(char16: (UInt16(char32 & 0xFFFF)));
        }
    }
    
    class func stringFromUTF32Char(char32:UTF32Char) -> String?{
        let new_char32:UTF32Char = char32 - 0x10000
        var highSurrogate:unichar = (unichar)(new_char32 >> 10); // leave the top 10 bits
        highSurrogate += 0xD800;
        var lowSurrogate:unichar = unichar(char32 & 0x3FF); // leave the low 10 bits
        lowSurrogate += 0xDC00;
        return NSString.init(characters: [highSurrogate,lowSurrogate], length: 1) as String
    }
    
    class func stringFromUTF16Char(char16:UTF16Char) -> String{
        return NSString.init(characters:([char16] ) , length: 1) as String
    }
    ////////////////////////////////////////////////////////////////////////////////////////
    
}
