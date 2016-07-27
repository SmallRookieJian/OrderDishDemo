//
//  FileViewController.h
//  YiLiao
//
//  Created by MrCheng on 16/3/16.
//  Copyright © 2016年 zhiYou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FileCell.h"
#import "FileListModel.h"
#import "NetworkTool.h"

#import "FileInfoViewController.h"

@interface FileViewController : UIViewController<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

//导航栏分段选择器
@property (nonatomic,strong) UISegmentedControl *topSegmentControl;

//底部滑动视图
@property (nonatomic,strong) UIScrollView *commeScrollView;

//左边瀑布流
@property (nonatomic,strong) UICollectionView *leftCollection;
//右边瀑布流
@property (nonatomic,strong) UICollectionView *rightCollection;


@property (nonatomic,strong) FileListModel *fileListModel;
















@end
