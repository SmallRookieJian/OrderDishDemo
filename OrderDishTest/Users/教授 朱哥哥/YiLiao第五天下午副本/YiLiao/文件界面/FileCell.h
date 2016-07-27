//
//  FileCell.h
//  YiLiao
//
//  Created by Mega on 16/3/22.
//  Copyright © 2016年 zhiYou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FileListModel.h"

@interface FileCell : UICollectionViewCell<FileInfoModelDelegate>

@property (nonatomic,strong) UIImageView *iconView;

@property (nonatomic,strong) UILabel *titleLab;
//传入的model 我只关心给我什么数据 不关心你从哪来的
@property (nonatomic,strong) FileInfoModel *fileInfo;
//显示 查看 等状态
@property (nonatomic,strong) UILabel *lookLabel;
//半透明的遮罩
@property (nonatomic,strong) UIView *grayView;









@end
