//
//  AllCommentModel.h
//  DaBangVR
//
//  Created by mac on 2019/1/18.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommentsListModel : NSObject
// ID
@property (nonatomic, copy) NSString *id;
// 用户 ID
@property (nonatomic, copy) NSString *userId;
// 商品 ID
@property (nonatomic, copy) NSString *goodsId;
// 产品 ID
@property (nonatomic, copy) NSString *productId;
// 评论内容
@property (nonatomic, copy) NSString *commentContent;
// 状态
@property (nonatomic, copy) NSString *state;
// 评论数据
@property (nonatomic, copy) NSString *commentData;
// user 名字
@property (nonatomic, copy) NSString *nickName;
// user 头像
@property (nonatomic, copy) NSString *headUrl;

@end

NS_ASSUME_NONNULL_END
