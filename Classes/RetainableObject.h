//
//  RetainableObject.h
//  BreakBlocks
//
//  Created by 藤澤　健治 on 2013/05/12.
//
//

#ifndef __BreakBlocks__RetainableObject__
#define __BreakBlocks__RetainableObject__

class RetainableObject
{
private:
    int referenceCount;
    
public:
    RetainableObject();
    virtual ~RetainableObject();
    
    void retain();
    void release();
    
    int getReferenceCount();
};

#endif /* defined(__BreakBlocks__RetainableObject__) */
