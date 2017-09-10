//
//  ServiceDescriptionController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/8/4.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "ServiceDescriptionController.h"
#import "PlaceTextView.h"
#import "PublishServiceController.h"

#define kTextBorderColor     RGBCOLOR(227,224,216)
#undef  RGBCOLOR
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

@interface ServiceDescriptionController ()<UITextViewDelegate>

@property (nonatomic, strong) PlaceTextView * textView;
@property (nonatomic, strong) UILabel * oneLabel;
@property (nonatomic, strong) UILabel * twoLabel;
@property (nonatomic, strong) UILabel * threeLabel;


@end

@implementation ServiceDescriptionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self titleViewWithTitle:@"服务描述" titleColor:[UIColor whiteColor]];
    [self rightItemWithNormalName:@"" title:@"完成" titleColor:[UIColor whiteColor] selector:@selector(rightBarClick) target:self];
    
    self.view.backgroundColor = [UIColor colorWithRed:229.0/255 green:229.0/255 blue:229.0/255 alpha:1.0f];
    
    self.textView.returnKeyType = UIReturnKeyDone;

    
    [self.view addSubview:self.oneLabel];
    [self.view addSubview:self.twoLabel];
    [self.view addSubview:self.threeLabel];
    [self.view addSubview:self.textView];
    
}

- (void)rightBarClick{
    NSLog(@"=======%@",self.textView.text);
    @weakify(self);
    [PushManager popViewControllerWithName:@"PublishServiceController" animated:YES block:^(PublishServiceController* viewController) {
        @strongify(self);
        viewController.content = self.textView.text;
    }];

}

- (UILabel *)oneLabel{
    if (!_oneLabel) {
        _oneLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200, 50)];
        _oneLabel.text = @"服务内容";
        _oneLabel.textColor = UIColorFromRGB(0xe64e51);
        _oneLabel.font = [UIFont boldSystemFontOfSize:15];
    }
    return _oneLabel;
}

- (UILabel *)twoLabel{
    if (!_twoLabel) {
        _twoLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 235, 200, 50)];
        _twoLabel.text = @"注意事项";
        _twoLabel.textColor = UIColorFromRGB(0xe64e51);
        _twoLabel.font = [UIFont boldSystemFontOfSize:15];
    }
    return _twoLabel;
}

- (UILabel *)threeLabel{
    if (!_threeLabel) {
        _threeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 265, SCREEN_WIDTH - 40, 50)];
        _threeLabel.numberOfLines = 0;
        _threeLabel.text = @"服务中需要特别注意的事项请注明，这样可以防止不必要的纠纷哦！";
        _threeLabel.textColor = TEXT_COLOR;
        _threeLabel.font = [UIFont systemFontOfSize:12];
    }
    return _threeLabel;
}
-(PlaceTextView *)textView{
    
    if (!_textView) {
        _textView = [[PlaceTextView alloc]initWithFrame:CGRectMake(20, 45, SCREEN_WIDTH - 40, 180)];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.delegate = self;
        _textView.font = [UIFont systemFontOfSize:14.f];
        _textView.textColor = [UIColor blackColor];
        _textView.textAlignment = NSTextAlignmentLeft;
        _textView.editable = YES;
        _textView.layer.cornerRadius = 4.0f;
        _textView.layer.borderColor = kTextBorderColor.CGColor;
        _textView.layer.borderWidth = 0.5;
        _textView.placeholderColor = RGBCOLOR(0x89, 0x89, 0x89);
        _textView.placeholder = @"清晰准确的描述有助于用户了解你的服务，例如服务流程, 服务方式等为了更好的展示你的服务优点，请至少输入50字的描述，优质的图片可以提高服务的浏览率哦!";
    }
    
    return _textView;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([@"\n" isEqualToString:text] == YES)
    {
        [textView resignFirstResponder];
        
        
        return NO;
    }
    
    return YES;
}

- (void)sendFeedBack{
    
    NSLog(@"=======%@",self.textView.text);
    
}

@end
