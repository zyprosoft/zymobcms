//
//  BFDebugUitil.h
//  OPinion
//
//  Created by ZYVincent on 12-7-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#define BFMLog(s,...) NSLog(@"file:%s,%s,At line %d, =====> print Object is %@",__FILE__,__func__,__LINE__,s);

#define BFLogRect(r) NSLog(@"{{%f,%f},{%f,%f}}", r.origin.x, r.origin.y, r.size.width, r.size.height)

#define BFLogSize(s) NSLog(@"{%f,%f}", s.width, s.height)

#define BFLogPoint(p) NSLog(@"{%f,%f}", p.x, p.y)

#define BFLogInt(i) NSLog(@"%d", i)

#define BFLogFloat(f) NSLog(@"%f", f)

#define BFLogObject(o) NSLog(@"%@", o)
