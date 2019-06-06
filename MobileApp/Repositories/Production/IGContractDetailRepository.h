//
//  IGContractDetailRepository.h
//  MobileApp
//
//  Created by Rober on 7/05/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IGIContractDetailRepository.h"

@interface IGContractDetailRepository : NSObject<IGIContractDetailRepository>
+(id) sharedInstance;
@end
