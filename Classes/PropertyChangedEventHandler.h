//
//  PropertyChangedEventHandler.h
//  BreakBlocks
//
//  Created by 藤澤　健治 on 2013/05/19.
//
//

#ifndef __BreakBlocks__PropertyChangedEventHandler__
#define __BreakBlocks__PropertyChangedEventHandler__

#include "IPropertyChangedListener.h"

template <class T>
class PropertyChangedEventHandler : public IPropertyChangedListener
{
private:
    typedef void (T::*PropertyChangedEventDelegate)(void*, PropertyChangedEventArgsBase*);
    
    T* handler;
    PropertyChangedEventDelegate delegate;
    
public:
    virtual void propertyChanged(void* sender, PropertyChangedEventArgsBase* e);
    
    void setDelegate(T* handler, PropertyChangedEventDelegate delegate);
};

template <class T>
void PropertyChangedEventHandler<T>::propertyChanged(void *sender, PropertyChangedEventArgsBase *e)
{
    if (this->handler != NULL && this->delegate != NULL)
        (this->handler->*(this->delegate))(sender, e);
}

template <class T>
void PropertyChangedEventHandler<T>::setDelegate(T* handler, PropertyChangedEventDelegate delegate)
{
    this->delegate = delegate;
    this->handler = handler;
}

#endif /* defined(__BreakBlocks__PropertyChangedEventHandler__) */
