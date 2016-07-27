//
//  ImageMainCell.h
//  eChat_01
//
//  Created by mac on 2016/3/13.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageMainCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelSource;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewLeft;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewCenter;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewRight;

@end
