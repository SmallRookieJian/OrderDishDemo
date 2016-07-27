//
//  PicCell.h
//  YiLiao
//
//  Created by MrCheng on 16/3/17.
//  Copyright © 2016年 zhiYou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PicCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imgArr;




@end
