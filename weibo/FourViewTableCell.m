//
//  FourViewTableCell.m
//  weibo
//
//  Created by wenkai on 16/3/13.
//  Copyright © 2016年 wenkai. All rights reserved.
//

#import "FourViewTableCell.h"

@implementation FourViewTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.textLabel.font = [UIFont systemFontOfSize:kGeneralFontSize];
    }
    return self;
}

@end
