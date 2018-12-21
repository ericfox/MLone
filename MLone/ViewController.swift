//
//  ViewController.swift
//  MLone
//
//  Created by eric on 2018/12/21. working...
//  Copyright © 2018 eric. All rights reserved.
//

// 1. on GitHub - done
// 2. add Shared - done
// 3. opci.. by pressure
// 4. on screen control

import UIKit
import MaLiang

class ViewController: UIViewController {

    weak var canvas: Canvas!
    
    // ---------------- Actions -------------------------------------------------------------------------------------------------
    
    @IBAction func Undo(_ sender: UIButton) {
        canvas.undo()
    }
    
    @IBAction func Redo(_ sender: UIButton) {
        canvas.redo()
    }

    @IBAction func Save(_ sender: UIButton) {
        //print("OUTPUT BUTTON")
        let tImage = canvas.snapshot()! // 1024X1024
        let imgData = UIImage.pngData(tImage)
        let fileName = NSHomeDirectory() + "/Documents/OUTPUT" + getDateTime() + ".png"
        print("fileName=\(fileName)")
        
        let tSaveStatus = FileManager().createFile(atPath: fileName as String, contents: imgData(), attributes: nil)
        print("儲存:" + String(tSaveStatus))
    }
    
    @IBAction func Share(_ sender: UIButton) {
        let tImage = canvas.snapshot()!

        let activityController = UIActivityViewController(activityItems: [tImage], applicationActivities: [])
        activityController.excludedActivityTypes = [.openInIBooks]
        activityController.completionWithItemsHandler = {
            (type, flag, array, error) -> Swift.Void in
            print(type ?? "")
            if  type == UIActivity.ActivityType.saveToCameraRoll && error == nil {
                self.showAlert(pTitle: "儲存成功", pMsg: "")
            }
        }
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad {
            activityController.modalPresentationStyle = UIModalPresentationStyle.popover
            activityController.popoverPresentationController?.sourceRect = CGRect.zero
            activityController.popoverPresentationController?.sourceView = self.view
        }
        self.present(activityController, animated: true)
        //self.containView.backgroundColor = self.currentBgColor
        //showAlert(pTitle: "[SHARED]", pMsg: "Shared!")
    }
    
    @IBAction func Clear(_ sender: UIButton) {
        canvas.clear()
    }
    
    // ---------------- Utilities -------------------------------------------------------------------------------------------------
    
    func showAlert(pTitle:String , pMsg:String) {
        let alert = UIAlertController(title: pTitle, message: pMsg, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "確定", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func getDateTime() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd HHmmss"
        return dateFormatter.string(from: date)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let c = Canvas(frame: CGRect(x: 0, y: 0, width: 1024, height: 1024))
        //let c = Canvas(frame: CGRect(x: 0, y: 0, width: 2048, height: 2048))
        view.addSubview(c)
        view.sendSubviewToBack(c)
        canvas = c
        do {
            try canvas.setupDocument()
        } catch {
            showAlert(pTitle: "Error!", pMsg: error.localizedDescription)
        }
        
        //
        print(getDateTime())
        print(NSHomeDirectory())
        // add pen/size/force
        let image = UIImage(named: "water-pen.png")
        let waterpen = Brush(texture: image!)
        canvas.brush = waterpen
        canvas.brush.pointSize = 20
        canvas.brush.forceSensitive = 0.5 // 0-1

    }


}

