//
//  ViewController.swift
//  SwiftScreenImage
//
//  Created by 云中科技 on 2017/11/22.
//  Copyright © 2017年 云中科技. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.blue;    
        
        
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        _ = self.screenSnapshot(save: true);
    }
    
    
    //获取屏幕截图 需要关心一下最上层是谁   
    func screenSnapshot(save: Bool) -> UIImage? {
        
        guard let window = UIApplication.shared.keyWindow else { return nil }
        
        // 用下面这行而不是UIGraphicsBeginImageContext()，因为前者支持Retina
        UIGraphicsBeginImageContextWithOptions(window.bounds.size, false, 0.0)
        
        window.layer.render(in: UIGraphicsGetCurrentContext()!)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        if save { UIImageWriteToSavedPhotosAlbum(image!, self, nil, nil) }
        
        return image
    }
    //不用关心最上层是那个view   直接截取的是最上层的
    func screenSnapshot2(save: Bool) -> UIImage? {
        let windown = UIApplication.shared.delegate?.window
        
        // 01 开启图片上下文
        UIGraphicsBeginImageContextWithOptions((windown?!.bounds.size)!, true, UIScreen.main.scale)
        //afterScreenUpdates如果是true, 则是addSubview之后,  如果是false,则是addSubview之前
        windown??.drawHierarchy(in: (windown??.bounds)!, afterScreenUpdates: true)
        // 获取图片
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        // 关闭图片上下文
        UIGraphicsEndImageContext()
        
        //  将图片存储到本地
        if save { UIImageWriteToSavedPhotosAlbum(image!, self, nil, nil) }
        
        return image
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

