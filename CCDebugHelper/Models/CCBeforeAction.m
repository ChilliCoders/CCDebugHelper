//
//  CCBeforeAction.m
//  CCDebugHelper
//
//  Created by Rafał Wójcik on 19.05.2014.
//  Copyright (c) 2014 Chilli Coders. All rights reserved.
//

#import "CCBeforeAction.h"

@interface CCBeforeAction()

@property (nonatomic, assign) BOOL isAsync;
@property (nonatomic, copy) CCViewControllerConfigBeforeAction syncBlock;
@property (nonatomic, copy) CCViewControllerConfigBeforeAsyncAction asyncBlock;

@end

@implementation CCBeforeAction

- (id)initSyncActionWithName:(NSString *)name actionBlock:(CCViewControllerConfigBeforeAction)block {
    self = [super init];
    if (self) {
        self.name = name;
        self.isAsync = NO;
        self.syncBlock = block;
    }
    return self;
}


- (id)initAsyncActionWithName:(NSString *)name actionBlock:(CCViewControllerConfigBeforeAsyncAction)block {
    self = [super init];
    if (self) {
        self.name = name;
        self.isAsync = YES;
        self.asyncBlock = block;
    }
    return self;
}

- (id)actionBlock {
    if (self.isAsync) {
        return self.asyncBlock;
    } else {
        return self.syncBlock;
    }
}


@end
