//
//  IGTestTransactionsHistoryRepository.m
//  MobileApp
//
//  Created by Rober on 1/05/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGTestTransactionsHistoryRepository.h"
#import "IGTransaction.h"

@interface IGTestTransactionsHistoryRepository ()

-(NSArray *) loadTransactionsHistoryModelFromFile:(NSString *) fileName;

@end

@implementation IGTestTransactionsHistoryRepository

static id _sharedInstance;

+ (id) sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

-(void)getTransactionsHistory:(NSString *)product withContract:(NSString *)contract withPlan:(NSString *)plan withSet:(NSInteger)set docNumber:(NSString*)docNumber docType:(NSString*)docType withBlock:(void (^)(NSArray *response, NSError *error))block
{
    NSArray *transactions = [self loadTransactionsHistoryModelFromFile:@"transactions"];
    
    if (block) {
        block(transactions, nil);
    }
}

-(NSArray *) loadTransactionsHistoryModelFromFile:(NSString *) fileName {
    
    NSString* path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSError *err = nil;
    
    NSArray *items = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
    
    NSMutableArray *objects = [[NSMutableArray alloc] initWithCapacity:items.count];
    IGTransaction *obj;
    
    for (NSDictionary *item in items) {
        obj = [[IGTransaction alloc] init];
        [obj updateWithDictionary:item];
        [objects addObject:obj];
    }
    
    return [NSArray arrayWithArray:objects];
}

@end