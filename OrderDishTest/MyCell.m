//
//  MyCell.m
//  OrderDishTest
//
//  Created by mac on 16/2/22.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "MyCell.h"

#import "DishModel.h"
#import "AppDelegate.h"


@implementation MyCell

/*
 
 UILabel *numID;
 UILabel *DishName;
 UILabel *priceName;
 UILabel *kindName;
 UITextField *DishNameTF;
 UITextField *otherDetailTF;
 
 */

- (void)awakeFromNib
{
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _textFieldNum.tag = 1;
    _textFieldNum.delegate = self;
    _textFieldDetail.tag = 2;
    _textFieldDetail.delegate = self;
}

//- (OrderTable *)model {
//    
//    OrderTable *model = [[OrderTable alloc] init];
//    model.entity = [NSEntityDescription entityForName:<#(nonnull NSString *)#> inManagedObjectContext:<#(nonnull NSManagedObjectContext *)#>]
//    
////    return 
//    
//}

- (void)setIndex:(NSInteger)index {
    
    _index = index;
    
    _labelID.text = [NSString stringWithFormat:@"%ld",index];
    
}

- (void)setModel:(OrderTable *)model {
    
    _model = model;
    
    _labelName.text = model.name ;
    _labelPrice.text = model.price;
    _labelIKind.text = model.iKind;
    
    _textFieldNum.text = model.num;
    _textFieldDetail.text = model.detail;
    
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (textField.tag == 2) {
        
        if ([textField.text isEqualToString:@"空"]) {
            textField.text = nil;
            
        }
        
    }
    
    return YES;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField.tag == 1) {
        //是num的文本输入框
        
        if ([string integerValue]) {
            textField.text = nil;
            
        }
        
        return [string integerValue];
    }
    else {
        //是detail文本输入框
        
        return YES;
        
    }
    
}



- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    //在这里要保存一下数据
    //哼哼，又碰到了万恶的CoreData操作
    
    //修改
    AppDelegate *app = [[AppDelegate alloc] init];
    
    NSString *num = self.textFieldNum.text;
    NSString *detail = self.textFieldDetail.text;
    NSString *name = self.labelName.text;
    
    NSDictionary *dict = @{@"num":num,@"detail":detail,@"name":name};
    
    [app changeEntityName:@"OrderTable" withInfo:dict];
    
    if (textField.tag == 1) {
        
        if ([_delegate respondsToSelector:@selector(textFieldContentChanged:)]) {
            
            [_delegate textFieldContentChanged:textField.text];
            
        }
        
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"重新查询" object:self];
        
    }
    
    NSLog(@"did end editing ");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
