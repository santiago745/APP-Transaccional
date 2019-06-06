//
//  IGTestTransactionsHistoryRepository.h
//  MobileApp
//
//  Created by Rober on 1/05/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IGITransactionsHistoryRepository.h"

@interface IGTestTransactionsHistoryRepository : NSObject<IGITransactionsHistoryRepository>
+(id) sharedInstance;
@end
