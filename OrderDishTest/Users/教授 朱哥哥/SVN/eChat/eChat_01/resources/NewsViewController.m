//
//  NewsViewController.m
//  eChat_01
//
//  Created by mac on 2016/3/12.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "NewsViewController.h"
#import "Request.h"
#import "MainCell.h"
#import "NewsModel.h"
#import "ImageModel.h"
#import "UIImageView+WebCache.h"//用来加载网络图片的第三方框架
#import "ImageMainCell.h"//多个图片cell
#import "DetailNewsViewController.h"//新闻详情页


@interface NewsViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSArray *_arrayNewsList;
    
}


@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新闻中心";
    _arrayNewsList = [[NSArray alloc] init];
    [self configurateTableView];
    
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [Request newsRequest:^(NSArray *arrayNews) {
        
        _arrayNewsList = arrayNews;
        
        [_tableView reloadData];
    }];
    
}

- (void)configurateTableView {
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:_tableView];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"MainCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [_tableView registerNib:[UINib nibWithNibName:@"ImageMainCell" bundle:nil] forCellReuseIdentifier:@"imageCell"];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark tableView协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrayNewsList.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NewsModel *model = _arrayNewsList[indexPath.row];
//    NSLog(@"row-->>%d----count-->>%d",indexPath.row,model.arrayImages.count);
    
    if (model.arrayImages.count == 3) {
        ImageMainCell *imageCell = [tableView dequeueReusableCellWithIdentifier:@"imageCell"];
        imageCell.labelTitle.text = model.news_title;
        imageCell.labelSource.text = model.source;
        imageCell.labelSource.textColor = [UIColor blueColor];
        
        NSMutableArray *arrayURLs = [NSMutableArray array];
        
        for (int i = 0; i < 3; i++) {
            
            ImageModel *image = model.arrayImages[i];
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:8080%@",image.url]];
            [arrayURLs addObject:url];
            
        }
        [imageCell.imageViewLeft sd_setImageWithURL:arrayURLs[0]];
        [imageCell.imageViewCenter sd_setImageWithURL:arrayURLs[1]];
        [imageCell.imageViewRight sd_setImageWithURL:arrayURLs[2]];
        return imageCell;
    }
    else {
        MainCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        cell.labelTitle.text = model.news_title;
        cell.labelIntroduce.text = model.intro;
        cell.labelSource.text = model.source;
        cell.labelSource.textColor = [UIColor blueColor];
        ImageModel *image = model.arrayImages[0];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:8080%@",image.url]];
        
        //在这里使用第三方框架加载图片
        [cell.imageView sd_setImageWithURL:url];
        return cell;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DetailNewsViewController *vcDetailNews = [[DetailNewsViewController alloc] init];
    [self.navigationController pushViewController:vcDetailNews animated:YES];
    vcDetailNews.model = _arrayNewsList[indexPath.row];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 122;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
