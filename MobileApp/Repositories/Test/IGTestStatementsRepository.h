//
//  IGTestStatementsRepository.h
//  MobileApp
//
//  Created by steven muñoz on 16/04/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IGIStatementsRepository.h"

@interface IGTestStatementsRepository : NSObject<IGIStatementsRepository>
+(id) sharedInstance;
@end

