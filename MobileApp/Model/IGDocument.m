//
//  IGDocument.m
//  MobileApp
//
//  Created by Rober on 28/04/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGDocument.h"

@implementation IGDocument

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"caption" : @"Caption",
             @"documentType" : @"DocumentType"
             };
}

@end
