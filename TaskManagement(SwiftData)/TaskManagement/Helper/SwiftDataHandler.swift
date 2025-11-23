//
//  SwiftDataHandler.swift
//  TaskManagement
//
//  Created by Nitin Bhatia on 03/05/25.
//

import Foundation
import SwiftData
import SwiftUI

public final class SwiftDataHandler {
    
    class func insertData<T: PersistentModel>(using context: ModelContext, data: T) {
        context.insert(data)
    }
    
    class func deleteData<T: PersistentModel>(using context: ModelContext, data: T) throws {
        context.delete(data)
        try context.save()
        
    }
    
    class func update<T: PersistentModel>(using context: ModelContext, model: T, mutate: (T) -> Void) throws {
        mutate(model)               // Apply your changes
        try context.save()          // Save the context
    }
}

