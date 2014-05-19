//
//  CCViewControllerConfig.m
//  CCDebugHelper
//
//  Created by Rafał Wójcik on 30.04.2014.
//  Copyright (c) 2014 Chilli Coders. All rights reserved.
//

#import "CCViewControllerConfig.h"
#import "CCDebugHelperConstants.h"

@interface CCViewControllerConfig()

// general properties
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) Class klass;
@property (assign) BOOL useStoryboard;

// storyboard properties
@property (nonatomic, strong) NSString *controllerStoryboardIdentifier;
@property (nonatomic, strong) UIStoryboard *storyboard;

// XIB properties
@property (nonatomic, strong) NSString *xibName; // only if different than controller name

// beforeActions
@property (nonatomic, strong) NSMutableArray *beforeActions;
@property (nonatomic, strong) dispatch_semaphore_t asyncWait;

@end

@implementation CCViewControllerConfig

- (instancetype)init {
    self = [super init];
    if (self) {
        self.shouldWrapControllerWithNavigationController = NO;
        _navigationControllerClassName = [UINavigationController class];
    }
    return self;
}

- (void)initializeControllerWithCompletion:(CCViewControllerConfigInitializeComplete)complete {
    id userController = nil;
    
    if (self.useStoryboard) {
        userController = [self.storyboard instantiateViewControllerWithIdentifier:self.controllerStoryboardIdentifier];
    } else {
        if (self.xibName) {
            userController = [[self.klass alloc] initWithNibName:self.xibName bundle:nil];
        }
        userController = [[self.klass alloc] init];
    }
    
    dispatch_queue_t backgroundTasks = dispatch_queue_create("CCDebugHelper-Async", nil);
    dispatch_async(backgroundTasks, ^{
        
        self.asyncWait = dispatch_semaphore_create(0);
        
        [self fireUpBeforeActionWithIndex:0 onController:userController];
        
        dispatch_semaphore_wait(self.asyncWait, DISPATCH_TIME_FOREVER);
        
        if (self.shouldWrapControllerWithNavigationController) {
            complete([[self.navigationControllerClassName alloc] initWithRootViewController:userController]);
        } else {
            complete(userController);
        }
    });
}

- (void)fireUpBeforeActionWithIndex:(NSUInteger)index onController:(id)controller {
    
    if (index < self.beforeActions.count) {
        CCBeforeAction *action = self.beforeActions[index];
        
        if (!action.isAsync) {
            [self informDelegateAboutTriggeringActionWithName:action.name];
            ((CCViewControllerConfigBeforeAction)[action actionBlock])(controller);
            [self fireUpBeforeActionWithIndex:index + 1 onController:controller];
            [self checkFinishAsyncForIndex:index];
        } else {
            ((CCViewControllerConfigBeforeAsyncAction)[action actionBlock])(controller, ^{
                [self informDelegateAboutTriggeringActionWithName:action.name];
                [self fireUpBeforeActionWithIndex:index + 1 onController:controller];
                [self checkFinishAsyncForIndex:index];
            });
        }
    } else {
        [self checkFinishAsyncForIndex:index];
    }
}

- (void)checkFinishAsyncForIndex:(NSUInteger)index {
    if (index == self.beforeActions.count - 1 || self.beforeActions.count == 0) {
        dispatch_semaphore_signal(self.asyncWait);
    }
}

- (void)informDelegateAboutTriggeringActionWithName:(NSString *)name {
    if ([self.delegate respondsToSelector:@selector(performingActionWithName:)]) {
        [self.delegate performingActionWithName:name];
    }
}

#pragma mark XIB inits

+ (instancetype)configWithName:(NSString *)name
                 forController:(Class)controllerClass {
    return [CCViewControllerConfig configWithName:name forController:controllerClass xibName:nil];
}

+ (instancetype)configWithName:(NSString *)name
                 forController:(Class)controllerClass
                       xibName:(NSString *)xibName {
    
    CCViewControllerConfig *config = [[CCViewControllerConfig alloc] init];
    
    config.name = name;
    config.klass = controllerClass;
    config.useStoryboard = NO;
    config.xibName = xibName;
    
    return config;
}

#pragma mark Storyboard inits

+ (instancetype)configWithName:(NSString *)name
                 forController:(Class)controllerClass
          storyboardIdentifier:(NSString *)storyboardIdentifier
                    storyboard:(UIStoryboard *)storyboard {
    
    CCViewControllerConfig *config = [[CCViewControllerConfig alloc] init];
    
    config.name = name;
    config.klass = controllerClass;
    config.useStoryboard = YES;
    config.controllerStoryboardIdentifier = storyboardIdentifier;
    config.storyboard = storyboard;
    
    return config;
}

- (void)validateConfiguration {
    
    NSString *klassString = NSStringFromClass(self.klass);
    
    if (!self.klass) {
        [NSException raise:@"CCViewControllerConfig" format:@"Your controller '%@' class not exist", klassString];
    }
    
    if (self.useStoryboard) {
        if (!self.storyboard) {
            [NSException raise:@"CCViewControllerConfig" format:@"You need provide storyboard for '%@' class", klassString];
        }
        
        @try {
            [self.storyboard instantiateViewControllerWithIdentifier:self.controllerStoryboardIdentifier];
        } @catch (NSException *exception) {
            [NSException raise:@"CCViewControllerConfig" format:@"Storyboard identifier for '%@' class not exist in your storyboard file", klassString];
        }
    } else {
        if (self.xibName) {
            if([[NSBundle mainBundle] pathForResource:self.xibName ofType:@"nib"] != nil) {
                [NSException raise:@"CCViewControllerConfig" format:@"Xib '%@.xib/nib' file for '%@' class not exist", self.xibName, klassString];
            }
        } else {
            if([[NSBundle mainBundle] pathForResource:klassString ofType:@"nib"] != nil) {
                [NSException raise:@"CCViewControllerConfig" format:@"Xib '%@.xib/nib' file for '%@' class not exist", klassString, klassString];
            }
        }
    }
}

- (NSArray *)beforeActions {
    if (!_beforeActions) {
        _beforeActions = [[NSMutableArray alloc] init];
    }
    return _beforeActions;
}

- (void)addBeforeAction:(CCBeforeAction *)action {
    [self.beforeActions addObject:action];
}

- (NSString *)title {
    return self.name;
}

- (NSString *)subtitle {
    return NSStringFromClass(self.klass);
}

- (BOOL)hasBeforeActions {
    return (BOOL)self.beforeActions.count;
}

@end










