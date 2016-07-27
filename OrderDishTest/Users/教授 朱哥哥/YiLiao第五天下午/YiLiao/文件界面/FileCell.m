//
//  FileCell.m
//  YiLiao
//
//  Created by Mega on 16/3/22.
//  Copyright © 2016年 zhiYou. All rights reserved.
//

#import "FileCell.h"

@implementation FileCell
-(id)initWithFrame:(CGRect)frame
{

    self = [super initWithFrame:frame];

    if (self) {

        _iconView =[[UIImageView alloc]init];
        _iconView.frame = CGRectMake(0, 0, 100, 100);

        [self addSubview:self.iconView];

        _titleLab = [[UILabel alloc]init];
        _titleLab.frame = CGRectMake(0, 100, 100, 30);
        _titleLab.text = @"测试";
        [self addSubview:self.titleLab];

        _lookLabel = [[UILabel alloc]init];
        _lookLabel.frame = CGRectMake(0, 0, 100, 100);
        _lookLabel.backgroundColor = [UIColor clearColor];
        _lookLabel.text = @"查看";
        _lookLabel.textAlignment = NSTextAlignmentCenter;
        _lookLabel.hidden = YES;
        [self addSubview:self.lookLabel];


        _grayView = [[UIView alloc]init];

//colorWithWhite 设置的是灰度
        _grayView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
        [self addSubview:self.grayView];
        
    }
    return self;
}

//直接使用set方法进行赋值
-(void)setFileInfo:(FileInfoModel *)fileInfo
{
    _fileInfo = fileInfo;
    _fileInfo.delegate  = self;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:fileInfo.image_url]];

    self.titleLab.text = fileInfo.tname;


    if (self.fileInfo.downLoadType == FileModelDownLoaded) {
        self.lookLabel.hidden = NO;
//        self.lookLabel.text = @"";
        self.grayView.frame = CGRectMake(0, 0, 0, 0);
    }else if(self.fileInfo.downLoadType == FileModelUnDownLoad)
    {
        self.lookLabel.hidden = NO;
        self.lookLabel.text = @"下载";
        self.grayView.frame = CGRectMake(0, 0, 100, 100);
    }


}

-(void)downLoadProgress:(float)progress
{

    NSLog(@"2-----%f",progress);
    self.lookLabel.hidden = NO;
    self.lookLabel.text = @"下载中";//再添加下载的百分比
    self.grayView.frame = CGRectMake(0, 100*progress, 100, 100- 100*progress);

    if (progress == 1) {
        self.lookLabel.text = @"查看";

    }

}





@end
