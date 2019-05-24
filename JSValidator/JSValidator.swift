//
//  JSValidator.swift
//  JSValidator
//
//  Created by anthann on 2019/5/24.
//  Copyright © 2019 anthann. All rights reserved.
//

import Foundation
import JavaScriptCore

class JSValidator {
    private lazy var jsContext: JSContext = {
        let context = JSContext()!
        context.exceptionHandler = { (context, exception) in
            guard let excep = exception else {
                return
            }
            var moreInfo: String = ""
            
            if let stacktrace = excep.objectForKeyedSubscript("stack").toString() {
                moreInfo.append("Stack Trace: \n")
                moreInfo.append(stacktrace)
                moreInfo.append("\n")
            }
            if let lineNumber = excep.objectForKeyedSubscript("line").toNumber() {
                moreInfo.append("Line Number: \(lineNumber)  ")
            }
            // type of Number
            if let column = excep.objectForKeyedSubscript("column").toNumber() {
                moreInfo.append("Column: \(column)\n")
            }
            print("JS ERROR: \(excep)\n \(moreInfo)")
        }
        return context
    }()
    
    func validate(js: String) {
        jsContext.evaluateScript(js)
    }
}
