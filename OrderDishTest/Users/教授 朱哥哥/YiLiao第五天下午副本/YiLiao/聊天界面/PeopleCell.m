//
//  PeopleCell.m
//  YiLiao
//
//  Created by MrCheng on 16/3/18.
//  Copyright © 2016年 zhiYou. All rights reserved.
//

#import "PeopleCell.h"

@implementation PeopleCell

- (void)awakeFromNib {
    
    //设置颜色

    self.messageLabel.backgroundColor = [UIColor redColor];
    //设置消息label的圆角
    self.messageLabel.layer.cornerRadius = 20;
    self.messageLabel.layer.masksToBounds = YES;
    
    self.headerImgView.layer.cornerRadius = 45;
    self.headerImgView.layer.masksToBounds = YES;
    
    self.headerBtn.frame = self.headerImgView.frame;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}







@end
