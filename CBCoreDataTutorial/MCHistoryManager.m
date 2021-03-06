//
//  MCHistoryManager.m
//  TestCoreData
//
//  Created by CocoaBob on 24/04/2014.
//  Copyright (c) 2014 CocoaBob. All rights reserved.
//

#import "MCHistoryManager.h"
#import <CoreData/CoreData.h>

#import "HistoryItem.h"

@interface MCHistoryManager ()

@property (nonatomic, strong, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong, readonly) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end

@implementation MCHistoryManager

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

#pragma mark - Object Lifecycle

+ (instancetype)shared {
    static id __sharedInstance = nil;
    if (__sharedInstance == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            __sharedInstance = [[[self class] alloc] init];
        });
    }
    return __sharedInstance;
}

#pragma mark Core Data Basics

- (NSManagedObjectModel *)managedObjectModel {
    if (!_managedObjectModel) {
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"HistoryModel" withExtension:@"momd"];
        _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    }
    return _managedObjectModel;
}

- (NSManagedObjectContext *)managedObjectContext {
    if (!_managedObjectContext) {
        NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
        if (coordinator != nil) {
            _managedObjectContext = [[NSManagedObjectContext alloc] init];
            [_managedObjectContext setPersistentStoreCoordinator:coordinator];
        }
    }
    return _managedObjectContext;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (!_persistentStoreCoordinator) {
        NSURL *documentURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        NSURL *storeURL = [documentURL URLByAppendingPathComponent:@"db.sqlite"];

        NSError *error = nil;
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
        if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        }
    }
    return _persistentStoreCoordinator;
}

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if ([managedObjectContext hasChanges]) {
        NSError *error = nil;
        if (![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        }
    }
}

#pragma mark Database Managements

- (NSArray *)allHistories {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"HistoryItem"];
    NSError *error = nil;
    NSArray *fetchResults = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (error) {
        NSLog(@"%s %@",__PRETTY_FUNCTION__, error);
    }
    return fetchResults;
}

- (void)addNewHistoryWithDate:(NSDate *)date content:(NSString *)content {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;

    HistoryItem *newHistoryItem = [NSEntityDescription insertNewObjectForEntityForName:@"HistoryItem"
                                                                inManagedObjectContext:managedObjectContext];
    newHistoryItem.date = date;
    newHistoryItem.content = content;

    [self saveContext];
}

- (void)deleteHistory:(HistoryItem *)history {
    [self.managedObjectContext deleteObject:history];
    
    [self saveContext];
}

@end
