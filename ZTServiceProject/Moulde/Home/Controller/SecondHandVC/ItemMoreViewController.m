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
@property (nonatomic,strong)NSArray *dataSource;
@property(nonatomic,strong)NSArray *areaList;
@property(nonatomic,strong)NSArray *typeList;
@property(nonatomic,strong)NSArray *sortingList;

@end

@implementation ItemMoreViewController
{
    UIButton *_button;
    BOOL _isShowing;
//    0、局左对齐 1、中间对其 2、右对齐
    NSInteger _textAliment;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self titleViewWithTitle:_itemTitle titleColor:[UIColor whiteColor]];
    
    //    self.pickView.transform =CGAffineTransformMakeTranslation(0, 200);
    [self.view addSubview:self.pickerView];
    self.pickerView.hidden = YES;
    self.pickerView.transform = CGAffineTransformMakeScale(0, 0);
    
    //东城区、西城区、朝阳区、丰台区、石景山区、海淀区、顺义区、通州区、大兴区、房山区、门头沟区、昌平区、平谷区、密云区、怀柔区、延庆区
    self.areaList = [[NSArray alloc]initWithObjects:@"东城区",@"西城区",@"朝阳区",@"丰台区",@"石景山区",@"海淀区", @"顺义区", @"通州区", @"大兴区", @"房山区", @"门头沟区", @"昌平区", @"平谷区", @"密云区", @"怀柔区", @"延庆区", nil];
    self.typeList = [[NSArray alloc]initWithObjects:@"a",@"b",@"c",@"d",@"e",@"f", @"g", @"h", nil];
    self.sortingList = [[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5", nil];
    

    
}
- (IBAction)btnClick:(UIButton *)sender {
    if (sender.selected) {
        sender.selected = NO;
        [self dismissPickView];
        return;
    }
    _button.selected = NO;
    sender.selected = YES;
    _button = sender;
    //根据点击不同的btn赋值不同的数据源
    if (sender == self.btn1) {
        self.dataSource = self.areaList;
        _textAliment = 0;
    }else if (sender==self.btn2){
        _textAliment = 1;
        self.dataSource = self.typeList;
    }else{
        _textAliment = 2;
        self.dataSource = self.sortingList;
    }
    [self.pickerView reloadAllComponents];
    //刷新
    [self showPickView];
}
- (void)showPickView {
    if (_isShowing) {
        return;
    }
    [UIView animateWithDuration:0.25 animations:^{
        self.pickerView.hidden = NO;
        self.pickerView.transform = CGAffineTransformIdentity;
    }];
    _isShowing = YES;
}
- (void)dismissPickView {
    if (!_isShowing) {
        return;
    }
    [UIView animateWithDuration:0.25 animations:^{
        self.pickerView.hidden = YES;
        self.pickerView.transform = CGAffineTransformMakeScale(0, 0);
    }];
    _isShowing = NO;
}

- (UIPickerView *)pickerView{
    
    if (!_pickerView){
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, 200)];
        // 显示选中框
        self.pickerView.showsSelectionIndicator=YES;
        self.pickerView.dataSource = self;
        self.pickerView.delegate = self;
    }
    return _pickerView;
}

//- (void)setDataSource:(NSArray *)dataSource{
//    _dataSource = dataSource;
//
//}

#pragma Mark -- UIPickerViewDataSource
// pickerView 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.dataSource.count;
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

    NSString  *proCityStr = [self.dataSource objectAtIndex:row];
    NSLog(@"proCitySt@==%@", proCityStr);

}

//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{

    return [self.dataSource objectAtIndex:row];

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
    
        
        // 这里用label来展示要显示的文字, 然后可以用label的textAlignment来设置文字的对齐模式
        UILabel *myView = [[UILabel alloc] initWithFrame:CGRectMake(50, 0.0, ScreenWidth-100, 35)];
        myView.font = [UIFont systemFontOfSize:16];
        myView.backgroundColor = [UIColor clearColor];
        myView.textAlignment = _textAliment==0?NSTextAlignmentLeft:(_textAliment == 1?NSTextAlignmentCenter:NSTextAlignmentRight);
    myView.text = self.dataSource[row];
    
    return myView;
}

@end
