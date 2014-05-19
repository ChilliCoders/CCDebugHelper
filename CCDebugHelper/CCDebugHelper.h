//
//  CCDebugHelper.h
//  CCDebugHelper
//
//  Created by Rafał Wójcik on 29.04.2014.
//  Copyright (c) 2014 Chilli Coders. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCDebugHelperConstants.h"
#import "CCViewControllerConfig.h"

@interface CCDebugHelper : NSObject

- (instancetype)initWithWindow:(UIWindow *)window;

- (id)loadingControllerWithConfigAtIndex:(NSUInteger)index;
- (void)showControllerWithConfigIndex:(NSUInteger)index;
- (void)showControllersList;

@end
