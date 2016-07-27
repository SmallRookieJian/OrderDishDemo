//
//  NewsDetailViewController.h
//  YiLiao
//
//  Created by MrCheng on 16/3/17.
//  Copyright © 2016年 zhiYou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    __weak IBOutlet UITableView *_tableView;
    NSMutableArray *_contentArr,*_commentsArr;
}

@property (nonatomic,retain)ZYNews *news;


@end
