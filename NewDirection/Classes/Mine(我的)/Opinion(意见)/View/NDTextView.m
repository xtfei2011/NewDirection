//
//  NDTextView.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/9.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDTextView.h"

@interface NDTextView ()
/*** 占位文字 Label ***/
@property (nonatomic ,strong) UILabel *placehoderLable;
/*** 文字个数提醒 ***/
@property (nonatomic ,strong) UILabel *textNumLabel;
@end

@implementation NDTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        
        [self addObserver];
        [self setupTextView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if ([super initWithCoder:aDecoder]) {
        
        [self addObserver];
        [self setupTextView];
    }
    return self;
}

- (instancetype)init
{
    if ([super init]) {
        
        [self addObserver];
        [self setupTextView];
    }
    return self;
}

- (void)setupTextView
{
    _placehoderLable = [[UILabel alloc] initWithFrame:self.bounds];
    _placehoderLable.textColor = [UIColor lightGrayColor];
    _placehoderLable.numberOfLines = 0;
    _placehoderLable.font = NDCommentTitleFont;
    [self addSubview:_placehoderLable];
    
    _textNumLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _textNumLabel.font = NDCommentTitleFont;
    _textNumLabel.textColor = [UIColor lightGrayColor];
    _textNumLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_textNumLabel];
}

- (void)setPlacehoder:(NSString *)placehoder
{
    _placehoder = placehoder;
    
    _placehoderLable.text = _placehoder;
    
    [self.placehoderLable sizeToFit];
    
    [self endEditing:NO];
}

- (void)setMaxLength:(NSInteger)maxLength
{
    _maxLength = maxLength;
    self.textNumLabel.text  = [NSString stringWithFormat:@"0/%ld", (long)_maxLength];
}

- (void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    
    _placehoderLable.textColor = titleColor;
}

- (void)addObserver
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextViewTextDidChangeNotification object:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(placeholderTextViewChange:) name:UITextViewTextDidChangeNotification object:self];
}

- (void)placeholderTextViewChange:(NSNotification *)notificat
{
    NDTextView *textView = (NDTextView *)notificat.object;
    
    if ([self.text length] > 0) {
        
        [self.placehoderLable setHidden:YES];
    } else {
        [self.placehoderLable setHidden:NO];
    }
    
    if ([textView.text length] > self.maxLength && self.maxLength != 0 && textView.markedTextRange == nil) {
//        [TFProgressHUD showInfoMsg:@"超过上限啦"];
        textView.text = [textView.text substringToIndex:self.maxLength];
    }
    self.textNumLabel.text = [NSString stringWithFormat:@"%ld/%ld",(long)[textView.text length], (long)_maxLength];
    
    if (self.changeText) {
        self.changeText(textView);
    }
    [self refreshData];
}

- (void)changeText:(void (^)(NDTextView *))block
{
    self.changeText = block;
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    if (text.length > 0) {
        
        [self.placehoderLable setHidden:YES];
        _textNumLabel.text = [NSString stringWithFormat:@"%ld/%ld",(long)[text length], (long)_maxLength];
        
        [self.textNumLabel sizeToFit];
        [self refreshData];
    }
}

- (void)refreshData
{
    [self.textNumLabel sizeToFit];
    
    if (self.contentSize.height > self.xtfei_height - self.textNumLabel.xtfei_height - 5) {
        
        self.textNumLabel.frame = CGRectMake(self.xtfei_width - self.textNumLabel.xtfei_width - 5, self.contentSize.height + self.contentInset.bottom - self.textNumLabel.xtfei_height - 5, self.textNumLabel.xtfei_width, self.textNumLabel.xtfei_height);
        self.contentInset = UIEdgeInsetsMake(0, 0, self.textNumLabel.xtfei_height, 0);
    } else {
        
        self.textNumLabel.frame = CGRectMake(self.xtfei_width - self.textNumLabel.xtfei_width - 5, self.xtfei_height + self.contentInset.bottom - self.textNumLabel.xtfei_height - 5, self.textNumLabel.xtfei_width, self.textNumLabel.xtfei_height);
        self.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
}

- (void)layoutSubviews
{
    self.placehoderLable.frame = CGRectMake(8, 6, self.xtfei_width - 8, self.xtfei_height);
    [self.placehoderLable sizeToFit];
    [self.textNumLabel sizeToFit];
    [self refreshData];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
