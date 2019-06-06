//
//  IGTestAgentsRepository.m
//  MobileApp
//
//  Created by Rober on 16/04/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGTestAgentsRepository.h"
#import "IGAgent.h"

@interface IGTestAgentsRepository ()

-(NSArray *) loadAgentModelFromFile:(NSString *) fileName;

@end

@implementation IGTestAgentsRepository

static id _sharedInstance;

+ (id) sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

-(void)getAgents:(NSString *)docNumber withDocType:(NSString *)docType withBlock:(void (^)(NSArray *, NSError *))block {
    
    NSError *err = nil;
    NSArray *agents = [self loadAgentModelFromFile:@"agents"];
    
    if (block) {
        block(agents, err);
    }
}

-(NSArray *) loadAgentModelFromFile:(NSString *) fileName {
    
    NSString* path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSError *err = nil;
    
    NSArray *items = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
    
    NSMutableArray *objects = [[NSMutableArray alloc] initWithCapacity:items.count];
    IGAgent *obj;
    
    for (NSDictionary *item in items) {
        obj = [[IGAgent alloc] init];
        [obj updateWithDictionary:item];
        [objects addObject:obj];
    }
    
    return [NSArray arrayWithArray:objects];
    
}

@end
