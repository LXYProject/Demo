//
//  ServiceModel.h
//  ZTServiceProject
//
//  Created by ZT on 2017/6/14.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <Foundation/Foundation.h>

//address = "北京市";
//area = 110000;
//categoryDesc = "带路";
//categoryId = 12;
//cityId = 010;
//content = "蓝翔毕业，专修电器，请我吃饭";
//createDate = "2017-05-18 17:03:19";
//districtId = 110108;
//normalImageList =             (
//                               {
//                                   url = "http://192.168.1.96:8080/ZtscApp/file/service/1890918872220170322150921-0-20170518170319.JPEG";
//                               },
//                               {
//                                   url = "http://192.168.1.96:8080/ZtscApp/file/service/1890918872220170322150921-1-20170518170319.JPEG";
//                               },
//                               {
//                                   url = "http://192.168.1.96:8080/ZtscApp/file/service/1890918872220170322150921-2-20170518170319.JPEG";
//                               }
//                               );
//online = 0;
//price = "12300.00";
//resId = 1;
//resName = 1;
//serviceId = 20170518170319;
//smallImageList =             (
//                              {
//                                  url = "http://192.168.1.96:8080/ZtscApp/file/service/1890918872220170322150921-0-20170518170319_small.JPEG";
//                              },
//                              {
//                                  url = "http://192.168.1.96:8080/ZtscApp/file/service/1890918872220170322150921-1-20170518170319_small.JPEG";
//                              },
//                              {
//                                  url = "http://192.168.1.96:8080/ZtscApp/file/service/1890918872220170322150921-2-20170518170319_small.JPEG";
//                              }
//                              );
//statusDesc = "发布中";
//statusInt = 0;
//title = "高级技工";
//unit = "次";
//update = "";
//userHuanxinId = 201705231745429;
//userId = 1890918872220170322150921;
//userImgContent = "";
//userImgType = png;
//userImgUrl = "http://192.168.1.96:8080/ZtscApp/file/headImage/1890918872220170322150921-20170608125616.png";
//userName = "王磊";
//x = "116.33391583";
//y = "39.98825800";


//"userId": "1362111422120170322120834",
//"imageUrl": "http://192.168.1.96:8080/ZtscApp/file/jpg/20170908152415.jpg,",
//"updateDate": "2017-09-14 00:00:00",
//"serviceId": "20170908152652",
//"userHuanxinId": "201705231745424",
//"createDate": "2017-09-08 15:26:52",
//"unit": "副",
//"area": "652900",
//"online": 0,
//"title": "头额咳特灵",
//"price": 2000,
//"statusDesc": "",
//"villageName": "1",
//"villageId": "1",
//"serviceCategoryID": "3",
//"serviceCategoryName": "",
//"adcode": "110108",
//"userHeaderImageUrl": "http://192.168.1.96:8080/ZtscApp/file/headImage/http://192.168.1.96:8080/ZtscApp/file/png/201709141644521.png",
//"y": 39.98604401,
//"x": 116.33437112,
//"userName": "周本成2",
//"address": "北京市 北京市",
//"content": "童可口额咯LOL诺特特累阿Q仑头欧诺色特特",
//"status": 0
//}
//],
//"information": "查询成功！",
//"status": "0"
@interface ServiceModel : NSObject


//@property (nonatomic,copy)NSString *address;
//@property (nonatomic,copy)NSString *area;
//@property (nonatomic,copy)NSString *categoryDesc;
//@property (nonatomic,copy)NSString *categoryId;
////城市id
//@property (nonatomic,copy)NSString *cityId;
//@property (nonatomic,copy)NSString *content;
//@property (nonatomic,copy)NSString *createDate;
//@property (nonatomic,copy)NSString *districtId;
//@property (nonatomic,strong)NSArray *smallImageList;
//@property (nonatomic,strong)NSArray *normalImageList;
//@property (nonatomic,copy)NSString *online;
//@property (nonatomic,copy)NSString *price;
//@property (nonatomic,copy)NSString *resId;
//@property (nonatomic,copy)NSString *resName;
//@property (nonatomic,copy)NSString *serviceId;
//@property (nonatomic,copy)NSString *statusDesc;
////装太码
//@property (nonatomic,copy)NSString *statusInt;
//@property (nonatomic,copy)NSString *title;
//@property (nonatomic,copy)NSString *unit;
//@property (nonatomic,copy)NSString *update;
//@property (nonatomic,copy)NSString *userHuanxinId;
//@property (nonatomic,copy)NSString *userId;
//@property (nonatomic,copy)NSString *userImgContent;
//@property (nonatomic,copy)NSString *userImgType;
//@property (nonatomic,copy)NSString *userImgUrl;
//@property (nonatomic,copy)NSString *userName;
//
//
////@property (nonatomic,copy)NSString *validDate;
//@property (nonatomic,copy)NSString *y;
//@property (nonatomic,copy)NSString *x;



@property (nonatomic,copy)NSString *userId;
@property (nonatomic,copy)NSString *imageUrl;
@property (nonatomic,copy)NSString *updateDate;
@property (nonatomic,copy)NSString *serviceId;
@property (nonatomic,copy)NSString *userHuanxinId;
@property (nonatomic,copy)NSString *createDate;
@property (nonatomic,copy)NSString *unit;
@property (nonatomic,copy)NSString *area;
@property (nonatomic,copy)NSString *online;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *price;
@property (nonatomic,copy)NSString *statusDesc;
@property (nonatomic,copy)NSString *villageName;
@property (nonatomic,copy)NSString *villageId;
@property (nonatomic,copy)NSString *serviceCategoryID;
@property (nonatomic,copy)NSString *serviceCategoryName;
@property (nonatomic,copy)NSString *adcode;
@property (nonatomic,copy)NSString *userHeaderImageUrl;
@property (nonatomic,copy)NSString *y;
@property (nonatomic,copy)NSString *x;
@property (nonatomic,copy)NSString *userName;
@property (nonatomic,copy)NSString *address;
@property (nonatomic,copy)NSString *content;
@property (nonatomic,copy)NSString *status;

@end
