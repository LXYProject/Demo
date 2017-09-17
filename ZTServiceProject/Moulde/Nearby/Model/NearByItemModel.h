//
//  NearByItemModel.h
//  ZTServiceProject
//
//  Created by ZT on 2017/6/7.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <Foundation/Foundation.h>
//"statusInt": "0",
//"cityId": "110106",
//"districtId": "110100",
//"appealId": "20170523140604",
//"validDate": "2018-02-02",
//"userImgType": "png",
//"userImgContent": "ituNzubm5uBLZKvkjkQxOpFFUEdNe+3mAAAAAElFTkSuQmCC",
//"userHuanxinId": "201705231745426",
//"userImgUrl": "http://192.168.1.96:8080/ZtscApp/file/headImage/1521018772020170322180211-20170601170251.png",
//"createDate": "1970-01-01 14:06:04",
//"title": "测试求助数量",
//"price": "50.00",
//"categoryId": "11",
//"categoryDesc": "跑腿",
//"statusDesc": "发布中",
//"resId": "1",
//"resName": "1",
//"smallImageList": [
//
//],
//"normalImageList": [
//
//],
//"update": "",
//"userId": "1521018772020170322180211",
//"userName": "朱元璋",
//"y": "39.86033700",
//"x": "116.31276500",
//"address": "测试求助数量",
//"content": "测试求助数量"


//"userId": "1362111422120170322120834",
//"imageUrl": "http://192.168.1.96:8080/ZtscApp/file/jpg/20170914171618.jpg,http://192.168.1.96:8080/ZtscApp/file/jpg/201709141716181.jpg,http://192.168.1.96:8080/ZtscApp/file/jpg/201709141716182.jpg,http://192.168.1.96:8080/ZtscApp/file/jpg/201709141716183.jpg,",
//"updateDate": "",
//"appealId": "201709141716184",
//"validDate": "2017-09-15 00:00:00",
//"userHuanxinId": "201705231745424",
//"createDate": "2017-09-14 17:16:18",
//"title": "我都不知道",
//"price": 9860,
//"statusDesc": "",
//"villageName": "1",
//"villageId": "1",
//"adcode": "110108",
//"userHeaderImageUrl": "http://192.168.1.96:8080/ZtscApp/file/headImage/http://192.168.1.96:8080/ZtscApp/file/png/201709141644521.png",
//"appealCategoryID": "1",
//"appealCategoryName": "求聊天啊",
//"y": 39.98807167,
//"x": 116.3334406,
//"userName": "周本成2",
//"address": "北京市 财智国际大厦(西门)",
//"content": "我就是测试一下服务可以用了吧。",
//"status": 0
@interface NearByItemModel : NSObject
////装太码
//@property (nonatomic,copy)NSString *statusInt;
////城市id
//@property (nonatomic,copy)NSString *cityId;
//
//@property (nonatomic,copy)NSString *districtId;
//@property (nonatomic,copy)NSString *validDate;
//@property (nonatomic,copy)NSString *userImgType;
//@property (nonatomic,copy)NSString *userImgContent;
//@property (nonatomic,copy)NSString *userHuanxinId;
//@property (nonatomic,copy)NSString *userImgUrl;
//@property (nonatomic,copy)NSString *createDate;
//@property (nonatomic,copy)NSString *title;
//@property (nonatomic,copy)NSString *price;
//@property (nonatomic,copy)NSString *categoryId;
//@property (nonatomic,copy)NSString *categoryDesc;
//@property (nonatomic,copy)NSString *statusDesc;
//@property (nonatomic,copy)NSString *resId;
//@property (nonatomic,copy)NSString *resName;
//@property (nonatomic,strong)NSArray *smallImageList;
//@property (nonatomic,strong)NSArray *normalImageList;
//@property (nonatomic,copy)NSString *update;
//@property (nonatomic,copy)NSString *userId;
//@property (nonatomic,copy)NSString *userName;
//@property (nonatomic,copy)NSString *y;
//@property (nonatomic,copy)NSString *x;
//@property (nonatomic,copy)NSString *address;
//@property (nonatomic,copy)NSString *content;


@property (nonatomic,copy)NSString *userId;
@property (nonatomic,copy)NSString *imageUrl;
@property (nonatomic,copy)NSString *updateDate;
@property (nonatomic,copy)NSString *appealId;
@property (nonatomic,copy)NSString *validDate;
@property (nonatomic,copy)NSString *userHuanxinId;
@property (nonatomic,copy)NSString *createDate;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *price;
@property (nonatomic,copy)NSString *statusDesc;
@property (nonatomic,copy)NSString *villageName;
@property (nonatomic,copy)NSString *villageId;
@property (nonatomic,copy)NSString *adcode;
@property (nonatomic,copy)NSString *userHeaderImageUrl;
@property (nonatomic,copy)NSString *appealCategoryID;
@property (nonatomic,copy)NSString *appealCategoryName;
@property (nonatomic,copy)NSString *y;
@property (nonatomic,copy)NSString *x;
@property (nonatomic,copy)NSString *userName;
@property (nonatomic,copy)NSString *address;
@property (nonatomic,copy)NSString *content;
@property (nonatomic,copy)NSString *status;

@property (nonatomic,copy)NSString *unit;

@end
