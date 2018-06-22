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

#include "Lock.h"

using namespace dvx;

Lock::Lock(char *name, int type)
{ 
	if(name != NULL)
		#ifdef _WINDOWS
			strncpy_s(m_name, name, MAXI_STR_LEN-1);
		#else
			strncpy(m_name, name, MAXI_STR_LEN-1);
		#endif
	else
		m_name[0] = '\0';

	m_locked = false; 
	m_context[0] = '\0';
	m_type = type;

#ifndef _WINDOWS
	m_type = MUTEX; // Force use of pthread mutex on Mac.
#endif

	if(m_type < 0 || m_type > 2) m_type = 0;

	switch(m_type)
	{
	case MUTEX:
		pthread_mutex_init(&m_mutex, NULL); 
		break;
	case SYSTHREAD_MUTEX:
		systhread_mutex_new(&m_smutex, 0);
		break;
#ifdef _WINDOWS
	case SPIN_LOCK:
		pthread_spin_init(&m_spinlock, PTHREAD_PROCESS_PRIVATE);
		break;
	case WIN_CRITICAL_SECTION:
		InitializeCriticalSectionAndSpinCount(&m_critical_section, 4000);
		break;
#endif
	default: assert(false);	break;
	}
}

Lock::~Lock()
{
	switch(m_type)
	{
	case MUTEX:
		pthread_mutex_destroy(&m_mutex); break;
	case SYSTHREAD_MUTEX:
		systhread_mutex_free(m_smutex); break; 
		break;
#ifdef _WINDOWS
	case SPIN_LOCK:
		pthread_spin_destroy(&m_spinlock);
		break;
	case WIN_CRITICAL_SECTION:
		DeleteCriticalSection(&m_critical_section);
		break;
#endif
	default: assert(false); break;
	}
}

void Lock::setName(char *name)
{
	strncpy(m_name, name, MAXI_STR_LEN-1);
}

bool Lock::lock(char *context)
{
	bool result = false;
	t_max_err max_result;
	
	switch(m_type)
	{
	case MUTEX:
		result = pthread_mutex_lock(&m_mutex) == 0;
		break;
	case SYSTHREAD_MUTEX:
		max_result = systhread_mutex_lock(m_smutex);
		result = (MAX_ERR_NONE == max_result);
		break;
#ifdef _WINDOWS
	case SPIN_LOCK:
		result = pthread_spin_lock(&m_spinlock) == 0;
		break;
	case WIN_CRITICAL_SECTION:
		EnterCriticalSection(&m_critical_section);
		result = true;
		break;
#endif	
	default: assert(false); break;
	}

#ifdef _DEBUG
#ifdef _WINDOWS	
	m_locked = true;
	m_thread_id = GetCurrentThreadId();
	if(context != NULL) 
		strncpy(m_context, context, MAXI_STR_LEN-1);
	else
		sprintf(m_context, "no context");
#else
	m_locked = true;
	if(context != NULL) 
		strncpy(m_context, context, MAXI_STR_LEN-1);
	else
		sprintf(m_context, "no context");
#endif
#endif
	return result;
}


bool Lock::trylock(char *context)
{
	bool result = false;
	t_max_err max_result;

	switch(m_type)
	{
	case MUTEX:
		result = pthread_mutex_trylock(&m_mutex) == 0;
		break;
	case SYSTHREAD_MUTEX:
		max_result = systhread_mutex_trylock(m_smutex);
		result = (MAX_ERR_NONE == max_result);
		break;
#ifdef _WINDOWS
	case SPIN_LOCK:
		result = pthread_spin_trylock(&m_spinlock) == 0;
		break;
	case WIN_CRITICAL_SECTION:
		result = TryEnterCriticalSection(&m_critical_section);
		break;
#endif
	default: assert(false); break;
	}

#ifdef _DEBUG
#ifdef _WINDOWS
	if(result)
	{
		m_locked = true;
		m_thread_id = GetCurrentThreadId();
		if(context != NULL) 
			strncpy(m_context, context, MAXI_STR_LEN-1);
		else
			sprintf(m_context, "no context");
	}
#else
	if(result)
	{
		m_locked = true;
		if(context != NULL) 
			strncpy(m_context, context, MAXI_STR_LEN-1);
		else
			sprintf(m_context, "no context");
	}
#endif
#endif
	return result;
}


bool Lock::unlock(char *context)
{
	bool result = false;
	t_max_err max_result;

#ifdef _DEBUG	
	// IMPORTANT: Set state variables before unlocking.
	if(m_locked == false)
	{
		if(context != NULL)
			error("Attempt to unlock an unlocked lock. Context = %s", context);
		else
			error("Attempt to unlock an unlocked lock. Context = none");
	}
	else
	{
		m_locked = false;
		m_thread_id = 0;
		m_context[0] = '\0';
	}
#endif

	switch(m_type)
	{
	case MUTEX:
		result = pthread_mutex_unlock(&m_mutex) == 0;
		break;
	case SYSTHREAD_MUTEX:
		max_result = systhread_mutex_unlock(m_smutex);
		result = (MAX_ERR_NONE == max_result);
		break;
#ifdef _WINDOWS
	case SPIN_LOCK:
		result = pthread_spin_unlock(&m_spinlock) == 0;
		break;
	case WIN_CRITICAL_SECTION:
		LeaveCriticalSection(&m_critical_section);
		result = true;
		break;
#endif
	default: assert(false); break;
	}

	return result;
}