//
//  FriendListCell.h
//  eChat_01
//
//  Created by mac on 2016/3/13.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgViewHeader;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelText;
@property (weak, nonatomic) IBOutlet UILabel *labelMessageNum;

@end
