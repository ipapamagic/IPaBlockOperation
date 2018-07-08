//
//  IPaBlockOperation.swift
//  IPaBlockOperation
//
//  Created by IPa Chen on 2015/6/14.
//  Copyright (c) 2015年 AMagicStudio. All rights reserved.
//

import Foundation
public typealias  IPaBlockOperationBlock = (_ complete: @escaping () -> ()) -> ()
open class IPaBlockOperation : Operation {
    var operationBlock :IPaBlockOperationBlock
    var _executing:Bool = false
    var _finished:Bool = false
    override open var isExecuting:Bool {
        get { return _executing }
        set {
            if _executing != newValue {
                willChangeValue(forKey: "isExecuting")
                _executing = newValue
                didChangeValue(forKey: "isExecuting")
            }
        }
    }
    
    override open var isFinished:Bool {
        get { return _finished }
        set {
            if self.isFinished != newValue {
                willChangeValue(forKey: "isFinished")
                _finished = newValue
                didChangeValue(forKey: "isFinished")
            }
        }
    }
    override open var isConcurrent:Bool {
        get {
            return true
        }
    }
    @objc public init(block:@escaping IPaBlockOperationBlock) {
        operationBlock = block
    }
    override open func start() {
        if isCancelled {
            isFinished = true
            return;
        }
        
        
        isExecuting = true
        
        operationBlock({
            self.isFinished = true
            self.isExecuting = false
            
        })
    }
    override open func cancel() {
        if isExecuting {
            isFinished = true
            isExecuting = false
        }
    }
}



