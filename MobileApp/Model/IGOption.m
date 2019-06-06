//
//  IGOption.m
//  MobileApp
//
//  Created by Rober on 17/06/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGOption.h"

@implementation IGOption

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    // override this in the model if property names in JSON don't match model
    return @{
             @"caption": @"Caption",
             @"value":@"Value"
             };
}

@end
