//
//  IGTestContractDetailRepository.h
//  MobileApp
//
//  Created by Rober on 12/05/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IGIContractDetailRepository.h"

@interface IGTestContractDetailRepository : NSObject<IGIContractDetailRepository>
+(id) sharedInstance;
@end
