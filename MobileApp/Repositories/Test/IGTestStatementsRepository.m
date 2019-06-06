//
//  IGTestStatementsRepository.m
//  MobileApp
//
//  Created by steven muñoz on 16/04/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGTestStatementsRepository.h"
#import "OMPeriod.h"

@implementation IGTestStatementsRepository

static id _sharedInstance;

+ (id) sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

-(void) getStatements:(IGStatementsRequest *)request withBlock:(void (^)(NSArray *, NSError *))block
{
    NSError *err = nil;
    NSArray *periods;
    
    if ([request.reportType isEqualToString:@"1"]){
        periods = [self loadStatementModelFromFile:@"periodsDos"];
    }else{
        periods = [self loadStatementModelFromFile:@"periodsUno"];
    }
    
    if (block) {
        block(periods, err);
    }
}

-(NSArray *) loadStatementModelFromFile:(NSString *) fileName {
    
    NSString* path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSError *err = nil;
    
    NSArray *items = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
    
    NSMutableArray *objects = [[NSMutableArray alloc] initWithCapacity:items.count];
    OMPeriod *obj;
    
    for (NSDictionary *item in items) {
        obj = [[OMPeriod alloc] init];
        [obj updateWithDictionary:item];
        [objects addObject:obj];
    }
    
    return [NSArray arrayWithArray:objects];
    
}

@end
