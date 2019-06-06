//
//  IGFormatHelper.m
//  salesforce
//
//  Created by Juan on 7/01/15.
//  Copyright (c) 2015 Leonisa. All rights reserved.
//

#import "IGFormatHelper.h"

@implementation IGFormatHelper

+(NSString *) getConcurrencyFormat:(NSString *) number{
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    NSString *numberAsString = [numberFormatter stringFromNumber:[NSNumber numberWithFloat: [number floatValue]]];
    
    return numberAsString;
}

+(NSString *) generateGuid:(NSUInteger) numberOfCharacters{

    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: numberOfCharacters];
    
    for (int i=0; i< numberOfCharacters; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length])]];
    }
    
    return randomString;
}

+(NSString *) formatWithDate:(NSDate *)date andFormat:(NSString *)format{

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:date];

}

+(NSString *) formatActualDate:(NSString *)format{

    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:format];
    return [DateFormatter stringFromDate:[NSDate date]];

}

+(NSString *) addDays:(int)daysToAdd toDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:CUSTOM_DATE_FORMAT];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setDay:daysToAdd];
    
    NSDate *newDate = [[NSCalendar currentCalendar]
                       dateByAddingComponents:dateComponents
                       toDate:date options:0];
    
    NSString * stringDate = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:newDate]];
    return stringDate;
}





@end
