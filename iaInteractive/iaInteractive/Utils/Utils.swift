//
//  Utils.swift
//  MagmaExcercise
//
//  Created by Aldo Bonilla on 19/04/17.
//  Copyright © 2017 Aldo Bonilla. All rights reserved.
//

import Foundation
import KVNProgress

///Dictionary of type String, Any
typealias BasicDictionary = Dictionary<String, Any?>

///Alert view with an ok button
func showSimpleAlertWithTitle(title: String!, message: String, viewController: UIViewController?) {
    if viewController == nil {
        AppDelegate().presentAlertFromRootViewController(title: title, message: message)
        return
    }
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
    alert.addAction(action)
    viewController!.present(alert, animated: true, completion: nil)
}

///HUD configuration
func configureKVNProgress() {
    let configuration = KVNProgressConfiguration()
    configuration.statusFont = FontBold16
    configuration.statusColor = UIColor.blue
    configuration.circleStrokeForegroundColor = UIColor.lightGray
    configuration.backgroundType = .blurred
    configuration.isFullScreen = true
    configuration.lineWidth = 2.0
    KVNProgress.setConfiguration(configuration)
}

func filePathWithName(_ name: String) -> String? {
    let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
    let url = NSURL(fileURLWithPath: path)
    let filePath = url.appendingPathComponent("\(name).sqlite")?.path
    let fileManager = FileManager.default
    if fileManager.fileExists(atPath: filePath!) {
        return filePath
    } else {
        return nil
    }
}
