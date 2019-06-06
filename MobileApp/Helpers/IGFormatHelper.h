//
//  IGFormatHelper.h
//  salesforce
//
//  Created by Juan on 7/01/15.
//  Copyright (c) 2015 Leonisa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IGFormatHelper : NSObject

//-(float)getTotalOrderByClient:(IGClient *)client;

+(NSString *) getConcurrencyFormat:(NSString*) number;
+(NSString *) generateGuid:(NSUInteger) numberOfCharacters;
+(NSString *) formatActualDate:(NSString*) format;
+(NSString *) addDays:(int)daysToAdd toDate:(NSDate *)date;
+(NSString *) formatWithDate:(NSDate *)date andFormat:(NSString *)format;




@end
