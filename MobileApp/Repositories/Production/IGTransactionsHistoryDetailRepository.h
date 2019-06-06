//
//  IGTransactionsHistoryDetailRepository.h
//  MobileApp
//
//  Created by Rober on 27/04/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IGITransactionsHistoryDetailRepository.h"

@interface IGTransactionsHistoryDetailRepository : NSObject<IGITransactionsHistoryDetailRepository>
+(id) sharedInstance;
@end
