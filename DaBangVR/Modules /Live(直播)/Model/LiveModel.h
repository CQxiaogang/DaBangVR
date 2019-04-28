//
//  LiveModel.h
//  DaBangVR
//
//  Created by mac on 2019/3/27.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoodsDetailsModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface LiveModel : NSObject
@property (nonatomic, copy) NSString *headUrl;
@property (nonatomic, copy) NSString *liveTitle;
@property (nonatomic, copy) NSArray <GoodsDetailsModel *> *liveGoodsList;
/** HLS直播地址 */
@property (nonatomic, copy) NSString *hlsPlayURL;
/** RTMP直播地址 */
@property (nonatomic, copy) NSString *rtmpPlayURL;
/** HDL直播地址 */
@property (nonatomic, copy) NSString *hdlPlayURL;
/** 直播封面 */
@property (nonatomic, copy) NSString *snapshotPlayURL;
/** 封面 */
@property (nonatomic, copy) NSString *coverUrl;
/** 直播ID */
@property (nonatomic, copy) NSString *anchorId;
/** 直播名字 */
@property (nonatomic, copy) NSString *anchorName;
/** 粉丝数量 */
@property (nonatomic, copy) NSString *fans;
@end

NS_ASSUME_NONNULL_END
