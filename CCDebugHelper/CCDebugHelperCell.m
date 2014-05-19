//
//  CCDebugHelperCell.m
//  CCDebugHelper
//
//  Created by Rafał Wójcik on 05.05.2014.
//  Copyright (c) 2014 Chilli Coders. All rights reserved.
//

#import "CCDebugHelperCell.h"

@interface CCDebugHelperCell()

@property (weak, nonatomic) IBOutlet UIView *iconBackground;
@property (weak, nonatomic) IBOutlet UILabel *iconLetter;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;

@end

@implementation CCDebugHelperCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.iconBackground.layer.cornerRadius = 5.0f;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.titleLabel.textColor = [UIColor blackColor];
    self.subtitleLabel.textColor = [UIColor grayColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    if (selected) {
        self.backgroundColor = self.iconBackground.backgroundColor;
        self.titleLabel.textColor = [UIColor whiteColor];
        self.subtitleLabel.textColor = [UIColor whiteColor];
    } else {
        self.backgroundColor = [UIColor whiteColor];
        self.titleLabel.textColor = [UIColor blackColor];
        self.subtitleLabel.textColor = [UIColor grayColor];
    }
    
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

- (void)setSubtitle:(NSString *)subtitle {
    subtitle = subtitle;
    self.subtitleLabel.text = subtitle;
}

- (void)setType:(CCDebugHelperCellType)type {
    _type = type;
    switch (type) {
        case CCDebugHelperCellTypeStoryBoard:
            self.iconLetter.text = @"S";
            self.iconBackground.backgroundColor = [UIColor colorWithRed:217/255.0 green:30/255.0 blue:24/255.0 alpha:1];
            break;
        case CCDebugHelperCellTypeXIB:
            self.iconLetter.text = @"X";
            self.iconBackground.backgroundColor = [UIColor colorWithRed:244/255.0 green:179/255.0 blue:80/255.0 alpha:1];
            break;
        case CCDebugHelperCellTypeView:
            self.iconLetter.text = @"V";
            self.iconBackground.backgroundColor = [UIColor colorWithRed:82/255.0 green:179/255.0 blue:217/255.0 alpha:1];
            break;
    }
}

@end
