//
//  TableViewCell.m
//  GCD应用
//
//  Created by tarena on 16/5/13.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
//当点击单元格cell的时候，会自动触发这个方法 父类会自动重新设置cell的imageView的frame
    // Configure the view for the selected state
    //自定义cell选中的颜色
    if (selected) {
        [self setBackgroundColor:[UIColor colorWithRed:245.0/255 green:245.0/255 blue:245.0/255 alpha:1]];
    }else{
    [self setBackgroundColor:[UIColor whiteColor]];
    }
}

@end
