//
//  RSQuestionFeedBackSecondCell.m
//  石来石往
//
//  Created by mac on 2018/7/6.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSQuestionFeedBackSecondCell.h"


@interface RSQuestionFeedBackSecondCell()<UITextViewDelegate>

{
    UILabel * _placeHolderLabel;
}
//@property (nonatomic,strong)NSString * StempStr;

@end


@implementation RSQuestionFeedBackSecondCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UITextView * textView = [[UITextView alloc]init];
        textView.delegate = self;
        [self.contentView addSubview:textView];
        
        
        
        RSSFLabel * placeHolderLabel = [[RSSFLabel alloc]init];
        placeHolderLabel.text = @"请描述您使用石来石往时遇到的问题和意见，若功能异常，上传页面截图更快解决哦!";
        placeHolderLabel.numberOfLines = 0;
        placeHolderLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        placeHolderLabel.font = [UIFont systemFontOfSize:15];
        placeHolderLabel.textAlignment = NSTextAlignmentCenter;
        [textView addSubview: placeHolderLabel];
        _placeHolderLabel = placeHolderLabel;
        
        textView.sd_layout
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .topSpaceToView(self.contentView, 0)
        .bottomSpaceToView(self.contentView, 0);
        
        
        
        placeHolderLabel.sd_layout
        .leftSpaceToView(textView, 14)
        .rightSpaceToView(textView, 14)
        .topSpaceToView(textView, 0)
        .bottomSpaceToView(textView, 14);
        
    }
    return self;
}





#pragma makr - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView
{
        NSString *temp = [textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([temp length]!=0) {
        _placeHolderLabel.text = @"";
        temp = [self delSpaceAndNewline:temp];
        if ([self.delegate respondsToSelector:@selector(inputTextViewContent:)]) {
            [self.delegate inputTextViewContent:temp];
        }
       // _StempStr = temp;
       
        }else{
        _placeHolderLabel.text = @"请描述您使用石来石往时遇到的问题和意见，若功能异常，上传页面截图更快解决哦!";
       // _StempStr = @"";
       }
}


- (void)textViewDidEndEditing:(UITextView *)textView{
     NSString *temp = [textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if (temp.length > 1) {
        temp = [self delSpaceAndNewline:temp];
        if ([self.delegate respondsToSelector:@selector(inputTextViewContent:)]) {
            [self.delegate inputTextViewContent:temp];
        }
    }else{
        
       
    }
   
}

- (NSString *)delSpaceAndNewline:(NSString *)string;{
    NSMutableString *mutStr = [NSMutableString stringWithString:string];
    NSRange range = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (range.location < 500)
    {
        if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
            //在这里做你响应return键的代码
            [textView resignFirstResponder];
            return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
        }
        return  YES;
    } else {
        return NO;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
