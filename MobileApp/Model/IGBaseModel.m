//
//  IGBaseModel.m
//  salesforce
//
//  Created by Armando Restrepo on 11/23/14.
//  Copyright (c) 2014 Leonisa. All rights reserved.
//

#import "IGBaseModel.h"
#import <objc/runtime.h>

@implementation IGBaseModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    // override this in the model if property names in JSON don't match model
    return @{};
}

- (NSString *) getPropertyType: (objc_property_t) property {
    
    
    NSString* propertyAttributes = [NSString stringWithUTF8String:property_getAttributes(property)];
    NSArray* splitPropertyAttributes = [propertyAttributes componentsSeparatedByString:@"\""];
    if ([splitPropertyAttributes count] >= 2)
    {
        return [splitPropertyAttributes objectAtIndex:1];
    }
    
    return nil;
}

- (void)updateWithDictionary:(NSDictionary *)dictionary{
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i < outCount; i++) {
        @try {
            objc_property_t property = properties[i];
            NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
            id propertyValue = [dictionary valueForKey:(NSString *)propertyName];
            if (propertyValue && propertyValue != (id)[NSNull null]) {
                
                NSString *propertyType = [self getPropertyType:property];
                
                if (propertyType && [propertyType isEqualToString:@"NSDate"] && ![propertyValue isEqualToString:IGEmptyString] ) {
                    NSDateFormatter *df = [[NSDateFormatter alloc] init];
                    [df setDateFormat:@"yyyyMMdd"];
                    propertyValue = [df dateFromString: propertyValue];
                } else if (propertyType && ![propertyType isEqualToString:@"NSString"] && ![self valueForKey:(NSString *)propertyName]) {
                    Class myClass = NSClassFromString(propertyType);
                    id myObject = [[myClass alloc] init];
                    [self setValue:myObject forKey:propertyName];
                }
                
                if (propertyType && [[self valueForKey:(NSString *)propertyName] respondsToSelector:@selector(updateWithDictionary:)]) {
                    [[self valueForKey:(NSString *)propertyName] updateWithDictionary:propertyValue];
                } else {
                    [self setValue:propertyValue forKey:propertyName];
                }
            }
            
        }
        @catch (NSException *exception) {
            NSLog(@"%@", exception.reason);
        }
    }
    free(properties);
}

@end
