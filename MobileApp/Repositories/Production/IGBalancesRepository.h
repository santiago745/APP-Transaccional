//
//  IGBalancesRepository.h
//  MobileApp
//
//  Created by steven muñoz on 6/04/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IGIBalancesRepository.h"

@interface IGBalancesRepository : NSObject<IGIBalancesRepository>
+(id) sharedInstance;
@end
