//
//  Contract.h
//  MobileApp
//
//  Created by steven muñoz on 6/04/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGBaseModel.h"

@interface IGContract : IGBaseModel

@property (nonatomic, copy) NSString *number;
@property (nonatomic, copy) NSString *productCode;
@property (nonatomic, copy) NSString *planCode;
@property (nonatomic, copy) NSArray *fields;
@property (nonatomic) BOOL WithdrawalsAllowed;

@end
