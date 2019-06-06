//
//  IGIContractDetailRepository.h
//  MobileApp
//
//  Created by Rober on 7/05/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IGContractDetail.h"

@protocol IGIContractDetailRepository<NSObject>

@required

-(void)getContractDetail:(NSString *)docNumber withDocType:(NSString *)docType withProduct:(NSString *)product withPlan:(NSString *)plan withContract:(NSString *)contract withChannel:(NSInteger)channel withBlock:(void (^)(IGContractDetail *response, NSError *error))block;

@end