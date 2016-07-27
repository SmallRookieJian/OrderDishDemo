//
//  RightTableViewCell.m
//  OrderDishTest
//
//  Created by mac on 2016/4/8.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "RightTableViewCell.h"

#import <SDWebImage/UIImageView+WebCache.h>

@implementation RightTableViewCell




- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        _imgViewTitle = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 38, 108)];
        
        [self addSubview:_imgViewTitle];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    return self;
    
}


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        
    }
    return self;
}

- (void)setUrlImage:(NSURL *)urlImage {
    
    _urlImage = urlImage;
    
    [self.imgViewTitle sd_setImageWithURL:self.urlImage];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
