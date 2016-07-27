//
//  DetailNewsViewController.m
//  eChat_01
//
//  Created by mac on 2016/3/13.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "DetailNewsViewController.h"
#import "NewsModel.h"
#import "Request.h"
#import "TitleCell.h"
#import "ContentCell.h"
#import "ImageDetailCell.h"
#import "DataModel.h"
#import "DetailImageModel.h"
#import "UIImageView+WebCache.h"
#import "CommentCell.h"
#import "CommentModel.h"

@interface DetailNewsViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSArray *_arrayDatas;
    NSArray *_arrayComments;
    
}


@end

@implementation DetailNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _arrayDatas = [NSArray array];
    _arrayComments = [NSArray array];
    
    self.title = self.model.channel;
    [self configurateTableView];
    
    [Request detailNewsRequestWithString:self.model.source_url WithBlock:^(NSArray *arrayDatas,NSArray *arrayComments) {
        
        _arrayDatas = arrayDatas;
        _arrayComments = arrayComments;
        
        [_tableView reloadData];
        
    }];
    
    
    
}
- (void)configurateTableView {
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellEditingStyleNone;
    
    [self.view addSubview:_tableView];
    [_tableView registerNib:[UINib nibWithNibName:@"TitleCell" bundle:nil] forCellReuseIdentifier:@"titleCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"ContentCell" bundle:nil] forCellReuseIdentifier:@"contentCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"ImageDetailCell" bundle:nil] forCellReuseIdentifier:@"imageDetailCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"CommentCell" bundle:nil] forCellReuseIdentifier:@"commentCell"];
}


#pragma mark 表的协议方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1 + 1 + _arrayDatas.count;
    }
    if (section == 1) {
        return _arrayComments.count;
    }
    if (section == 2) {
        return 2;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            
            TitleCell *titleCell = [tableView dequeueReusableCellWithIdentifier:@"titleCell"];
            titleCell.selectionStyle = UITableViewCellSelectionStyleNone;
            titleCell.labelTitle.text = self.model.news_title;
            titleCell.labelSource.text = self.model.source;
            titleCell.labelAuthor.text = self.model.auther;
            titleCell.labelTime.text = self.model.time;
            return titleCell;
            
        }
        ContentCell *contentCell = [tableView dequeueReusableCellWithIdentifier:@"contentCell"];
        ImageDetailCell *imageDetailCell = [tableView dequeueReusableCellWithIdentifier:@"imageDetailCell"];
        
        if (indexPath.row == 1) {
            
            CGRect rect =  [self getRectWith:self.model.intro WithFontSize:15];
            contentCell.labelContent.frame = CGRectMake(10, 10, rect.size.width, rect.size.height);
            contentCell.labelContent.text = self.model.intro;
            return contentCell;
            
        }
        //判断是否在内容区
        if (indexPath.row < 2 + _arrayDatas.count) {
            ///到了这里正式的进入内容的排版阶段
            
            //在这里需要注意一下的是，，，再去数据的时候，，表上展示的要比数组中的多两个，，，所以表上的第二个，，，代表数组中的第一个
            DataModel *data = _arrayDatas[indexPath.row - 2];
            //        NSLog(@"data____%@",data);
            if (data.data_type == 1) {
                //在这里数据内容是  文字
                
                CGRect rect = [self getRectWith:data.content WithFontSize:15];
                contentCell.labelContent.frame = CGRectMake(10, 10, rect.size.width, rect.size.height);
                
                contentCell.labelContent.text = data.content;
                return contentCell;
                
            }
            if (data.data_type == 2) {
                //到了这里就该加载图片了
                DetailImageModel *image = data.imageModel;
                NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:8080%@",image.source]];
                
                
                imageDetailCell.imageView.frame = CGRectMake(10, 10, 300, image.height);
                
                //在这里使用第三方框架加载图片
                [imageDetailCell.imageView sd_setImageWithURL:url];
                return imageDetailCell;
                
            }
        }
    }
    
    
    if (indexPath.section == 1) {
        CommentCell *commentCell = [tableView dequeueReusableCellWithIdentifier:@"commentCell"];
        //判断是否在评论区
        if (indexPath.row < _arrayDatas.count + _arrayComments.count + 2) {
            CommentModel *model = _arrayComments[indexPath.row];
            commentCell.labelCommentName.text = model.name;
            commentCell.labelCommentContent.text = model.info;
            return commentCell;
            
        }
    }
    
    
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] init];
    }
    cell.textLabel.text = @"许建";
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        //判断是否在内容区
        if (indexPath.row < _arrayDatas.count + 2) {
            if (indexPath.row == 0) {
                return 51;
            }
            if (indexPath.row == 1) {
                //为摘要行
                CGRect rect = [self getRectWith:self.model.intro WithFontSize:15];
                return rect.size.height + 20;
                //        return 100;
            }
            DataModel *data = _arrayDatas[indexPath.row - 2];
            
            if (data.data_type == 1) {
                //数据内容为     文字
                return [self getRectWith:data.content WithFontSize:15].size.height + 20;
                
            }
            if (data.data_type == 2) {
                
                return data.imageModel.height + 20;
            }
        }
    }
    
    if (indexPath.section == 1) {
        return 69;
    }
    
    return 60;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return @"热门跟帖";
    }
    return nil;
}
- (CGRect)getRectWith:(NSString *)string WithFontSize:(int)size {
    CGRect rect = [string boundingRectWithSize:CGSizeMake(300, 0) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:size]} context:nil];
    return rect;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
