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
    }
    return self;
}

//直接使用set方法进行赋值
-(void)setFileInfo:(FileInfoModel *)fileInfo
{
    _fileInfo = fileInfo;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:fileInfo.image_url]];

    self.titleLab.text = fileInfo.tname;

}







@end
