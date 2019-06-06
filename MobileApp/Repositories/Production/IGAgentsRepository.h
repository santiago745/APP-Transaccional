//
//  IGAgentsRepository.h
//  MobileApp
//
//  Created by Rober on 16/04/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IGIAgentsRepository.h"

@interface IGAgentsRepository : NSObject <IGIAgentsRepository>
+(id) sharedInstance;
@end
