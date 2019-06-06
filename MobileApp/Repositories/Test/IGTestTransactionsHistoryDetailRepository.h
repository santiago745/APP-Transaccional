//
//  IGTestTransactionsHistoryDetailRepository.h
//  MobileApp
//
//  Created by Rober on 1/05/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IGITransactionsHistoryDetailRepository.h"

@interface IGTestTransactionsHistoryDetailRepository : NSObject<IGITransactionsHistoryDetailRepository>
+(id) sharedInstance;
@end
