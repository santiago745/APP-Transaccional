//
//  IGReportRequest.h
//  MobileApp
//
//  Created by Rober on 23/06/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGBaseModel.h"
#import "IGFieldReportRequest.h"

@interface IGReportRequest : IGBaseModel

@property (nonatomic) NSInteger reportType;
@property (nonatomic, copy) NSString *reportCode;
@property (nonatomic, copy) NSString  *docType;
@property (nonatomic, copy) NSString  *docNumber;
@property (nonatomic, copy) NSString *contract;
@property (nonatomic, copy) NSString *product;
@property (nonatomic, copy) NSString *plan;
@property (nonatomic, copy) NSArray *fields;

@end
