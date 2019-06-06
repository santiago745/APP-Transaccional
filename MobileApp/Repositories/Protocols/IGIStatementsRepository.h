//
//  IGIStatementsRepository.h
//  MobileApp
//
//  Created by steven muñoz on 16/04/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IGStatementsRequest.h"

@protocol IGIStatementsRepository <NSObject>

@required

-(void) getStatements:(IGStatementsRequest *)request
        withBlock:(void (^)(NSArray *response, NSError *error))block;

@end
