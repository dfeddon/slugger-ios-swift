//
//  Document.swift
//  Scriptwriter
//
//  Created by Derek Feddon on 6/10/14.
//  Copyright (c) 2014 Derek Feddon. All rights reserved.
//

import Cocoa

class Document: NSDocument
{
    //@IBOutlet var textField : NSTextField
    //@IBOutlet var textView : NSTextView
    @IBOutlet var viewController : NSViewController = nil
    @IBOutlet var scrollView : NSScrollView
    @IBOutlet var threadsView : ThreadsOutlineView
    
    var script:NSString = NSString()
    var textField:NSTextView
    {
        get
        {
            return scrollView.contentView.documentView as NSTextView
        }
    }
    
    @IBAction func displaySomeText(text:NSString)
    {
        //text = script
        println("displaySomeText")
        //println(scrollView.contentView)
        //textField.insertText(text)
        // set font (name, range)
        /*var dfont:NSFont = NSFont(name: "Courier Prime", size: 16)
        var drange:NSRange = NSMakeRange(0, script.length - 1)
        textField.setFont(dfont, range: drange)*/
        
        // parse lines
        var arr:Array = text.componentsSeparatedByString("\n") //componentsSeparatedByCharactersInSet(NSCharacterSet.newlineCharacterSet())]
        println(arr.count)
        var lastLineBlank:Bool = true
        var elementType:Int = 0
        /*
            0 blank
            1 action
            2 dialogue
            3 slug/shot
            4 dialogue header
            5 transition
            6 parenthetical
            7 note
            8 section
            9 synopsis 
        */
        var screenplay:Array = []
        var elementNumber:Int = 0
        for item: AnyObject in arr
        {
            if let line = item as? String
            {
                if countElements(line) > 0
                {
                    // to begin, let's check for first characters
                    switch(Array(line)[0])
                    {
                    case "#":
                        elementType = 8
                    case "=":
                        elementType = 9
                    case ".":
                        elementType = 3
                    case "@":
                        elementType = 4
                    case ">":
                        elementType = 5
                        // also, check for suffix < to center
                    default: elementType = -1
                    }
                    
                    // first, check for prefixes
                    //switch(line.hasPrefix()))
                    //lastLineType = 1 // action line
                    // is upper case
                    if line.uppercaseString == line && elementType == -1
                    {
                        //print("--> ")
                        if line.hasPrefix("INT.") || line.hasPrefix("EXT.") || line.hasPrefix(".")
                        {
                            elementType = 3 // slugline
                        }
                        else if line.hasSuffix(":")
                        {
                            elementType = 5 // transition
                        }
                        else
                        {
                            elementType = 4 // dialogue header
                        }
                    }
                    else if elementType == -1 // not slug or header
                    {
                        if lastLineBlank == false//elementType != 0
                        {
                            if line.hasPrefix("(") || line.hasSuffix(")")
                            {
                                elementType = 6 // parenthetical
                            }
                            else
                            {
                                elementType = 2 // dialogue
                            }
                        }
                        else // single lowerspaced line
                        {
                            if line.hasPrefix("[[")
                            {
                                elementType = 7 // note
                            }
                            else if line.hasPrefix("#")
                            {
                                elementType = 8 // section
                            }
                            else if line.hasPrefix("=")
                            {
                                elementType = 9 // synopsis
                            }
                            else
                            {
                                elementType = 1 // action - not caps/dialogue/paren
                            }
                        }
                    }
                    // previous line type
                    //if lastLineType != 0 {lastLineType=2}
                    //else{lastLineType = 1}//false
                    //println("\(item) [\(elementType)]")
                    lastLineBlank = false
                }
                else
                {
                    elementType = 0//true
                    lastLineBlank = true
                    //println("^ [0]")
                }
                var ele:ScriptElement = ScriptElement()
                ele.index = elementNumber
                ele.type = elementType
                ele.text = line
                screenplay.append(ele)
                elementNumber++
                //if elementType == 0 {println("^ [0]")}//else {print(lastLineType)}
            }
        }
        var contentString:NSMutableAttributedString = NSMutableAttributedString()
        for (index, sitem:AnyObject) in enumerate(screenplay)
        {
            if let sitem2 = sitem as? ScriptElement
            {
                //println("\(index) - \(sitem2.index) / \(sitem2.type) \(sitem2.text)")//.index)
                var resultString:NSMutableAttributedString = NSMutableAttributedString(string:sitem2.text + "\n")
                //var attributes:NSDictionary=NSDictionary(objects: [UIFont(name: "Helvetica", size: 16.0)], forKeys: [NSFontAttributeName])//, forState: UIControlState.Normal
                //var attributes:Dictionary<String,Any>
                var attributes:Dictionary = [NSFontAttributeName : NSFont(name:"Courier Prime", size: 16)]
                // add style attributes
                resultString.setAttributes(attributes, range: NSMakeRange(0, countElements(sitem2.text)))
                // add custom attributes (script element index)
                resultString.addAttribute("elementIndex", value: sitem2.index, range: NSMakeRange(0, countElements(sitem2.text)))
                resultString.addAttribute("elementText", value: sitem2.text, range: NSMakeRange(0, countElements(sitem2.text)))
                resultString.addAttribute("elementType", value: sitem2.type, range: NSMakeRange(0, countElements(sitem2.text)))
                // append line string to script string
                contentString.appendAttributedString(resultString)
            }
        }
        // write to textview
        textField.textStorage.appendAttributedString(contentString)
        println(contentString)
    }
    
    init()
    {
        super.init()
        // Add your subclass-specific initialization here.
                                    
    }

    override func windowControllerDidLoadNib(aController: NSWindowController)
    {
        super.windowControllerDidLoadNib(aController)
                                    
        // Add any code here that needs to be executed once the windowController has loaded the document's window.
        println("windowControllerDidLoadNib")
        // set text
        displaySomeText(script)
        
        // test
        println("HI")
        //println(textField.selectedTextAttributes)
        println(textField.selectedRange.location.description)
        //println(textField.textStorage.description) //selectedRanges(0, 400).location)
        println(textField.fieldEditor.description)
    }

    override class func autosavesInPlace() -> Bool
    {
        return true
    }
    
    /*override func makeWindowControllers()
    {
        var docWindowController:DocWindowController = DocWindowController()
        //docWindowController.setDocument(self)
        self.addWindowController(docWindowController)
        println("doc win controller")
        //docWindowController.showWindow(self)
        docWindowController.setDocument(self)
    }*/

    override var windowNibName: String
    {
        // Returns the nib file name of the document
        // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this property and override -makeWindowControllers instead.
        return "Document"
    }

    override func dataOfType(typeName: String?, error outError: NSErrorPointer) -> NSData?
    {
        // Insert code here to write your document to data of the specified type. If outError != nil, ensure that you create and set an appropriate error when returning nil.
        // You can also choose to override fileWrapperOfType:error:, writeToURL:ofType:error:, or writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
        outError.memory = NSError.errorWithDomain(NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
        return nil
    }

    override func readFromData(data: NSData?, ofType typeName: String?, error outError: NSErrorPointer) -> Bool
    {
        var str:NSString = NSString(data: data, encoding: NSUTF8StringEncoding)
        // set text to script var
        script = str
        println("script loaded")
        // validate that file data type is plain text
        // Insert code here to read your document from the given data of the specified type. If outError != nil, ensure that you create and set an appropriate error when returning false.
        // You can also choose to override readFromFileWrapper:ofType:error: or readFromURL:ofType:error: instead.
        // If you override either of these, you should also override -isEntireFileLoaded to return NO if the contents are lazily loaded.
        outError.memory = NSError.errorWithDomain(NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
        return true//false
    }
    
    

}

