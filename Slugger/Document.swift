//
//  Document.swift
//  Slugger
//
//  Created by Derek Feddon on 6/4/14.
//  Copyright (c) 2014 Derek Feddon. All rights reserved.
//

import Cocoa

class Document: NSPersistentDocument
{
    //@IBOutlet var textView : NSTextView = nil
    //let textView = NSTextView()
    @IBOutlet var testButton : NSButton
    
    @IBOutlet var myViewController : NSViewController = nil
    // constructor
    init()
    {
        super.init()
        // Add your subclass-specific initialization here.
                                    
    }

    override func windowControllerDidLoadNib(aController: NSWindowController)
    {
        super.windowControllerDidLoadNib(aController)
                                    
        // Add any code here that needs to be executed once the windowController has loaded the document's window.
        //var tbutton : NSButton
        println("nib loaded")//tbutton)
        //var textView:NSTextView
        println(self)
        println(aController.document())
    }

    override class func autosavesInPlace() -> Bool
    {
        println("ausosaves")
        //println(testButton)
        return true
    }

    override var windowNibName: String
    {
        // Returns the nib file name of the document
        // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this property and override -makeWindowControllers instead.
        return "Document"
    }
    
    @IBAction func buttonTapped(AnyObject)
    {
        println("button tapped!")
         var testButton : NSButton
    }

}
                                
