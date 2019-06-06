//
//  IGTestTransactionsHistoryDetailRepository.m
//  MobileApp
//
//  Created by Rober on 1/05/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGTestTransactionsHistoryDetailRepository.h"
#import "IGTransactionDetailResponse.h"

@interface IGTestTransactionsHistoryDetailRepository ()

-(NSDictionary *) loadTransactionsHistoryDetailModelFromFile:(NSString *) fileName;

@end

@implementation IGTestTransactionsHistoryDetailRepository

static id _sharedInstance;

+ (id) sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

-(void)getTransactionsHistoryDetail:(NSString *)product withContract:(NSString *)contract withEvent:(NSString *)event withTransaction:(NSString *)transaction docNumber:(NSString*)docNumber docType:(NSString*)docType withBlock:(void (^)(IGTransactionDetailResponse *, NSError *))block {
    
    NSDictionary *transactionsHistoryDetail = [self loadTransactionsHistoryDetailModelFromFile:@"transactionsDetail"];
    
    if (block) {
        
        IGTransactionDetailResponse *response = [MTLJSONAdapter modelOfClass:[IGTransactionDetailResponse class] fromJSONDictionary:transactionsHistoryDetail error:nil];
        
        block(response, nil);
    }
}

-(NSDictionary *) loadTransactionsHistoryDetailModelFromFile:(NSString *) fileName {
    
    NSString* path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSError *err = nil;
    
    NSDictionary *items = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
    
    return items;
    
}

@end
