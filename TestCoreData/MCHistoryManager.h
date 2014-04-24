//
//  MCHistoryManager.h
//  TestCoreData
//
//  Created by CocoaBob on 24/04/2014.
//  Copyright (c) 2014 CocoaBob. All rights reserved.
//

@class HistoryItem;

@interface MCHistoryManager : NSObject

- (void)saveContext;

- (NSArray *)allHistories;
- (void)addNewHistoryWithDate:(NSDate *)date content:(NSString *)content;
- (void)deleteHistory:(HistoryItem *)history;

@end
