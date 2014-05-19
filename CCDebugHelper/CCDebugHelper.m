//
//  CCDebugHelper.m
//  CCDebugHelper
//
//  Created by Rafał Wójcik on 29.04.2014.
//  Copyright (c) 2014 Chilli Coders. All rights reserved.
//

#import "CCDebugHelper.h"
#import "CCListTableViewController.h"
#import "CCLoadingViewController.h"

@interface CCDebugHelper()

@property (nonatomic, strong) NSArray *viewControllers;
@property (nonatomic, weak) UIWindow *window;

@end

@implementation CCDebugHelper

- (instancetype)init {
    [NSException raise:NSStringFromClass([self class]) format:@"To initialize always use -initWithWindow: method"];
    return nil;
}

- (instancetype)initWithWindow:(UIWindow *)window {
    self = [super init];
    if (self) {
        self.window = window;
        self.viewControllers = [self viewControllersConfigs];
        [self verifyConfigs];
    }
    return self;
}

- (NSArray *)viewControllersConfigs {
    [NSException raise:NSStringFromClass([self class]) format:@"You need implement %@ method in your subclass", NSStringFromSelector(_cmd)];
    return nil;
}

- (void)verifyConfigs {
    [self.viewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (![obj isKindOfClass:[CCViewControllerConfig class]]) {
            [NSException raise:@"View Controller List" format:@"One of Config isn't CCViewControllerConfig class"];
        }
        CCViewControllerConfig *config = (CCViewControllerConfig *)obj;
        [config validateConfiguration];
    }];
}

- (id)loadingControllerWithConfigAtIndex:(NSUInteger)index {
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:CCDebugHelperBundle ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    
    if (self.viewControllers.count > index) {
        CCViewControllerConfig *config = [self.viewControllers objectAtIndex:index];
        CCLoadingViewController *loadingController = [[CCLoadingViewController alloc] initWithNibName:@"CCLoadingViewController" bundle:bundle];
        loadingController.config = config;
        return loadingController;
    } else {
        [NSException raise:NSStringFromClass([self class]) format:@"Controller config index is out of bound"];
    }
    
    return nil;
}

- (void)showControllerWithConfigIndex:(NSUInteger)index {
    [self setUserRootViewController:[self loadingControllerWithConfigAtIndex:index]];
}

- (void)setUserRootViewController:(id)controller {
    [self.window setRootViewController:controller];
    [self.window makeKeyAndVisible];
}

- (void)showControllersList {
    
    CCListTableViewController *controller = [[CCListTableViewController alloc] init];
    controller.helper = self;
    controller.configsList = self.viewControllers;
    
    [self setUserRootViewController:[[UINavigationController alloc] initWithRootViewController:controller]];
}


@end
