//
//  LiveModel.h
//  DaBangVR
//
//  Created by mac on 2019/3/27.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LiveModel : NSObject
/** RTMP直播地址 */
@property (nonatomic, copy) NSString *rtmpPlayURL;
/** HLS直播地址 */
@property (nonatomic, copy) NSString *hlsPlayURL;
/** HDL直播地址 */
@property (nonatomic, copy) NSString *hdlPlayURL;
/** 直播封面 */
@property (nonatomic, copy) NSString *snapshotPlayURL;

@end

NS_ASSUME_NONNULL_END
