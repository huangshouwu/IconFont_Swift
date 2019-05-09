//
//  ViewController.swift
//  IconFontDemo_swift
//
//  Created by huang shervin on 2019/5/8.
//  Copyright © 2019年 huang shervin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let labelIconName:Array<String> = ["check-circle","CI","Dollar","compass"];
        var labelBottom:CGFloat = 150;
        
        let titleLabel:UILabel = UILabel.init(frame: CGRect.init(x: 0, y: labelBottom+10, width: UIScreen.main.bounds.size.width, height: 30));
        titleLabel.font = UIFont.systemFont(ofSize: 30);
        titleLabel.text = "这是swift版本的IconFont"
        titleLabel.textAlignment = NSTextAlignment.center
        self.view.addSubview(titleLabel)
        labelBottom = titleLabel.frame.maxY + 20
        
        for i in 0...(labelIconName.count-1) {
            let label:UILabel = UILabel.init(frame: CGRect.init(x: 20, y: labelBottom+10, width: UIScreen.main.bounds.size.width-40, height: 30));
            label.font = UIFont.init(name: SGTIconFontManager.fontName(), size: 20)
            label.text = String(format: "这是一个 %@ iconfont文本", SGTIconFontManager.IconFontName(name: labelIconName[i])!)
            self.view.addSubview(label);
            labelBottom = label.frame.maxY;
        }
        
        let imageIconName:Array<String> = ["icon4","icon7_hover","icon10","icon12"];
        labelBottom += 20;
        for i in 0...(imageIconName.count-1) {
            let image1:UIImageView = UIImageView.init(frame: CGRect.init(x: 20, y: labelBottom + 10, width: 30, height: 30))
            image1.image = SGTIconFontManager.IconFontName(name: imageIconName[i], size: 30, color: UIColor.orange)
            self.view.addSubview(image1)
            
            let image2:UIImageView = UIImageView.init(frame: CGRect.init(x: image1.frame.maxX + 20, y: image1.frame.minY, width: image1.frame.width, height: image1.frame.height))
            image2.image = SGTIconFontManager.IconFontName(name: imageIconName[i], size: 30, color: UIColor.red)
            self.view.addSubview(image2);
            
            let image3:UIImageView = UIImageView.init(frame: CGRect.init(x: image2.frame.maxX + 20, y: image1.frame.minY, width: image1.frame.width, height: image1.frame.height))
            image3.image = SGTIconFontManager.IconFontName(name: imageIconName[i], size: 30, color: UIColor.blue)
            self.view.addSubview(image3)
            labelBottom = image1.frame.maxY
        }
    }
}

