//
//  NewsDetailViewController.m
//  YiLiao
//
//  Created by MrCheng on 16/3/17.
//  Copyright © 2016年 zhiYou. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "NewsDetailCell.h"
@interface NewsDetailViewController ()

@end

@implementation NewsDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //初始化评论和正文数组
    _commentsArr = [[NSMutableArray alloc] init];
    _contentArr = [[NSMutableArray alloc] init];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 375, 60)];
    //标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = self.news.title;
    titleLabel.frame = CGRectMake(5, 5, 365, 30);
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [header addSubview:titleLabel];
    //来源
    UILabel *sourceLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 40, 80, 20)];
    sourceLabel.text = self.news.source;
    [header addSubview:sourceLabel];
    //作者
    UILabel *autherLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 40, 100, 20)];
    autherLabel.text = [NSString stringWithFormat:@"%@/文",self.news.author];
    [header addSubview:autherLabel];
    //时间
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(250, 40, 120, 20)];
    timeLabel.text = self.news.time;
    [header addSubview:timeLabel];
    //设置为表头
    _tableView.tableHeaderView = header;

    //注册cell
    [_tableView registerNib:[UINib nibWithNibName:@"NewsDetailCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    //获取新闻详细信息并刷新tableview
    [NetworkTool requestNewsDetailInformation:self.news.source_url block:^(NSDictionary *dic) {
        [_contentArr setArray:[dic objectForKey:@"data"]];//获取正文数组
        [_commentsArr  setArray:[dic objectForKey:@"comments"]];//获取评论
        [_tableView reloadData];
    }];
}

//分2区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        //正文区行数
        return _contentArr.count;
    }
    //评论区行数
    return _commentsArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        //正文
        NewsDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //从正文数组中获取当前刷新的cell对应的内容(内容是以字典方式组织的)
        NSDictionary *newsDic = [_contentArr objectAtIndex:indexPath.row];
        //根据数据的data_type判断是文本还是图片
        if ([[newsDic objectForKey:@"data_type"] integerValue] == 1)
        {
            //文本
            cell.imgView.hidden = YES;//隐藏图片
            cell.contentlabel.hidden = NO;//显示文本
            cell.contentlabel.text = [NSString stringWithFormat:@"      %@",[newsDic objectForKey:@"content"]];
            //计算文本rect,用于设置label的大小
            CGRect rect = [CommandTool getTextRectWithString:cell.contentlabel.text withWidth:365 withFontSize:17];
            cell.contentlabel.frame = CGRectMake(5, 5, 365, rect.size.height+10);
        }
        else
        {
            //图片
            cell.imgView.hidden = NO;//显示图片
            cell.contentlabel.hidden = YES;//隐藏文本
            NSString *urlStr = [NSString stringWithFormat:@"%@%@",HOST,[[newsDic objectForKey:@"image"] objectForKey:@"source"]];
            [cell.imgView sd_setImageWithURL:[NSURL URLWithString:urlStr]];
            NSInteger height = [[[newsDic objectForKey:@"image"] objectForKey:@"height"] integerValue];
            NSInteger width = [[[newsDic objectForKey:@"image"] objectForKey:@"width"] integerValue];
            //将图片宽高等比例拉伸
            NSInteger strenthHeight = 1.0*365/width*height;
            //设置图片的宽高
            cell.imgView.frame = CGRectMake(5, 5, 365,strenthHeight);
        }
        return cell;
    }
    else
    {
        //评论
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commonCell"];
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"commonCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSDictionary *comentsDic = [_commentsArr objectAtIndex:indexPath.row];
        cell.textLabel.text = [comentsDic objectForKey:@"name"];
        cell.textLabel.textColor = [UIColor blueColor];
        cell.detailTextLabel.text = [comentsDic objectForKey:@"info"];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
        cell.detailTextLabel.numberOfLines = 0;
        return cell;
    }
}

//设定每一行cell各自的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        NSDictionary *newsDic = [_contentArr objectAtIndex:indexPath.row];
        if ([[newsDic objectForKey:@"data_type"] integerValue] == 1)
        {
            //文本
            NSString *str = [newsDic objectForKey:@"content"];
            CGRect rect = [CommandTool getTextRectWithString:str withWidth:365 withFontSize:17];
            return rect.size.height+15;
        }
        else
        {
            //图片
            NSInteger height = [[[newsDic objectForKey:@"image"] objectForKey:@"height"] integerValue];
            NSInteger width = [[[newsDic objectForKey:@"image"] objectForKey:@"width"] integerValue];
            //图片高度等比例拉伸
            NSInteger strenthHeight = 1.0*365/width*height;
            return strenthHeight+10;
        }
    }
    else
    {
        NSDictionary *comentsDic = [_commentsArr objectAtIndex:indexPath.row];
        NSString *str = [comentsDic objectForKey:@"info"];
        CGRect rect = [CommandTool getTextRectWithString:str withWidth:365 withFontSize:15];
        return rect.size.height + 30;
    }
}

//返回自定义区头
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    if (!header) {
        header = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"header"];
        header.layer.backgroundColor = [[UIColor lightGrayColor] CGColor];
        UILabel *label = [[UILabel alloc] init];
        label.tag = 10;
        label.numberOfLines = 0;
        [header addSubview:label];
    }
    //找到区头上的对应label
    UILabel *label = (UILabel *)[header viewWithTag:10];
    if (section == 0)
    {
        label.text = [NSString stringWithFormat:@"      %@",self.news.intro];
        CGRect rect = [CommandTool getTextRectWithString:label.text withWidth:365 withFontSize:17];
        label.frame = CGRectMake(5, 5, 365, rect.size.height+10);
    }
    else
    {
        label.text = @"热门跟帖";
        label.frame = CGRectMake(10, 10, 200, 20);
    }
    
    return header;
}
//设置区头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        NSString *str = [NSString stringWithFormat:@"      %@",self.news.intro];
        CGRect rect = [CommandTool getTextRectWithString:str withWidth:365 withFontSize:17];
        return rect.size.height + 10;
    }
    else
    {
        return 40;
    }
}






@end
