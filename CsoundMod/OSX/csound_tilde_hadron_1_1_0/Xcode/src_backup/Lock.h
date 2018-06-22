/*
    csound~ : A MaxMSP external interface for the Csound API.
    
    Created by Davis Pyon on 2/4/06.
    Copyright 2006-2010 Davis Pyon. All rights reserved.
    
    LICENSE AGREEMENT
    
    This software is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
    version 2.1 of the License, or (at your option) any later version.
    
    This software is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Lesser General Public License for more details.
    
    You should have received a copy of the GNU Lesser General Public
    License along with this software; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/

#include "includes.h"
#include "definitions.h"
#include <pthread.h>
#include <Windows.h>

#ifndef _LOCK_H
#define _LOCK_H

namespace dvx {

class Lock
{
public:
	Lock(char *name = NULL, int type = MUTEX);
	virtual ~Lock();

	void setName(char *name);
	virtual bool lock(char *context = NULL);
	virtual bool trylock(char *context = NULL);
	virtual bool unlock(char *context = NULL);

	enum { MUTEX = 0, SYSTHREAD_MUTEX = 1, SPIN_LOCK = 2, WIN_CRITICAL_SECTION = 3, CUSTOM_SPIN_LOCK };
	enum { MAX_SPIN_COUNT = 4000 }; // Used for WIN_CRITICAL_SECTION.

protected:

	// Hide copy ctor, and assignment operator.
	Lock(const Lock & other) {}
	Lock & operator=(const Lock & other) { return *this; }

	enum { MAXI_STR_LEN = 128 };

	int m_type;
	char m_name[MAXI_STR_LEN];
	bool m_locked;
	char m_context[MAXI_STR_LEN];
	DWORD m_thread_id;
	pthread_mutex_t m_mutex;
	t_systhread_mutex m_smutex;
#ifdef _WINDOWS	
	pthread_spinlock_t m_spinlock;
	CRITICAL_SECTION m_critical_section;
#endif
};

class Lock_Custom_SpinLock : public Lock
{
};

class Lock_Pthread_Mutex : public Lock
{
};

class Lock_Pthread_Spinlock : public Lock
{
};

class Lock_Win_Critical_Section : public Lock
{
};



class ScopedLock
{
public:
	ScopedLock(Lock &lock, bool doIt = true) : m_lock(&lock), m_doIt(doIt)
	{ 
		if(m_doIt)
			m_lock->lock(NULL);
	}
	ScopedLock(Lock &lock, char *context, bool doIt = true) : m_lock(&lock), m_doIt(doIt)
	{ 
		if(m_doIt)
			m_lock->lock(context);
	}
	~ScopedLock()
	{
		if(m_doIt)
			m_lock->unlock();
	}

protected:
	Lock *m_lock;
	bool m_doIt;
};

} // namespace dvx

#endif