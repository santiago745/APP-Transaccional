//
//  IGIAgentsRepository.h
//  MobileApp
//
//  Created by Rober on 16/04/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IGIAgentsRepository<NSObject>

@required

-(void) getAgents:(NSString *)docNumber
         withDocType:(NSString *)docType
           withBlock:(void (^)(NSArray *response, NSError *error))block;

@end
