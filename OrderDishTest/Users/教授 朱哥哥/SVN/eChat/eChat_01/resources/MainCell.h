//
//  MainCell.h
//  eChat_01
//
//  Created by mac on 2016/3/12.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainCell : UITableViewCell

//source    news_title  intro   arrayImages

@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelIntroduce;
@property (weak, nonatomic) IBOutlet UILabel *labelSource;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end
