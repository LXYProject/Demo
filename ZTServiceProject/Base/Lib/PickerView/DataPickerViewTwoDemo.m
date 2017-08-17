//
//  DataPickerViewDemo.m
//  ChooseTimePickerView
//
//  Created by ZT on 2017/7/2.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "DataPickerViewTwoDemo.h"

static DataPickerViewTwoDemo *pikerView = nil;
@interface DataPickerViewTwoDemo ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic,strong)UIView *headerView;
@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UIPickerView *pickView;
@property (nonatomic,strong)NSMutableArray *dateDataSource;
@property (nonatomic,strong)NSMutableArray *timeDateSource;
@property (nonatomic,strong)NSArray *threeDateSource;

@property (nonatomic,strong)UIView *backView;
@end

@implementation DataPickerViewTwoDemo {
    NSInteger _currentSelectedRow;
    NSInteger _currentSelectComponent;
}

+(DataPickerViewTwoDemo* )sharedPikerView {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!pikerView) {
            pikerView = [[DataPickerViewTwoDemo alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        }
    });
    return pikerView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.backView];
        [self.backView addSubview:self.headerView];
        [self.backView addSubview:self.pickView];
        [self.backView addSubview:self.bottomView];
        
        self.dateDataSource = (NSMutableArray *)@[@"1室",@"2室", @"3室", @"4室", @"5室", @"6室",@"7室", @"8室", @"9室", @"10室", @"11室",@"12室",@"13室", @"14室", @"15室", @"16室", @"17室",@"18",@"19室", @"20室"];
        self.timeDateSource = (NSMutableArray *)@[@"1厅",@"2厅", @"3厅", @"4厅", @"5厅", @"6厅",@"7厅", @"8厅", @"9厅", @"10厅"];
        self.threeDateSource = @[@"1卫",@"2卫", @"3卫", @"4卫", @"5卫", @"6卫",@"7卫", @"8卫", @"9卫", @"10卫"];

    }
    return self;
}


- (void)show {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.backgroundColor = [UIColor clearColor];
    self.backView.transform = CGAffineTransformMakeScale(0.7, 0.7);
    [window addSubview:self];
    [UIView animateWithDuration:0.35 animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        self.backView.transform = CGAffineTransformMakeScale(1.1, 1.1);
    } completion:^(BOOL finished) {
        self.backView.transform = CGAffineTransformMakeScale(1, 1);
    }];
    
    
}
- (void)dismiss {
    [UIView animateWithDuration:0.35 animations:^{
        self.backgroundColor = [UIColor clearColor];
        self.backView.transform = CGAffineTransformMakeTranslation(0, [UIScreen mainScreen].bounds.size.height-150);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component ==0) {
        return self.dateDataSource.count;
    }else if (component==1){
        return self.timeDateSource.count;
    }else{
        return self.threeDateSource.count;
    }
}

// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    _currentSelectedRow = row;
    _currentSelectComponent = component;
    [self.pickView reloadComponent:_currentSelectComponent];   //一定要写这句
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    //设置分割线的颜色
//    for(UIView *singleLine in pickerView.subviews)
//    {
//        if (singleLine.frame.size.height < 1)
//        {
//            singleLine.backgroundColor = [UIColor clearColor];
//        }
//    }
    // 这里用label来展示要显示的文字, 然后可以用label的textAlignment来设置文字的对齐模式
    UILabel *myView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0.0, [UIScreen mainScreen].bounds.size.width-20, 35)];
    myView.font = [UIFont systemFontOfSize:16];
    myView.backgroundColor = [UIColor clearColor];
    myView.textAlignment = NSTextAlignmentCenter;
    if (_currentSelectedRow == row) {
        myView.textColor = [UIColor redColor];
    }
    else {
        myView.textColor = [UIColor darkGrayColor];
    }
    if (component==0){
        myView.text = self.dateDataSource[row];
    }else if (component==1) {
        myView.text = self.timeDateSource[row];
    }
    else {
        myView.text = self.threeDateSource[row];
    }
    return myView;
}


- (UIView *)headerView {

    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.backView.frame.size.width, 49)];
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _headerView.frame.size.width, 49)];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.font = [UIFont systemFontOfSize:14];
        lable.text = @"选择户型";
        lable.textColor = [UIColor darkGrayColor];
        [_headerView addSubview:lable];
        _headerView.backgroundColor = [UIColor whiteColor];
    }
    return _headerView;
}


- (UIPickerView *)pickView {
    if (!_pickView) {
        _pickView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 49.5, self.backView.frame.size.width, 100)];
        _pickView.delegate = self;
        _pickView.dataSource = self;
        _pickView.backgroundColor = [UIColor whiteColor];
    }
    return _pickView;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 150, self.backView.frame.size.width, 49)];
        _bottomView.backgroundColor = [UIColor whiteColor];
        //可以创建想要的Btn
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame = CGRectMake(0, 0, _bottomView.frame.size.width/2, 49);
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        cancelBtn.backgroundColor = [UIColor cyanColor];
        [cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:cancelBtn];
        UIButton *determineBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        determineBtn.frame = CGRectMake(_bottomView.frame.size.width/2, 0, _bottomView.frame.size.width/2, 49);
        [determineBtn setTitle:@"确定" forState:UIControlStateNormal];
        determineBtn.backgroundColor = [UIColor redColor];
        [determineBtn addTarget:self action:@selector(determineBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:determineBtn];
    }
    return _bottomView;
}
- (void)cancelBtnClick
{
    [self dismiss];
    NSLog(@"取消");
}
- (void)determineBtnClick
{
    [self dismiss];
    NSInteger oneComRow =[self.pickView selectedRowInComponent:0];
    NSInteger twoComRow =[self.pickView selectedRowInComponent:1];
    NSInteger threeComRow =[self.pickView selectedRowInComponent:2];

    
    if (self.pikerSelected) {
        self.pikerSelected(self.dateDataSource[oneComRow], self.timeDateSource[twoComRow], self.threeDateSource[threeComRow]);
    }
    
    
}
- (NSMutableArray *)dateDataSource {
    if (!_dateDataSource) {
        _dateDataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _dateDataSource;
}

- (NSMutableArray *)timeDateSource {
    if (!_timeDateSource) {
        _timeDateSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _timeDateSource;
}

- (UIView *)backView {
    if (!_backView) {
        _backView =[[UIView alloc]initWithFrame:CGRectMake(20, SCREEN_HEIGHT/2-197/2, self.frame.size.width-40, 197)];
        _backView.backgroundColor = [UIColor lightGrayColor];
        _backView.layer.masksToBounds= YES;
        _backView.layer.cornerRadius = 10;
    }
    return _backView;
}
@end
