//
//  MCHistoryManager.m
//  TestCoreData
//
//  Created by CocoaBob on 24/04/2014.
//  Copyright (c) 2014 CocoaBob. All rights reserved.
//

#import "MCHistoryManager.h"
#import <CoreData/CoreData.h>

@interface MCHistoryManager ()

@property (nonatomic, strong, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong, readonly) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end

@implementation MCHistoryManager

@end
