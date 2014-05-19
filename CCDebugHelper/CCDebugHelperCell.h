//
//  CCDebugHelperCell.h
//  CCDebugHelper
//
//  Created by Rafał Wójcik on 05.05.2014.
//  Copyright (c) 2014 Chilli Coders. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CCDebugHelperCellType) {
    CCDebugHelperCellTypeStoryBoard,
    CCDebugHelperCellTypeXIB,
    CCDebugHelperCellTypeView
};


@interface CCDebugHelperCell : UITableViewCell

@property (nonatomic, assign) CCDebugHelperCellType type;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subtitle;

@end
