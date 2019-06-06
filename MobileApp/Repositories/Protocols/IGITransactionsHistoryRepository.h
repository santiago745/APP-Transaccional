//
//  IGITransactionsHistoryRepository.h
//  MobileApp
//
//  Created by Rober on 24/04/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IGITransactionsHistoryRepository<NSObject>

@required

-(void)getTransactionsHistory:(NSString *)product withContract:(NSString *)contract withPlan:(NSString *)plan withSet:(NSInteger)set docNumber:(NSString*)docNumber docType:(NSString*)docType withBlock:(void (^)(NSArray *response, NSError *error))block;

@end
