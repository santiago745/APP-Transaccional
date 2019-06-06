//
//  IGContractDetail.h
//  MobileApp
//
//  Created by Rober on 7/05/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGBaseModel.h"

@interface IGContractDetail : IGBaseModel

@property (nonatomic, copy) NSString *number;
@property (nonatomic, copy) NSString *productCode;
@property (nonatomic, copy) NSString *planCode;
@property(nonatomic, copy) NSArray *groups;

@end
