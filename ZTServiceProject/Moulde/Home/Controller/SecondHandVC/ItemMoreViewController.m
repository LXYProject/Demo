//
//  ItemMoreViewController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/27.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "ItemMoreViewController.h"

@interface ItemMoreViewController ()<UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (nonatomic, strong) UIPickerView  *pickerView;
@property(nonatomic,strong)NSArray *areaList;

@end

@implementation ItemMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self titleViewWithTitle:_itemTitle titleColor:[UIColor whiteColor]];
    //东城区、西城区、朝阳区、丰台区、石景山区、海淀区、顺义区、通州区、大兴区、房山区、门头沟区、昌平区、平谷区、密云区、怀柔区、延庆区
    self.areaList = [[NSArray alloc]initWithObjects:@"东城区",@"西城区",@"朝阳区",@"丰台区",@"石景山区",@"海淀区", @"顺义区", @"通州区", @"大兴区", @"房山区", @"门头沟区", @"昌平区", @"平谷区", @"密云区", @"怀柔区", @"延庆区", nil];
    

    
}
- (IBAction)btnClick:(UIButton *)sender {
    NSLog(@"%ld",sender.tag);
    sender.selected = !sender.selected;
    if (sender.selected) {
        //userInteractionEnabled
        [self createPicker];
        [sender setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    }
    else {
        [self.pickerView removeFromSuperview];
        [sender setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    }
}

- (void)createPicker{
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 220)];
    // 显示选中框
    self.pickerView.showsSelectionIndicator=YES;
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    [self.view addSubview:self.pickerView];
}

#pragma Mark -- UIPickerViewDataSource
// pickerView 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.areaList.count;
}

//UIPickerViewDelegate 相关代理方法
#pragma Mark -- UIPickerViewDelegate
// 每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {

    return 44;
}
// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{

    NSString  *proCityStr = [self.areaList objectAtIndex:row];
    NSLog(@"proCitySt@==%@", proCityStr);

}

//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{

    return [self.areaList objectAtIndex:row];

}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    //设置分割线的颜色
    for(UIView *singleLine in pickerView.subviews)
    {
        if (singleLine.frame.size.height < 1)
        {
            singleLine.backgroundColor = [UIColor lightGrayColor];
        }
    }
    
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        // Setup label properties - frame, font, colors etc
        //adjustsFontSizeToFitWidth property to YES
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont systemFontOfSize:14]];
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

@end
