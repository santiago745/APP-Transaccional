//
//  IGStatementsRequest.h
//  MobileApp
//
//  Created by steven muñoz on 16/04/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGBaseModel.h"

@interface IGStatementsRequest : IGBaseModel


@property (nonatomic) NSInteger docNumber;
@property (nonatomic, copy) NSString *docType;
@property (nonatomic, copy) NSString *reportType;

@end
