//
//  DocWindowController.swift
//  Scriptwriter
//
//  Created by Derek Feddon on 6/11/14.
//  Copyright (c) 2014 Derek Feddon. All rights reserved.
//

import Foundation
import Cocoa

class DocWindowController:NSWindowController
{
    /*init()
    {
        super.init()
    }*/
    
    convenience init(windowNibName Document:String!)
    {
        self.init()
        println("init")//self.windowNibName)
    }
    
    /*@IBAction func displaySomeText(text:NSString)
    {
        println("displaySomeText")
        var doc:Document = self.document() as Document
        doc.textField.insertText(text)
        // set font (name, range)
        var dfont:NSFont = NSFont(name: "Courier Prime", size: 16)
        var drange:NSRange = NSMakeRange(0, doc.script.length - 1)
        doc.textField.setFont(dfont, range: drange)
    }*/
    
    override func windowDidLoad()
    {
        println("window did load")
        var doc:Document = self.document() as Document
        doc.displaySomeText(doc.script)
    }
    
    override var windowNibName:String
    {
        println("windowNibName")
        return "Document"
    }
    
}

