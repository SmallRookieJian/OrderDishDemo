//
//  NewsViewController.m
//  YiLiao
//
//  Created by MrCheng on 16/3/16.
//  Copyright © 2016年 zhiYou. All rights reserved.
//

#import "NewsViewController.h"
#import "CommonCell.h"
#import "PicCell.h"
#import "NewsDetailViewController.h"
@interface NewsViewController ()

@end

@implementation NewsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //初始化新闻数组,用来装新闻对象
    _newsArr = [[NSMutableArray alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 116;
    
    //注册cell
    [_tableView registerNib:[UINib nibWithNibName:@"CommonCell" bundle:nil] forCellReuseIdentifier:@"common"];
    [_tableView registerNib:[UINib nibWithNibName:@"PicCell" bundle:nil] forCellReuseIdentifier:@"pic"];
    //获取新闻列表
    [NetworkTool requestNewsListWithblock:^(NSDictionary *dic) {
        NSArray *newsArr = [dic objectForKey:@"news_list"];
        //遍历新闻数组,将所有的新闻字典初始化为数据模型并放入数组
        for (NSDictionary *newsDic in newsArr)
        {
            ZYNews *news = [[ZYNews alloc] initWithDictionary:newsDic];
            [_newsArr addObject:news];
        }
        //刷新表
        [_tableView reloadData];
    }];
}


#pragma mark -tableView协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _newsArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取当前cell的新闻对象
    ZYNews *news = [_newsArr objectAtIndex:indexPath.row];
    NSString *imgUrlStr = [NSString stringWithFormat:@"%@%@",HOST,news.imgUrl];
    if (news.type == 6)
    {
        //图片新闻
        PicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pic"];
        //选中样式为无
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text = news.title;
        cell.sourceLabel.text = news.source;
        for (int i = 0; i<3; i++)
        {
            //图片新闻的三张图片视图被关联在一个数组中,每次从此数组中找到一个图片视图并设置图片
            UIImageView *imgView = [cell.imgArr objectAtIndex:i];
            NSString *imgUrl = [[news.imgArr objectAtIndex:i] objectForKey:@"url"];
            NSString *url = [NSString stringWithFormat:@"%@%@",HOST,imgUrl];
            [imgView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"head.png"]];
        }
        return cell;
    }
    else
    {
        //普通新闻
        CommonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"common"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.headerImgView sd_setImageWithURL:[NSURL URLWithString:imgUrlStr] placeholderImage:[UIImage imageNamed:@"head.png"]];
        cell.titleLabel.text = news.title;
        cell.introLabel.text = news.intro;
        cell.sourceLabel.text = news.source;
        return cell;
    }
}

//选中某行跳转详细页面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取点击的新闻对象
    ZYNews *news = [_newsArr objectAtIndex:indexPath.row];
    NewsDetailViewController *newsVC = [[NewsDetailViewController alloc] init];
    //将点击的新闻对象传递到详细页面
    newsVC.news = news;
    //当push时隐藏tabBar
    newsVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:newsVC animated:YES];
}


@end
