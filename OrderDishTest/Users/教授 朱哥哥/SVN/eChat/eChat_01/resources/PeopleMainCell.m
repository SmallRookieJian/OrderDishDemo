//
//  PeopleMainCell.m
//  eChat_01
//
//  Created by mac on 2016/3/13.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "PeopleMainCell.h"

@implementation PeopleMainCell

- (void)awakeFromNib {
    // Initialization code
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.imgViewHeader.layer.cornerRadius = 38;
    self.imgViewHeader.layer.masksToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
