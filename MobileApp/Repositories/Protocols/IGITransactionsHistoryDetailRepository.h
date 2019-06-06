//
//  IGITransactionsHistoryDetailRepository.h
//  MobileApp
//
//  Created by Rober on 27/04/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IGTransactionDetailResponse.h"

@protocol IGITransactionsHistoryDetailRepository<NSObject>

@required

-(void)getTransactionsHistoryDetail:(NSString *)product withContract:(NSString *)contract withEvent:(NSString *)event withTransaction:(NSString *)transaction docNumber:(NSString*)docNumber docType:(NSString*)docType withBlock:(void (^)(IGTransactionDetailResponse *, NSError *))block;

@end
