#import "React/RCTViewManager.h"

@interface RCT_EXTERN_MODULE(CachedBobViewManager, RCTViewManager)

RCT_EXPORT_VIEW_PROPERTY(sources, NSArray)
RCT_EXPORT_VIEW_PROPERTY(priority, NSString)

@end
