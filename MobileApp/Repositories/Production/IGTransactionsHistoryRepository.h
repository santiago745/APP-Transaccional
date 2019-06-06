//
//  IGTransactionsHistoryRepository.h
//  MobileApp
//
//  Created by Rober on 24/04/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IGITransactionsHistoryRepository.h"

@interface IGTransactionsHistoryRepository : NSObject<IGITransactionsHistoryRepository>
+(id) sharedInstance;
@end
