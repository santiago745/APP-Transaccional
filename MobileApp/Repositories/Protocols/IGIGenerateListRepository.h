//
//  IGIGenerateListRepository.h
//  MobileApp
//
//  Created by Rober on 17/06/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IGIGenerateListRepository<NSObject>

@required

-(void)getGenerateList:(NSString *)docNumber withDocType:(NSString *)docType withProduct:(NSString *)product withPlan:(NSString *)plan withContract:(NSString *)contract withBlock:(void (^)(NSArray *response, NSError *error))block;

@end
