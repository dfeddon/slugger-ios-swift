//
//  ScriptTextView.swift
//  Scriptwriter
//
//  Created by Derek Feddon on 6/13/14.
//  Copyright (c) 2014 Derek Feddon. All rights reserved.
//

import Foundation
import AppKit

class ScriptTextView:NSTextView
{
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        self.window.acceptsMouseMovedEvents = true
    }
    
    override func didChangeText()
    {
        //println(self.textStorage.st)
        // get text attributes (for elementIndex)
        var index:Int = self.selectedRange().location
        var atts:Dictionary = self.textStorage.attributesAtIndex(index, effectiveRange: nil)
        //println(atts)
        self.getAttributesByIndex(atts)// as Dictionary<NSFont,Int>
    }
    
    func getAttributesByIndex(dict:AnyObject)//Dictionary<String,Any>)//->Dictionary<NSFont,Int>
    {
        //println(dict.getAttributesByIndex(0))
        //println(dict)
        //dict = dict as Dictionary
        //var newdict:Dictionary = dict as Dictionary
        var index:Int = -1
        //var text:String
        if (dict.count == 4)
        {
            //index = dict["elementIndex"] as Int
            //text = dict["elementText"] as String
            //dict["elementText"] = "HI"
            var desc:String = self.textStorage.description
            
            //for ele in self.textStorage.description
            //{
             //   println(ele)
            //}
        }
        println(dict)//["elementIndex"])
        //print(self.textStorage.paragraphs)
        //return String()
    }
    
    override func mouseDown(theEvent: NSEvent!)
    {
        super.mouseDown(theEvent?)
        
        // get text attributes (for elementIndex)
        var index:Int = self.selectedRange().location
        var atts:Dictionary = self.textStorage.attributesAtIndex(index, effectiveRange: nil)
        //println(atts)
        self.getAttributesByIndex(atts)
        //println(self.textStorage.description)
    }
}
