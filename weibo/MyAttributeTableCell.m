//
//  MyAttributeTableCell.m
//  weibo
//
//  Created by wenkai on 16/3/17.
//  Copyright © 2016年 wenkai. All rights reserved.
//

#import "MyAttributeTableCell.h"

@implementation MyAttributeTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _userImageView = [UIImageView new];
        [self.contentView addSubview:_userImageView];
        
        _userNameLabel = [UILabel new];
        [self.contentView addSubview:_userNameLabel];
        _userNameLabel.font = [UIFont systemFontOfSize:kGeneralFontSize];
        
        _desLabel = [UILabel new];
        [self.contentView addSubview:_desLabel];
        _desLabel.font = [UIFont systemFontOfSize:kSmallFontSize];
        _desLabel.numberOfLines = 2;
        
        [_userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];
        
        [_userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_userImageView.mas_top);
            make.left.equalTo(_userImageView.mas_right).offset(10);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
        }];
        
        [_desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_userNameLabel.mas_left);
            make.right.equalTo(_userNameLabel.mas_right);
            make.top.equalTo(_userNameLabel.mas_bottom).offset(5);
        }];
    }
    return self;
}

@end
