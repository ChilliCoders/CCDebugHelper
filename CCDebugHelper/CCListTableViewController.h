//
//  ListTableViewController.h
//  CCDebugHelper
//
//  Created by Rafał Wójcik on 30.04.2014.
//  Copyright (c) 2014 Chilli Coders. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCDebugHelper.h"

@interface CCListTableViewController : UITableViewController

@property (nonatomic, strong) CCDebugHelper *helper;
@property (nonatomic, strong) NSArray *configsList;

@end
