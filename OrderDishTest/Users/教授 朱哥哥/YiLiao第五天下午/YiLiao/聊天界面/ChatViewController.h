//
//  ChatViewController.h
//  YiLiao
//
//  Created by MrCheng on 16/3/16.
//  Copyright © 2016年 zhiYou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    __weak IBOutlet UITableView *_tableView;
    NSMutableArray *_peopleArr;
}
@end
