//
//  CCBeforeAction.h
//  CCDebugHelper
//
//  Created by Rafał Wójcik on 19.05.2014.
//  Copyright (c) 2014 Chilli Coders. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CCViewControllerConfigComplete)(void);
typedef void (^CCViewControllerConfigBeforeAction)(id controller);
typedef void (^CCViewControllerConfigBeforeAsyncAction)(id controller, CCViewControllerConfigComplete complete);

@interface CCBeforeAction : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, readonly) BOOL isAsync;

- (id)initSyncActionWithName:(NSString *)name actionBlock:(CCViewControllerConfigBeforeAction)block;
- (id)initAsyncActionWithName:(NSString *)name actionBlock:(CCViewControllerConfigBeforeAsyncAction)block;

- (id)actionBlock;

@end
