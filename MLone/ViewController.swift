//
//  ViewController.swift
//  MLone
//
//  Created by eric on 2018/12/21. working...
//  Copyright © 2018 eric. All rights reserved.
//

import UIKit
import MaLiang

class ViewController: UIViewController {

    weak var canvas: Canvas!
    
    func getDateTime() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd HHmmss"
        return dateFormatter.string(from: date)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        print(getDateTime())
        print(NSHomeDirectory())
        
        let c = Canvas(frame: CGRect(x: 0, y: 0, width: 1024, height: 1024))
        //let c = Canvas(frame: CGRect(x: 0, y: 0, width: 2048, height: 2048))
        view.addSubview(c)
        view.sendSubviewToBack(c)
        canvas = c
        
        do {
            try canvas.setupDocument()
        } catch {
            let alert = UIAlertController(title: "Error!", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        // add pen/size/force
        let image = UIImage(named: "water-pen.png")
        let waterpen = Brush(texture: image!)
        canvas.brush = waterpen
        canvas.brush.pointSize = 20
        canvas.brush.forceSensitive = 0.5 // 0-1

    }


}

