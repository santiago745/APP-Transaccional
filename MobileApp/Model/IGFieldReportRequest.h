//
//  IGFieldReportRequest.h
//  MobileApp
//
//  Created by Rober on 23/06/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGBaseModel.h"

@interface IGFieldReportRequest : IGBaseModel

@property(nonatomic, copy) NSString *key;
@property(nonatomic, copy) NSString *value;

@end
