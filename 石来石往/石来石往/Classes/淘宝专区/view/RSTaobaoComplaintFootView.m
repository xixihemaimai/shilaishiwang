//
//  RSTaobaoComplaintFootView.m
//  石来石往
//
//  Created by mac on 2019/8/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSTaobaoComplaintFootView.h"


@interface RSTaobaoComplaintFootView()<UITextViewDelegate>

@end

@implementation RSTaobaoComplaintFootView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        //评论
        UITextView * explainTextView = [[UITextView alloc]init];
        explainTextView.zw_placeHolder = @"详细说明投诉情况（选填，200以内）";
        explainTextView.font = [UIFont systemFontOfSize:12];
        explainTextView.delegate = self;
        explainTextView.returnKeyType = UIReturnKeyDone;
        [self.contentView addSubview:explainTextView];
        _explainTextView = explainTextView;
        
        
        
        //描述
        UILabel * detailLabel = [[UILabel alloc]init];
        detailLabel.text = @"请合理使用投诉功能，恶意举报将受到相应的处罚";
        detailLabel.font = [UIFont systemFontOfSize:12];
        detailLabel.textAlignment = NSTextAlignmentCenter;
        detailLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
        [self.contentView addSubview:detailLabel];
        
        
        //确定
        
        UIButton * sureSubmissionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [sureSubmissionBtn setTitle:@"确定提交" forState:UIControlStateNormal];
        sureSubmissionBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [sureSubmissionBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#FF4B33"]];
        [self.contentView addSubview:sureSubmissionBtn];
        _sureSubmissionBtn = sureSubmissionBtn;
        
        
        explainTextView.sd_layout
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .topSpaceToView(self.contentView, 10)
        .heightIs(116);
        
        
        detailLabel.sd_layout
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .topSpaceToView(explainTextView, 42)
        .heightIs(17);
        
        
        sureSubmissionBtn.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .rightSpaceToView(self.contentView, 12)
        .topSpaceToView(detailLabel, 19)
        .heightIs(43);
        
        sureSubmissionBtn.layer.cornerRadius = 22;
        
        [IQKeyboardManager sharedManager].enable = NO;
        
 
    }
    return self;
}




- (void)textViewDidEndEditing:(UITextView *)textView{
    NSString * temp = [textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    temp = [self delSpaceAndNewline:temp];
    if ([temp length] > 0) {
        _explainTextView.text = temp;
    }else{
        _explainTextView.text = @"";
    }
}








- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    //控制文本输入内容
    if (range.location >= 200){
        //控制输入文本的长度
        return  NO;
    }
    if ([text isEqualToString:@"\n"]){
        //禁止输入换行
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}


- (NSString *)delSpaceAndNewline:(NSString *)string{
    NSMutableString *mutStr = [NSMutableString stringWithString:string];
    NSRange range = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}



@end
