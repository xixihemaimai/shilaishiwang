#define SingerH(name) + (instancetype)share##name;

#if __has_feature(objc_arc)
#define SingerM(name) + (instancetype)share##name{\
\
      return [[self alloc]init];\
  }\
static id _##name;\
\
+ (instancetype)allocWithZone:(struct _NSZone *)zone{\
    \
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
        _##name = [super allocWithZone:zone];\
    });\
    return _##name;\
}\
\
- (id)copyWithZone:(NSZone *)zone{\
    return _##name;\
}\
\
- (id)mutableCopyWithZone:(NSZone *)zone{\
    return _##name;\
}
#else
#define SingerM(name) + (instancetype)share##name{\
\
return [[self alloc]init];\
}\
static id _##name;\
+ (instancetype)allocWithZone:(struct _NSZone *)zone{\
    \
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
        _##name = [super allocWithZone:zone];\
    });\
    return _##name;\
}\
\
- (id)copyWithZone:(NSZone *)zone{\
    return _##name;\
}\
\
- (id)mutableCopyWithZone:(NSZone *)zone{\
    return _##name;\
}\
- (instancetype)retain{\
    return _##name;\
}\
- (oneway void)release{\
    \
}\
- (NSUInteger)retainCount{\
    return MAXFLOAT;\
}

#endif
