//
//  ItemsModel.h
//  ZTServiceProject
//
//  Created by ZT on 2017/7/28.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <Foundation/Foundation.h>

//"code": 200,
//"message": "",
//"result": [
//           {
//               "parentId": "",
//               "childList": [
//                             {
//                                 "parentId": "SCB001",
//                                 "childList": [
//                                               {
//                                                   "parentId": "SCB001032",
//                                                   "childList": [],
//                                                   "name": "Smartisan M1L",
//                                                   "id": "SCB001032002",
//                                                   "level": 3
//                                               },
//                                               {
//                                                   "parentId": "SCB001032",
//                                                   "childList": [],
//                                                   "name": "Smartisan M1",
//                                                   "id": "SCB001032001",
//                                                   "level": 3
//                                               }
//                                               ],
//                                 "name": "锤子",
//                                 "id": "SCB001032",
//                                 "level": 2
//                             },


@interface ItemsModel : NSObject

@property (nonatomic,copy)NSString *parentId;
@property (nonatomic,strong)NSArray *childList;

@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *ID;
@property (nonatomic,copy)NSString *level;


@end
