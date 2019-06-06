//
//  IGTransactionDetailResponse.h
//  MobileApp
//
//  Created by Rober on 24/04/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGBaseModel.h"

@interface IGTransactionDetailResponse : IGBaseModel

@property (nonatomic, copy) NSArray *fields;
@property (nonatomic, copy) NSArray *funds;
@property (nonatomic, copy) NSArray *documents;

@end
