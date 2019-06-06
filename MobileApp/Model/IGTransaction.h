//
//  IGTransaction.h
//  MobileApp
//
//  Created by Rober on 24/04/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGBaseModel.h"

@interface IGTransaction : IGBaseModel

@property (nonatomic, copy) NSString *productCode;
@property (nonatomic, copy) NSString *contract;
@property (nonatomic, copy) NSString *planCode;
@property (nonatomic, copy) NSString *eventNumber;
@property (nonatomic, copy) NSString *transactionNumber;
@property (nonatomic, copy) NSString *effectiveDate;
@property (nonatomic, copy) NSString *netValue;
@property (nonatomic, copy) NSString *rawValue;
@property (nonatomic, copy) NSString *descriptionText;

@end
