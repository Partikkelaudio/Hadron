/*
 *  csound~ : A MaxMSP external interface for the Csound API.
 *
 *  Created by Davis Pyon on 2/4/06.
 *  Copyright 2006 Davis Pyon. All rights reserved.
 *
 * L I C E N S E
 *
 * This software is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This software is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this software; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */
#include "csound~.h"

void *csound_class;

int maxChannelStringLength;

int main(void)
{
	setup((t_messlist **)&csound_class,(method)csound_new, (method)csound_free, (short)sizeof(t_csound), 
	      0L, A_GIMME, 0);
	addmess((method)csound_dsp, "dsp", A_CANT, 0);
	addmess((method)csound_assist, "assist", A_CANT, 0);
	addmess((method)csound_dblclick, "dblclick", A_CANT, 0);
	addmess((method)csound_setValueInputEnabled, "input", A_LONG, 0);
	addmess((method)csound_setValueOutputEnabled, "output", A_LONG, 0);
	addmess((method)csound_setMessageOutputEnabled, "message", A_LONG, 0);
	addmess((method)csound_setMessageOutputEnabled, "printout", A_LONG, 0);
	addmess((method)csound_csound, "csound", A_GIMME, 0);
	addmess((method)csound_control, "control", A_GIMME, 0);
	addmess((method)csound_control, "c", A_GIMME, 0);
	addmess((method)csound_midi, "midi", A_GIMME, 0);
	addmess((method)csound_midi, "m", A_GIMME, 0);
	addmess((method)csound_path, "path", A_SYM, 0);
	addmess((method)csound_event, "event", A_GIMME, 0);
	addmess((method)csound_event, "e", A_GIMME, 0);
	addmess((method)csound_start, "start", 0);
	addmess((method)csound_start, "bang", 0);
	addmess((method)csound_stop, "stop", 0);
	addmess((method)csound_reset, "reset", 0);
	addmess((method)csound_rewind, "rewind", 0);
	addmess((method)csound_sfdir, "sfdir", A_SYM, 0);
	addmess((method)csound_recordStart, "recordstart", 0);
	addmess((method)csound_recordStop, "recordstop", 0);
	addmess((method)csound_playStart, "playstart", 0);
	addmess((method)csound_playStop, "playstop", 0);
	addmess((method)csound_valueOutputOverdrive, "overdrive", A_LONG, 0);
	addmess((method)csound_write, "write", A_GIMME, 0);
	addmess((method)csound_read, "read", A_GIMME, 0);
	addmess((method)csound_tempo, "tempo", A_FLOAT, 0);
	addmess((method)csound_bypass, "bypass", A_LONG, 0);
	addmess((method)csound_loadSample, "loadsamp", A_GIMME, 0);
	addmess((method)csound_readBuf, "readbuf", A_GIMME, 0);
	addmess((method)csound_writeBuf, "writebuf", A_GIMME, 0);
	addmess((method)csound_readSampleIndex, "rsidx", A_GIMME, 0);
	addmess((method)csound_writeSampleIndex, "wsidx", A_GIMME, 0);
	addmess((method)csound_open, "open", 0);
	addmess((method)csound_run, "run", A_GIMME, 0);
	addmess((method)csound_setClockInterval, "interval", A_LONG, 0);
	addint((method)csound_int);
	addfloat((method)csound_float);
	dsp_initclass();
	return 0;
}

void csound_assist(t_csound *x, void *b, long msg, long arg, char *s)
{
	int i;
	
	if(msg == ASSIST_INLET) 
	{
		switch(arg)
		{
		case 0:  sprintf(s, "(signal) Audio In 0 / (int) MIDI Input"); break;
		default: sprintf(s, "(signal) Audio In %d", arg); break;
		}
	}
	else if(msg == ASSIST_OUTLET)
	{
		if(arg < x->numOutSignals) sprintf(s, "(signal) Audio Out %d", arg);
		else
		{
			i = arg - x->numOutSignals;
			switch(i)
			{
			case 0: sprintf(s,"(list) Messages"); break;
			case 1: sprintf(s,"(int) Csound MIDI"); break;
			case 2: sprintf(s,"(bang) Orchestra Successfuly Compiled"); break;
			case 3: sprintf(s,"(bang) Csound Peformance Done"); break;
			}
		}
	}
}

void csound_dblclick(t_csound *x)
{
	csound_open(x);
}

void csound_open(t_csound *x)
{
	if(!x->argListValid) return;
	if(x->csdInPath)
		openFile(x->csdPath);
	else
	{
		openFile(x->orcPath);
		openFile(x->scoPath);
	}	
}

void csound_setValueInputEnabled(t_csound *x, long n)
{
	if(pthread_mutex_lock(&x->performMutex) == 0)
	{
		if(n == 0)
		{
			x->valueInputEnabled = false;
			csoundSetInputValueCallback(x->csound, NULL);
		}
		else
		{
			x->valueInputEnabled = true;
			csoundSetInputValueCallback(x->csound, inputValueCallback);
		}
		pthread_mutex_unlock(&x->performMutex);
	}
}

void csound_setValueOutputEnabled(t_csound *x, long n)
{
	if(pthread_mutex_lock(&x->performMutex) == 0)
	{
		if(n == 0)
		{
			x->valueOutputEnabled = false;
			clock_unset(x->maxClock);
			csoundSetOutputValueCallback(x->csound, NULL);
		}
		else
		{
			x->valueOutputEnabled = true;
			clock_fdelay(x->maxClock, x->maxClockInterval);
			csoundSetOutputValueCallback(x->csound, outputValueCallback);
		}
		pthread_mutex_unlock(&x->performMutex);
	}
}

void csound_setMessageOutputEnabled(t_csound *x, long n)
{
	x->messageOutputEnabled = (bool) n;
}

void csound_valueOutputOverdrive(t_csound *x, long n)
{
	if(n == 0)
	{
		x->valueOutputOverdrive = false; 
		clock_fdelay(x->maxClock, x->maxClockInterval); // Restart the clock.
	}
	else x->valueOutputOverdrive = true; // Clock will be stopped insided csound_maxClockCallback().
}

void csound_OutputCompiledBang(t_csound *x)
{
	outlet_bang(x->compiled_bang_outlet);
}

t_int *csound_perform(t_int *w)
{
	t_csound *x = (t_csound *)(w[1]);
	int i, j, chan, index, indexMultChans, vectorSize = x->vectorSize;
	int inChans = x->inChans, outChans = x->outChans;
	MYFLT *csIn, *csOut;
	
	for(i=0; i<x->numInSignals; i++) x->in[i] = (float *)(w[i+2]);
	for(i=0; i<x->numOutSignals; i++) 
	{
		x->out[i] = (float *)(w[i+2+x->numInSignals]);
		memset(x->out[i], 0, sizeof(t_float) * x->vectorSize);
	}
	
	if(x->bypass)
	{
		// Copy audio input to output.
		chan = (x->numInSignals < x->numOutSignals ? x->numInSignals : x->numOutSignals);
		for(i=0; i<chan; i++) memcpy(x->out[i], x->in[i], sizeof(float) * vectorSize);
		
		// Since we're bypassing the Csound performance, return early.
		// Must return w + 1 + the # of args to perform method (see csound_dsp()).
		return (w+1+x->numPerformArgs);  
	}
	
	pthread_mutex_lock(&x->performMutex);
	
	if(x->compiled && !x->renderingToFile && !x->performanceFinished)
	{
		csOut = csoundGetSpout(x->csound);
		csIn = csoundGetSpin(x->csound);

		if(x->evenlyDivisible)
		{
			/*
			 * ksmps evenly divides the current Max vector size. Keep filling csIn[].
			 * When csIn[] is full, process Csound.  Processing Csound will give us
			 * ksmps output frames stored in csOut[].  At the end of the for loop, if
			 * there are any frames in csOut[], copy them to the output buffer provided
			 * by Max.  Since vector_size % ksmps == 0, this results in latency = 0 samples.
			 */
			j = 0;
			for(i=0; i<vectorSize; i++)
			{
				if(!x->performanceFinished)
				{
					indexMultChans = x->in_index * x->chans;
					for(chan=0; chan<inChans; chan++)
					{
						csIn[indexMultChans + chan] = (MYFLT)x->in[chan][i] * x->scale; // Multiply by csound's 0 dB lvl.
					}
					
					++x->in_index;

					if(x->in_index == x->ksmps) 
					{	
						x->performanceFinished = csoundPerformKsmps(x->csound);
						x->in_index = 0;
						x->out_index = 0;
					}

					while(x->out_index < x->ksmps && j < vectorSize)
					{
						indexMultChans = x->out_index * x->chans;
						for(chan=0; chan<outChans; chan++)
						{
							x->out[chan][j] = (t_float)(csOut[indexMultChans + chan] * x->oneDivScale); // Div by csound's 0 dB lvl.
						}	
						++j;
						++x->out_index;
					}
				}
			}
		}
		else // x->evenlyDivisible == false
		{
			/* ksmps does not evenly divide the current Max vector size.
			 * Here's a description of the loop: 
			 * We add a frame from the Max input vectors to csIn[], check to see
			 * if we have enough (ksmps) frames to process Csound, process Csound
			 * (if enough frames), then copy a frame from csOut[] to the Max output
			 * buffer regardless of whether or not we have processed Csound yet.
			 * If Csound has not been processed yet, csOut[] will be filled with zeros.
			 * This results in latency = ksmps.
			 */
			for(i=0; i<vectorSize; i++)
			{
				if(!x->performanceFinished)
				{
					if(x->in_index == x->ksmps) 
					{	
						x->performanceFinished = csoundPerformKsmps(x->csound);
						x->in_index = 0;
					}
					indexMultChans = x->in_index * x->chans;
					for(chan=0; chan<inChans; chan++)
					{
						index = indexMultChans + chan;
						csIn[index] = (MYFLT)x->in[chan][i] * x->scale;  // Multiply by csound's 0 dB lvl.
					}
					for(chan=0; chan<outChans; chan++)
					{
						index = indexMultChans + chan;
						x->out[chan][i] = (t_float)(csOut[index] * x->oneDivScale);  // Div by csound's 0 dB lvl.
					}
					x->in_index++;
				}
			}
		}
		if(x->performanceFinished) qelem_set(x->qelemPerformanceFinished);
	}
	
	pthread_mutex_unlock(&x->performMutex);
	
	if(x->valueOutputEnabled && x->valueOutputOverdrive)
		OutputDirtyChannels(&x->outChannelGroup, x->message_outlet);
	
	// Must return w + 1 + the # of args to perform method (see csound_dsp()).
	return (w+1+x->numPerformArgs);  
}

void csound_dsp(t_csound *x, t_signal **sp, short *count)
{
	int i=0, totalVectors=0;
	void **perform_args;
	
	totalVectors = x->numInSignals + x->numOutSignals;
	x->numPerformArgs = totalVectors + 1;

	perform_args = (void **) MemoryNew(sizeof(void*) * (totalVectors + 1));
	perform_args[0] = (void *) x;  // first argument is a pointer to the t_csound struct
	for(i=1; i<=totalVectors; i++) perform_args[i] = (void*) sp[i-1]->s_vec;
	
	x->sr = sp[0]->s_sr;  // store current sampling rate
	x->vectorSize = sp[0]->s_n; // store vector size
	x->one_div_sr = 1.0f / (float)x->sr; // store 1 / sr

	dsp_addv(csound_perform, x->numPerformArgs, perform_args);
	MemoryFree(perform_args);
	
	if(x->compiled && x->sr != x->csound_sr && x->messageOutputEnabled)
		error("csound~: MaxMSP sr %d != Csound sr %d", x->sr, x->csound_sr);

	x->evenlyDivisible = (x->vectorSize % x->ksmps == 0);
}
 
void csound_int(t_csound *x, long n)
{
	long in = proxy_getinlet((t_object *)x);
	
	switch(in)
	{
	case 0: // Midi data input. 
		MidiBuffer_Enqueue(x->midiInputBuffer, (byte) n); 
		break; 
	default: 
		break;
	}
}

void csound_float(t_csound *x, double f){}

void csound_control(t_csound *x, t_symbol *s, short argc, t_atom *argv)
{
	Sequencer *seq = x->sequencer;
	ChannelObject *co = NULL;
	int result, type;

	if(argc != 2 || argv[0].a_type != A_SYM) 
	{
		error("csound~: Incorrect control message format.  Example: c gain 0.56");
		return;	
	}

	if(argv[1].a_type == A_FLOAT || argv[1].a_type == A_LONG) 
		type = CSOUND_INPUT_CHANNEL | CSOUND_CONTROL_CHANNEL;
	else if(argv[1].a_type == A_SYM) 
		type = CSOUND_INPUT_CHANNEL | CSOUND_STRING_CHANNEL;
	
	// Need to lock the performMutex because we may need to run csoundGetChannelPtr() below.
	// Also, we have to lock performMutex before inChannelGroup.mutex in order to prevent
	// deadlock with csound_startDeferred().
	pthread_mutex_lock(&x->performMutex); 
	pthread_mutex_lock(&x->inChannelGroup.mutex);

		co = FindCreateChannel(&x->inChannelGroup, argv[0].a_w.w_sym->s_name, type, false);
		
		if(co->csoundChanPtr == NULL && x->compiled && !x->performanceFinished)
		{
			result = csoundGetChannelPtr(x->csound, &co->csoundChanPtr, co->name, type);
			if(result != 0) 
				error("csound~: Unable to get/create a Csound input control channel for \"%s\"", co->name);
		}

	pthread_mutex_unlock(&x->performMutex);

		if(argv[1].a_type == A_FLOAT)     SetChannelVal(co, argv[1].a_w.w_float);
		else if(argv[1].a_type == A_LONG) SetChannelVal(co, (float) argv[1].a_w.w_long);
		else if(argv[1].a_type == A_SYM)  SetChannelString(co, argv[1].a_w.w_sym->s_name); 

	pthread_mutex_unlock(&x->inChannelGroup.mutex);
	
	if(seq->recordControl.recording) 
	{
		if(IsControlChannel(co))
			Sequencer_AddControlEvent(seq, co->name, co->value, true);
		else if(IsStringChannel(co))
			Sequencer_AddStringEvent(seq, co->name, co->str, true);
	}
}

void csound_midi(t_csound *x, t_symbol *s, short argc, t_atom *argv)
{
	int i;
	byte buffer[MAX_MIDI_MESSAGE_SIZE];
	
	if(argc == 0 || argc > MAX_MIDI_MESSAGE_SIZE) return;

	for(i=0; i<argc; i++)
	{
		switch(argv[i].a_type)
		{
		case A_LONG:
			buffer[i] = (byte) argv[i].a_w.w_long;
			break;
		default: 
			error("csound~: Only integers are allowed in midi messages.");
			return;
		}
	}
	
	MidiBuffer_EnqueueBuffer(x->midiInputBuffer, buffer, i);
}

void csound_path(t_csound *x, t_symbol *s)
{
	char path[MAX_STRING_LENGTH];
	
	if(strlen(s->s_name) >= MAX_STRING_LENGTH)
	{
		error("csound~: Pathname is too long; maximum string length is %d.", MAX_STRING_LENGTH);
		return;
	}
	
	strncpy(path, s->s_name, MAX_STRING_LENGTH-1);
	if(isQuoted(path)) removeQuotes(path);
	convertMaxPathToPosixPath(path, path, MAX_STRING_LENGTH);

#ifdef WINXP
	if(-1 != _chdir(path))
#elif MACOSX
	if(-1 != chdir(path))
#endif
	{
		post("csound~: Current Directory set to: %s", path);
		strcpy(x->path, path);
	}
	else
		error("csound~: %s is not a valid dir, or you don't have exec permission on this or an ancestor dir.", 
			 path);
}

void csound_event(t_csound *x, t_symbol *s, short argc, t_atom *argv)
{
	Sequencer *seq = x->sequencer;
	int i, totalSize = 0;
	char buffer[MAX_EVENT_MESSAGE_SIZE], tmp[MAX_STRING_LENGTH];
	
	if(argc == 0) return;
	if(argv[0].a_type != A_SYM) return;
	
	sprintf(buffer, "%s", argv[0].a_w.w_sym->s_name);
	totalSize += strlen(buffer);

	for(i=1; i<argc; i++)
	{
		switch(argv[i].a_type)
		{
		case A_LONG:
			sprintf(tmp, " %d", argv[i].a_w.w_long);
			totalSize += strlen(tmp);
			strncat(buffer, tmp, MAX_EVENT_MESSAGE_SIZE - strlen(buffer) - 1);
			break;
		case A_FLOAT:
			sprintf(tmp, " %f", argv[i].a_w.w_float);
			totalSize += strlen(tmp);
			strncat(buffer, tmp, MAX_EVENT_MESSAGE_SIZE - strlen(buffer) - 1);
			break;
		case A_SYM:
			// Add double quotes if a space or slash is present and it's not quoted.
			if(!isQuoted(argv[i].a_w.w_sym->s_name) && 
				(strchr(argv[i].a_w.w_sym->s_name, '/') ||
				 strchr(argv[i].a_w.w_sym->s_name, '\\') ||
				 strchr(argv[i].a_w.w_sym->s_name, ' ')))
			{
				char tmp2[MAX_STRING_LENGTH];
				
				if(isAbsoluteMaxPath(argv[i].a_w.w_sym->s_name))
				{
					convertMaxPathToPosixPath(argv[i].a_w.w_sym->s_name, tmp2, MAX_STRING_LENGTH);
					snprintf(tmp, MAX_STRING_LENGTH-1, " \"%s\"", tmp2); 
				}
				else
					snprintf(tmp, MAX_STRING_LENGTH-1, " \"%s\"", argv[i].a_w.w_sym->s_name); 
			}
			else
				snprintf(tmp, MAX_STRING_LENGTH-1, " %s", argv[i].a_w.w_sym->s_name);
			totalSize += strlen(tmp);
			strncat(buffer, tmp, MAX_EVENT_MESSAGE_SIZE - strlen(buffer) - 1);
			break;
		default: 
			error("csound_event(): Unrecognized element in event string.");
			return;
		}
	}

	// If the event string is too long, don't pass the truncated string to Csound.
	if(totalSize >= MAX_EVENT_MESSAGE_SIZE)
	{
		error("csound_event(): Event string size %d too large.  Max size is %d.", 
		     totalSize, MAX_EVENT_MESSAGE_SIZE - 1);
	}
	else if(!x->renderingToFile)
	{
		if(seq->recordControl.recording) Sequencer_AddCsoundEvent(seq, buffer, true);
		pthread_mutex_lock(&x->performMutex);
		csoundInputMessage(x->csound, buffer);
		pthread_mutex_unlock(&x->performMutex);
	}
}

void *csound_new(t_symbol *s, short argc, t_atom *argv)
{
	int i=0, numArgCount=0, iarg;
	char tmpStr[MAX_STRING_LENGTH];
	char *colon_loc = NULL, *str, *lastAttr = NULL, *csound_args = NULL;
	static bool firstTime = true;
	bool autostart = false;

    t_csound *x = (t_csound *)newobject(csound_class);
    	
    x->numInSignals = x->numOutSignals = DEFAULT_NUM_SIGNALS;
	
	if(firstTime)
	{
		// Post the version number.
		post("csound~ v1.0.7 (build 1)");
		firstTime = false;
	}
	
	x->scaleAudioData = true;
	x->valueInputEnabled = true;
	x->valueOutputEnabled = true;
	x->messageOutputEnabled = true;
	x->valueOutputOverdrive = false;
	x->maxClockInterval = DEFAULT_CLOCK_INTERVAL;
	
	// Initialize variables with the arguments to our object.
	for(i = 0; i < argc; i++)
	{
		switch(argv[i].a_type)
		{
			case A_LONG:
				iarg = argv[i].a_w.w_long;

				if(lastAttr != NULL)
				{
					if(strcmp(lastAttr, "@i") == 0)              x->numInSignals = iarg;
					else if(strcmp(lastAttr, "@o") == 0)         x->numOutSignals = iarg;
					else if(strcmp(lastAttr, "@io") == 0)        x->numInSignals = x->numOutSignals = iarg;
					else if(strcmp(lastAttr, "@scale") == 0)     x->scaleAudioData = (bool) iarg;
					else if(strcmp(lastAttr, "@overdrive") == 0) csound_valueOutputOverdrive(x, iarg);
					else if(strcmp(lastAttr, "@message") == 0)   csound_setMessageOutputEnabled(x, iarg);
					else if(strcmp(lastAttr, "@interval") == 0)  csound_setClockInterval(x, iarg);
					else if(strcmp(lastAttr, "@start") == 0)     autostart = (bool) iarg;
					else if(strcmp(lastAttr, "@input") == 0)     csound_setValueInputEnabled(x, iarg);
					else if(strcmp(lastAttr, "@output") == 0)    csound_setValueOutputEnabled(x, iarg);
					
					lastAttr = NULL;
				}
				else
				{
					if(numArgCount == 0)
						x->numInSignals = x->numOutSignals = argv[i].a_w.w_long;
					else if(numArgCount == 1)
						x->numOutSignals = argv[i].a_w.w_long;
					else
						error("csound~: Too many integer arguments.");
					++numArgCount;
				}
				break;
			case A_FLOAT:
				error("csound~: Float arguments not accepted.");
				lastAttr = NULL;
				break;
			case A_SYM:
				str = argv[i].a_w.w_sym->s_name;

				if(str[0] == '@') 
					lastAttr = str; 
				else 
				if(strstr(str, ".csd") || strstr(str, ".CSD") || 
				   strstr(str, ".orc") || strstr(str, ".ORC") ||
				   strstr(str, ".sco") || strstr(str, ".SCO"))
				{
					// The current string contains a csd/orc/sco file.
					// Treat it as an argument list for Csound.
					csound_args = str;
				}
				else
				{
					if(strcmp(str, "noscale") == 0)
						x->scaleAudioData = false;
					else
						error("csound~: Argument %s not recognized.", str);
				}
				break;
		}
	}
	
	if(x->numInSignals < 0) x->numInSignals = 2;
	if(x->numOutSignals < 0) x->numOutSignals = 2;
	
	// Add signal inlets.				
	dsp_setup((t_pxobject *)x, x->numInSignals);  
	((t_pxobject *)x)->z_misc = Z_NO_INPLACE;
	
	// Add non-signal outlets (right to left).
	x->done_bang_outlet = bangout(x);
	x->compiled_bang_outlet = bangout(x);
	x->midi_outlet = intout(x);
	x->message_outlet = listout(x);
	
	// Add signal outlets.
	for(i=0; i<x->numOutSignals; i++) outlet_new((t_object *)x, "signal"); 
	
	x->in = (float **) MemoryNew(sizeof(float *) * x->numInSignals);
	x->out = (float **) MemoryNew(sizeof(float *) * x->numOutSignals);
	pthread_mutex_init(&x->performMutex, NULL);

	x->textBuffer = (char *) MemoryNewClear(sizeof(char) * MAX_STRING_LENGTH);
	x->textBuffer[0] = '\0';  // Need to init in order for messageCallback() to work properly.
	pthread_mutex_init(&x->textBufferMutex, NULL);
	
	InitChannelGroup(&x->inChannelGroup);
	InitChannelGroup(&x->outChannelGroup);
	
	x->midiInputBuffer = MidiBuffer_Create();
	
	memset(x->args, 0, sizeof(char *) * MAX_ARGS);
	x->numArgs = 0;
	x->args[x->numArgs++] = strdup("-g"); // Just in case "start" is received before any "csound" message.
	x->compiled = false;
	x->ksmps = 32;                        // Init ksmps to avoid modulo by zero when setting x->evenlyDivisible.
	x->in_index = 0;
	x->out_index = 1000000;               // Must init to something larger than the largest possible Max vector size.
	x->performanceFinished = true;
	x->bypass = false;
	x->inChans = x->numInSignals;
	x->outChans = x->numOutSignals;

	x->csound = (CSOUND *) csoundCreate(x);
	
	csoundSetInputValueCallback(x->csound, inputValueCallback);
	csoundSetOutputValueCallback(x->csound, outputValueCallback);
	csoundSetMessageCallback(x->csound, messageCallback);

	x->qelemStart = qelem_new(x, (method)csound_startDeferred);
	x->qelemStop = qelem_new(x, (method)csound_stopDeferred);
	x->qelemRewind = qelem_new(x, (method)csound_rewindDeferred);
	x->qelemPerformanceFinished = qelem_new(x, (method)csound_performanceFinished);
	x->qelemCompiledBang = qelem_new(x, (method)csound_OutputCompiledBang);

	x->maxClock = clock_new(x, (method)csound_maxClockCallback);
	clock_fdelay(x->maxClock, x->maxClockInterval);
	
	x->renderThreadExists = false;
	x->path = (char *) MemoryNew(sizeof(char) * MAX_STRING_LENGTH);
	x->path[0] = '\0';
	x->defaultPathID = path_getdefault();
	x->defaultPath = (char *) MemoryNewClear(sizeof(char) * MAX_STRING_LENGTH);
	
	if(0 != path_topotentialname(x->defaultPathID, "", tmpStr, false))
		x->defaultPath[0] = '\0';
	else
	{
	#ifdef WINXP
		strcpy(x->defaultPath, tmpStr);
	#elif MACOSX
		// Copy tmpStr to x->defaultPath.  In the process, use the volume name
		// (e.g. "Macintosh HD:") to form an absolute path.   
		sprintf(x->defaultPath, "/Volumes/%s", tmpStr);
		colon_loc = strchr(x->defaultPath, ':');
		if(colon_loc) strcpy(colon_loc, (colon_loc+1));
	#endif
		SetEnvironment(x, x->defaultPath);
	}
	
	x->sr = sys_getsr();
	x->sequencer = Sequencer_New(x->csound, &x->inChannelGroup, x->midiInputBuffer, x->path, x->defaultPath);
	
	x->atomList[0].a_type = A_SYM;
	x->atomList[0].a_w.w_sym = gensym("rsidx");
	x->atomList[1].a_type = A_FLOAT;
	
	x->orcPath = (char *) MemoryNewClear(sizeof(char) * MAX_STRING_LENGTH);
	x->scoPath = (char *) MemoryNewClear(sizeof(char) * MAX_STRING_LENGTH);
	x->csdPath = (char *) MemoryNewClear(sizeof(char) * MAX_STRING_LENGTH);
	x->csdInPath = false;

	// If the user provided csound argument list with "@args",
	// process the argument list with csound_csound() and start Csound.
	if(csound_args)
	{
		t_atom temp_list[MAX_ATOM_LIST_SIZE];
		int size = CreateAtomListFromString(csound_args, temp_list, MAX_ATOM_LIST_SIZE);
		csound_csound(x, NULL, size, temp_list);
		if(autostart) csound_startDeferred(x);
	}

    return (x);
}

void csound_free(t_csound *x)
{
	dsp_free(&x->l_obj);
	csound_stopDeferred(x);
	Sequencer_Free(x->sequencer);
	clock_unset(x->maxClock);
	freeobject((t_object *) x->maxClock);
	qelem_unset(x->qelemStart);
	qelem_unset(x->qelemStop);
	qelem_unset(x->qelemRewind);
	qelem_unset(x->qelemPerformanceFinished);
	qelem_unset(x->qelemCompiledBang);
	qelem_free(x->qelemStart);
	qelem_free(x->qelemStop);
	qelem_free(x->qelemRewind);
	qelem_free(x->qelemPerformanceFinished);
	qelem_free(x->qelemCompiledBang);
	MemoryFree(x->in);
	MemoryFree(x->out);
	MemoryFree(x->textBuffer);
	MemoryFree(x->path);
	MemoryFree(x->defaultPath);
	MemoryFree(x->orcPath);
	MemoryFree(x->scoPath);
	MemoryFree(x->csdPath);
	MidiBuffer_Free(x->midiInputBuffer);
	csound_FreeArguments(x);
	FreeChannelGroup(&x->inChannelGroup);
	FreeChannelGroup(&x->outChannelGroup);
	pthread_mutex_destroy(&x->performMutex);
	pthread_mutex_destroy(&x->textBufferMutex);
	csoundDestroy(x->csound);
}

void csound_FreeArguments(t_csound *x)
{
	int i;
	
	for(i=0; i<x->numArgs; i++) 
		if(x->args[i]) 
		{	
			MemoryFree(x->args[i]);
			x->args[i] = NULL;
		}

	x->numArgs = 0;
}

void csound_PrintArguments(t_csound *x)
{
	int i=0;
	char line[MAX_STRING_LENGTH];
	
	if(x->numArgs == 0) return;
	
	line[0] = '\n'; line[1] = '\0';
	while(i<x->numArgs) 
	{
		strncat(line, x->args[i], MAX_STRING_LENGTH - strlen(x->args[i]) - 1);
		strncat(line, " ", MAX_STRING_LENGTH - 2);
		++i;
	}
	post(line);
}

void csound_csound(t_csound *x, t_symbol *s, short argc, t_atom *argv)
{
	int i;
	char *str = NULL, tmp[MAX_STRING_LENGTH], tmp2[MAX_STRING_LENGTH], *strPtr = NULL;
	char *colon_loc = NULL;
	bool rtmidi_flagPresent = false;
	bool M_flagPresent = false;
	bool d_flagPresent = false;
	bool g_flagPresent = false;
	bool F_flagPresent = false;
	bool T_flagPresent = false;
	bool isCSD = false, isORC = false, isSCO = false;
	short pathID;
	long type;
	long typelist = 'TEXT';
	int result;
	FILE *fp = NULL;
	
	if(argc == 0) return;
	
	csound_FreeArguments(x);

	x->argListValid = true;
	x->audioOutputFileInArgList = false;
	x->csdInPath = false;
	
	x->args[x->numArgs++] = strdup("csound"); 
	
	for(i=0; i<argc; i++)
	{
		if(argv[i].a_type == A_SYM)
		{
			str = argv[i].a_w.w_sym->s_name;
			strncpy(tmp, str, MAX_STRING_LENGTH-1);
			
			if(isQuoted(tmp)) removeQuotes(tmp);
			if(isAbsoluteMaxPath(tmp)) convertMaxPathToPosixPath(tmp, tmp, MAX_STRING_LENGTH);
			
			if(strstr(tmp, "-+rtmidi")) rtmidi_flagPresent = true;
			if(strstr(tmp, "-M")) M_flagPresent = true;
			if(strstr(tmp, "-d")) d_flagPresent = true;
			if(strstr(tmp, "-g")) g_flagPresent = true;
			if(strstr(tmp, "-F")) F_flagPresent = true;
			if(strstr(tmp, "-T")) T_flagPresent = true;
			
			if(strstr(tmp, "-o"))
			{
				if(strlen(tmp) == 2)
				{	// There's a space between "-o" and the name of the file.
					if((i+1)<argc)
					{
						strncpy(tmp2, argv[i+1].a_w.w_sym->s_name, MAX_STRING_LENGTH-1);
						if(!strstr(tmp2, "devaudio") && !strstr(tmp2, "dac")) x->audioOutputFileInArgList = true;
					}
				}
				else if(!strstr(tmp, "devaudio") && !strstr(tmp, "dac")) x->audioOutputFileInArgList = true;
			}
			
			x->args[x->numArgs++] = strdup(tmp); // Add current argument to args array.
			
			// If the current argument is a csd/orc/sco file, try to find it.
			// If it can't be found, use Max's locatefile_extended() to find it
			// and to extract an absolute path.
			isCSD = isORC = isSCO = false;
			if(strstr(tmp, ".csd") || strstr(tmp, ".CSD")) isCSD = true;
			else if(strstr(tmp, ".orc") || strstr(tmp, ".ORC")) isORC = true;
			else if(strstr(tmp, ".sco") || strstr(tmp, ".SCO")) isSCO = true;
			if(isCSD || isORC || isSCO)
			{
				// Set the current directory again (in case it was changed).
				if(strlen(x->path)) change_directory(x->path);
				else if(strlen(x->defaultPath)) change_directory(x->defaultPath);	
				
				fp = fopen(tmp, "r");
				if(fp != NULL) 
				{
					fclose(fp); 
				}
				else
				{
					result = locatefile_extended(tmp, &pathID, &type, &typelist, 1);
					if(result == 0)
					{
						path_topathname(pathID, tmp, tmp2); // Get a Max style absolute pathname. 
						
						free(x->args[x->numArgs-1]);
						
						#ifdef WINXP
							strcpy(tmp, tmp2);
						#elif MACOSX
							// Use the volume name (e.g. "Macintosh HD:") to form an absolute path.   
							sprintf(tmp, "/Volumes/%s", tmp2);
							colon_loc = strchr(tmp, ':');
							if(colon_loc) strcpy(colon_loc, (colon_loc+1));
						#endif

						x->args[x->numArgs-1] = strdup(tmp);
					}
					else
					{
						x->argListValid = false;
						error("csound~: Can't find file %s.", tmp);
					}
				}
				
				if(isCSD) { x->csdInPath = true; strPtr = x->csdPath; }
				else if(isORC) strPtr = x->orcPath;
				else if(isSCO) strPtr = x->scoPath;
				
				if(isAbsolutePath(tmp))
					strncpy(strPtr, tmp, MAX_STRING_LENGTH-1);
				else
				{
					if(strlen(x->path))
						snprintf(strPtr, MAX_STRING_LENGTH-1, "%s/%s", x->path, tmp);
					else if(strlen(x->defaultPath))
						snprintf(strPtr, MAX_STRING_LENGTH-1, "%s/%s", x->defaultPath, tmp);
				}
			}
		}
		else if(argv[i].a_type == A_LONG)
		{
			sprintf(tmp2, "%d", argv[i].a_w.w_long);
			x->args[x->numArgs++] = strdup(tmp2);
		}
		else if(argv[i].a_type == A_FLOAT)
		{
			sprintf(tmp2, "%f", argv[i].a_w.w_float);
			x->args[x->numArgs++] = strdup(tmp2);
		}
	}
	
	// If neither -d or -g flag is present, then add -g.  Need either -d or -g to prevent crashing.
	if(!d_flagPresent && !g_flagPresent) x->args[x->numArgs++] = strdup("-g"); 
	
	x->renderingToFile = x->audioOutputFileInArgList;
	
	// If we're rendering to a file and -Fsomefilename is present and the -T flag is not present, add it.
	if(x->renderingToFile && F_flagPresent && !T_flagPresent) x->args[x->numArgs++] = strdup("-T"); 
	
	// Need this so that MIDI input is enabled.  We are not going
	// to let Csound accept MIDI data from MaxMSP; below we're going
	// to set the midiReadCallback function pointer to our own function.
	if(!rtmidi_flagPresent) x->args[x->numArgs++] = strdup("-+rtmidi=null"); 
	if(!M_flagPresent) x->args[x->numArgs++] = strdup("-M0");	
}

void csound_start(t_csound *x) { qelem_set(x->qelemStart); }
void csound_startDeferred(t_csound *x)
{
	int threadCreateResult;
	CSOUND_STATUS result;
	char *opcodedir = NULL;
	char default_opcodedir[256];
	MYFLT *csIn = NULL;
	const char fullpath[255];
	const char* path = getenv("HADRONPATH");

	if(!x->argListValid)
	{
		error("csound~: \"csound\" message contains files that can't be found.  Please give me a valid message first.");
		return;
	}
	
	MidiBuffer_Clear(x->midiInputBuffer);

#ifdef MACOSX
	if(sizeof(MYFLT) == sizeof(float))
		sprintf(default_opcodedir, "/Library/Frameworks/CsoundLib.framework/Resources/Opcodes");
	else
		sprintf(default_opcodedir, "/Library/Frameworks/CsoundLib64.framework/Resources/Opcodes");
#elif WINXP
	if(sizeof(MYFLT) == sizeof(float))
		sprintf(default_opcodedir, "C:\\Program Files\\Csound\\plugins");
	else
		sprintf(default_opcodedir, "C:\\Program Files\\Csound\\plugins64");
#endif

	opcodedir = (char*) csoundGetEnv(NULL, "OPCODEDIR");
	/*if(!opcodedir)*/ 
	strcpy(fullpath, path);
	strcat(fullpath, "/Csound_Hadron/plugins64");
		result = csoundSetGlobalEnv("OPCODEDIR64", fullpath);
	
	if(x->compiled && !x->performanceFinished && x->renderThreadExists) 
	{
		csound_stopDeferred(x);
		if(0 != pthread_join(x->renderThread, NULL))
			error("csound~: pthread_join() with render thread failed.");
		x->renderThreadExists = false;
	}
	
	if(pthread_mutex_lock(&x->performMutex) == 0)
	{
		x->compiled = false;
		
		// Let the user know what arguments are being passed to csoundCompile().
		if(x->messageOutputEnabled) csound_PrintArguments(x);
		
		result = csoundPreCompile(x->csound);
		if(result == CSOUND_SUCCESS) 
		{		
			// Cannot render to file if csoundSetHostImplementedAudioIO() is called.
			if(!x->renderingToFile) csoundSetHostImplementedAudioIO(x->csound, 1, 0);
			
			// These functions cannot be called until after csoundPreCompile()
			// has executed.  csoundPreCompile() allocates memory for an MGLOBAL
			// struct which contains the pointers to these functions.
			csoundSetExternalMidiInOpenCallback(x->csound, midiInOpenCallback);
			csoundSetExternalMidiInCloseCallback(x->csound, midiInCloseCallback);
			csoundSetExternalMidiReadCallback(x->csound, midiReadCallback);			
			csoundSetExternalMidiOutOpenCallback(x->csound, midiOutOpenCallback);
			csoundSetExternalMidiOutCloseCallback(x->csound, midiOutCloseCallback);
			csoundSetExternalMidiWriteCallback(x->csound, midiWriteCallback);
			
			// Set the current directory again (in case it was changed).
			if(strlen(x->path)) change_directory(x->path);
			else if(strlen(x->defaultPath)) change_directory(x->defaultPath);
			
			result = csoundCompile(x->csound, x->numArgs, x->args);
			if(result == CSOUND_SUCCESS) 
			{
				csoundSetHostData(x->csound, x);
				x->chans = csoundGetNchnls(x->csound);
				x->ksmps = csoundGetKsmps(x->csound);
				x->evenlyDivisible = (x->vectorSize % x->ksmps == 0);
				maxChannelStringLength = csoundGetStrVarMaxLen(x->csound);
				x->compiled = true;
				x->in_index = 0;
				x->out_index = 1000000; // Must init to something larger than the largest possible Max vector size.
				x->performanceFinished = false;
				x->csound_sr = csoundGetSr(x->csound);
				x->sequencer->sr = x->csound_sr;
				if(sys_getdspstate() && x->sr != x->csound_sr && x->messageOutputEnabled)
					error("csound~: MaxMSP sr %d != Csound sr %d", x->sr, x->csound_sr);

				x->scale = csoundGet0dBFS(x->csound);
				x->oneDivScale = 1.0 / x->scale;
				
				if(x->chans != x->numInSignals && x->messageOutputEnabled)
					error("csound~: # of Csound audio channels (%d) != # of signal inlets (%d).", x->chans, x->numInSignals);
				
				if(x->chans != x->numOutSignals && x->messageOutputEnabled)
					error("csound~: # of Csound audio channels (%d) != # of signal outlets (%d).", x->chans, x->numOutSignals);
				
				// Get channels declared with chn_k.
				csound_GetCsoundChannelPtrs(x);
				
				// If DSP is not active, perform one k-cycle of the newly compiled Csound instance to force table loading.
				if(!sys_getdspstate())
				{
					csIn = csoundGetSpin(x->csound);
					memset(csIn, 0, sizeof(MYFLT) * x->ksmps * x->chans); // Fill the input buffers with zeros.
					x->performanceFinished = csoundPerformKsmps(x->csound);
				}
				
				// Since user may use the "compiled" bang to trigger other csound~ related functions,
				// ensure that it runs in another thread to avoid deadlocks.
				//qelem_set(x->qelemCompiledBang);
				
				// Get channels declared inside instruments that are active after 1 k-cycle.
				csound_GetCsoundChannelPtrs(x);
				
				// Set inChans to the lesser of the two (x->chans and x->numInSignals).  Same for outChans.
				x->inChans = (x->chans < x->numInSignals ? x->chans : x->numInSignals);
				x->outChans = (x->chans < x->numOutSignals ? x->chans : x->numOutSignals);
				
				if(x->renderingToFile)
				{
					threadCreateResult = pthread_create(&x->renderThread, NULL, (void *)csound_renderThreadFunc, (void *) x);
					if(threadCreateResult != 0) error("csound~: Could not create Csound render thread.");
					else x->renderThreadExists = true;
				}
			}
			else error("csound~: csoundCompile() failed.");
		}
		else error("csound~: csoundPreCompile() failed.");
		
		pthread_mutex_unlock(&x->performMutex);
	}
if(result == CSOUND_SUCCESS) outlet_bang(x->compiled_bang_outlet);
}

void csound_stop(t_csound *x) { qelem_set(x->qelemStop); }
void csound_stopDeferred(t_csound *x)
{
	if(!x->compiled) return;
	
	if(pthread_mutex_lock(&x->performMutex) == 0)
	{
		csound_ClearCsoundChannelPtrs(x);
		csoundReset(x->csound);
		x->compiled = false;
		x->performanceFinished = true;
		csound_performanceFinished(x);
		pthread_mutex_unlock(&x->performMutex);
	}
}

void csound_recordStart(t_csound *x)
{
	if(!x->renderingToFile && !x->renderThreadExists)
		Sequencer_StartRecording(x->sequencer, &x->inChannelGroup);
}

void csound_recordStop(t_csound *x)
{
	Sequencer_StopRecording(x->sequencer);
}

void csound_playStart(t_csound *x)
{
	if(!x->renderingToFile && !x->renderThreadExists)
		Sequencer_StartPlaying(x->sequencer);
}

void csound_playStop(t_csound *x)
{
	Sequencer_StopPlaying(x->sequencer);
}

// To reset, just call the csound_start() function.  csound_start() calls
// csoundPreCompile(), which calls csoundReset() automatically.
void csound_reset(t_csound *x) { qelem_set(x->qelemStart); }
void csound_rewind(t_csound *x) { qelem_set(x->qelemRewind); }
void csound_rewindDeferred(t_csound *x)
{
	if(!x->compiled) return;
	
	if(pthread_mutex_lock(&x->performMutex) == 0)
	{
		csoundSetScoreOffsetSeconds(x->csound, (MYFLT) 0);
		csoundRewindScore(x->csound);
		csoundSetScorePending(x->csound, 1);
		x->performanceFinished = false;
		pthread_mutex_unlock(&x->performMutex);
	}
}

void csound_sfdir(t_csound *x, t_symbol *s) { SetEnvironment(x, s->s_name); }
void SetEnvironment(t_csound *x, char *path)
{
	int result;
	char tmp[MAX_STRING_LENGTH];
	
	if(isAbsoluteMaxPath(path))	
		convertMaxPathToPosixPath(path, tmp, MAX_STRING_LENGTH);
	else
		strncpy(tmp, path, MAX_STRING_LENGTH-1);
	
	if(strlen(tmp))
	{
		result = csoundSetGlobalEnv("SFDIR", tmp);
		if(result != CSOUND_SUCCESS) error("Unable to set SFDIR to %s", tmp);
		result = csoundSetGlobalEnv("SSDIR", tmp);
		if(result != CSOUND_SUCCESS) error("Unable to set SSDIR to %s", tmp);
		result = csoundSetGlobalEnv("SADIR", tmp);
		if(result != CSOUND_SUCCESS) error("Unable to set SADIR to %s", tmp);
		result = csoundSetGlobalEnv("INCDIR", tmp);
		if(result != CSOUND_SUCCESS) error("Unable to set INCDIR to %s", tmp);
		result = csoundSetGlobalEnv("CSSTRNGS", tmp);
		if(result != CSOUND_SUCCESS) error("Unable to set CSSTRNGS to %s", tmp);
	}
}

void csound_performanceFinished(t_csound *x) { outlet_bang(x->done_bang_outlet); }

void csound_maxClockCallback(t_csound *x)
{	
	if(x->valueOutputEnabled && !x->valueOutputOverdrive)
	{
		OutputDirtyChannels(&x->outChannelGroup, x->message_outlet);
		clock_fdelay(x->maxClock, x->maxClockInterval);
	}
}

void csound_renderThreadFunc(t_csound *x)
{
	Sequencer *seq = x->sequencer;
	RecordControl *rc = &seq->recordControl;
	bool inStoppageTime = false;
	int stoppageCounter = 0, stoppageTime = DEFAULT_STOPPAGE_TIME * x->csound_sr;

	Sequencer_StopRecording(seq);
	Sequencer_StopPlaying(seq);

	seq->time = seq->nticks = seq->fticks = 0;
	seq->nSamples = 0;
	rc->curPlayEvent = &rc->recEventListHdr;
	
	Sequencer_SampleBasedTimerCallback(seq);
	
	while(1)
	{
		if(pthread_mutex_lock(&x->performMutex) == 0)
		{
			if(!x->performanceFinished)
			{
				x->performanceFinished = csoundPerformKsmps(x->csound);
				Sequencer_AdvanceSampleCount(seq, x->ksmps);
				if(pthread_mutex_lock(&seq->mutex) == 0)
				{
					if(!inStoppageTime && rc->curPlayEvent == NULL)
					{
						inStoppageTime = TRUE;
						stoppageCounter = 0;
					}
					pthread_mutex_unlock(&seq->mutex);
				}
				if(inStoppageTime)
				{
					stoppageCounter += x->ksmps;
					if(stoppageCounter >= stoppageTime) x->performanceFinished = TRUE;
				}
			}
			if(x->performanceFinished)
			{
				pthread_mutex_unlock(&x->performMutex);
				csound_stopDeferred(x); // may be redundant, but harmless.
				qelem_set(x->qelemPerformanceFinished);
				x->renderThreadExists = false;
				pthread_exit(NULL);
			}
			pthread_mutex_unlock(&x->performMutex);
		}
	}
	
	x->renderThreadExists = false;
	pthread_exit(NULL);
}

void inputValueCallback(CSOUND *csound, const char *name, MYFLT *val)
{
	t_csound *x = (t_csound *) csoundGetHostData(csound);
	ChannelObject *co = NULL;

	if(name == NULL) return;
	pthread_mutex_lock(&x->inChannelGroup.mutex);
	co = FindChannel(&x->inChannelGroup, name, false);
	if(co) *val = (MYFLT) co->value;
	else   *val = (MYFLT) 0.0f;
	pthread_mutex_unlock(&x->inChannelGroup.mutex);
}

void outputValueCallback(CSOUND *csound, const char *name, MYFLT val)
{
	t_csound *x = (t_csound *) csoundGetHostData(csound);
	ChannelObject *co = NULL;
	t_atom *atomList = x->outChannelGroup.atomList;
	
	if(name == NULL) return;
	pthread_mutex_lock(&x->outChannelGroup.mutex);
	co = FindCreateChannel(&x->outChannelGroup, name, CSOUND_OUTPUT_CHANNEL | CSOUND_CONTROL_CHANNEL, false);
	if(x->valueOutputEnabled && x->valueOutputOverdrive && co->value != val)
	{
		// Output the name and value pair immediately.
		co->dirty = false;
		atomList[0].a_w.w_sym = co->sym;
		atomList[1].a_w.w_float = val;
		outlet_list(x->message_outlet, 0L, 2, atomList);
	}
	else
	{
		// Mark the name and value pair as dirty; it will
		// be output the next time csound_maxClockCallback() is called.
		co->dirty = true;
	}
	co->value = val;
	pthread_mutex_unlock(&x->outChannelGroup.mutex);
}

void messageCallback(CSOUND *csound, int attr, const char *format, va_list valist)
{	
	t_csound *x = (t_csound *) csoundGetHostData(csound);
	char text[MAX_STRING_LENGTH], *newLine = NULL, *ptr = NULL;
	static char tab = (char) 9;
	
	if(!x->messageOutputEnabled) return;
	
	vsprintf(text, format, valist);	// Convert symbols to numbers and store output in text.
	
	// x->textBuffer is protected by a mutex because multiple calls to messageCallback()
	// may occur at the same time.
	if(pthread_mutex_lock(&x->textBufferMutex) == 0)
	{
		strncat(x->textBuffer, text, MAX_STRING_LENGTH - strlen(x->textBuffer) - 1);
		// If x->text contains a newline, it's time to print x->text.
		if((newLine = strrchr(x->textBuffer, '\n')) != NULL)
		{
			*newLine = ' ';

			// Look for tabs (9), if found replace with space (32).
			while((ptr = strrchr(x->textBuffer, tab)) != NULL) *ptr = ' ';

			post("%s", x->textBuffer);
			x->textBuffer[0] = '\0'; // Clear the contents of x->text.
		}
		pthread_mutex_unlock(&x->textBufferMutex);	
	}
}

int midiInOpenCallback(CSOUND *csound, void **userData, const char *buf) { return 0; }
int midiInCloseCallback(CSOUND *csound, void *userData) { return 0; }

// Read at most 'nbytes' bytes from our MidiBuffer and store in 'buf'. Returns the 
// actual number of bytes read. Incomplete messages (such as a note on status without 
// the data bytes) should not be returned.
int midiReadCallback(CSOUND *csound, void *userData, unsigned char *buf, int nbytes)
{
	t_csound *x = (t_csound *) csoundGetHostData(csound);
	MidiBuffer *mb = x->midiInputBuffer;
	Sequencer *seq = x->sequencer;
	RecordControl *rc = &seq->recordControl;
	int bytesLeft = nbytes, bytesRead = 0;
	byte b = 0, chan, ctrl, val, status = 0;
	
	while(bytesLeft)
	{
		if(MidiBuffer_Peek(mb, &b))
		{
			status = b & 0xf0;
			switch(status)
			{
			case 0x80: // Note-off (3 bytes)
			case 0x90: // Note-on (3 bytes)
			case 0xA0: // Aftertouch (3 bytes)
			case 0xE0: // Pitch Bend (3 bytes)
				if(bytesLeft >= 3 && MidiBuffer_GetSize(mb) >= 3)
				{
					MidiBuffer_DequeueBuffer(mb, &buf[bytesRead], 3);
					if(rc->recording) Sequencer_AddMIDIEvent(seq, &buf[bytesRead], 3, true);
					bytesRead += 3;
					bytesLeft -= 3;
				}
				else return bytesRead;	
				break;
			case 0xB0: // Control Change (3 bytes)
				if(bytesLeft >= 3 && MidiBuffer_GetSize(mb) >= 3)
				{
					MidiBuffer_DequeueBuffer(mb, &buf[bytesRead], 3);
					if(rc->recording) Sequencer_AddMIDIEvent(seq, &buf[bytesRead], 3, true);
					chan = b & 0x0f;
					ctrl = buf[bytesRead + 1];
					val = buf[bytesRead + 2];
					seq->ctrlMatrix[chan][ctrl] = val;
					bytesRead += 3;
					bytesLeft -= 3;
				}
				else return bytesRead;
				break;
			case 0xC0: // Program Change (2 bytes)
			case 0xD0: // Channel Aftertouch (2 bytes)
				if(bytesLeft >= 2 && MidiBuffer_GetSize(mb) >= 2)
				{
					MidiBuffer_DequeueBuffer(mb, &buf[bytesRead], 2);
					if(rc->recording) Sequencer_AddMIDIEvent(seq, &buf[bytesRead], 2, true);
					bytesRead += 2;
					bytesLeft -= 2;
				} 
				else return bytesRead;
				break;
			default: // Status unrecognized.
				MidiBuffer_Dequeue(mb); // Discard the current byte.
				break;
			}	
		}
		else break; // x->midiInputBuffer is empty
	}
	
	return bytesRead;
}

int midiOutOpenCallback(CSOUND *csound, void **userData, const char *buf) { return 0; }
int midiOutCloseCallback(CSOUND *csound, void *userData) { return 0; }
int midiWriteCallback(CSOUND *csound, void *userData, const unsigned char *buf, int nbytes)
{
	t_csound *x = (t_csound *) csoundGetHostData(csound);
	int bytesWritten = 0;
	
	while(bytesWritten < nbytes) outlet_int(x->midi_outlet, (int)buf[bytesWritten++]);
	
	return bytesWritten;
}						

// Gets pointers to Csound Channels (not to be confused with our
// ChannelObject).  It also initializes them to whatever is stored
// in it's respective ChannelObject. 
void csound_GetCsoundChannelPtrs(t_csound *x)
{
	int i, result, numCsoundChannels;
	ChannelObject *co = NULL;
	CsoundChannelListEntry *csoundChanList = NULL;
	int inType = CSOUND_INPUT_CHANNEL | CSOUND_CONTROL_CHANNEL;
	int outType = CSOUND_OUTPUT_CHANNEL | CSOUND_CONTROL_CHANNEL;

	csound_ClearCsoundChannelPtrs(x);

	numCsoundChannels = csoundListChannels(x->csound, &csoundChanList);
	
	pthread_mutex_lock(&x->inChannelGroup.mutex);
		// Get input channel pointers using the list returned by csoundListChannels().
		for(i=0; i<numCsoundChannels; i++)
		{
			if((csoundChanList[i].type & inType) == inType)
			{
				co = FindCreateChannel(&x->inChannelGroup, csoundChanList[i].name, csoundChanList[i].type, false);
				if(co)
				{
					result = csoundGetChannelPtr(x->csound, &co->csoundChanPtr, co->name, co->type);
						
					if(result != 0) 
						error("csound~: Unable to get/create a Csound input control channel for \"%s\"", co->name);	
						
					if(co->csoundChanPtr) 
					{
						if(IsControlChannel(co))     *co->csoundChanPtr = co->value;
						else if(IsStringChannel(co)) SetChannelString(co, co->str);
					}
				}
			}
		}
		
		// Get input channel pointers for all ChannelObjects that still have csoundChanPtr == NULL.
		for(i=0; i<HASH_TABLE_SIZE; i++)
		{
			co = x->inChannelGroup.hashTable[i];
			while(co)
			{
				if(co->csoundChanPtr == NULL)
				{
					result = csoundGetChannelPtr(x->csound, &co->csoundChanPtr, co->name, co->type);
						
					if(result != 0) 
						error("csound~: Unable to get/create a Csound input control channel for \"%s\"", co->name);	
						
					if(co->csoundChanPtr) 
					{
						if(IsControlChannel(co))     *co->csoundChanPtr = co->value;
						else if(IsStringChannel(co)) SetChannelString(co, co->str);
					}
				}
				co = co->next;
			}
		}
	pthread_mutex_unlock(&x->inChannelGroup.mutex);
	
	pthread_mutex_lock(&x->outChannelGroup.mutex);
		// Get output channel pointers using the list returned by csoundListChannels().
		for(i=0; i<numCsoundChannels; i++)
		{
			if((csoundChanList[i].type & outType) == outType)
			{
				co = FindCreateChannel(&x->outChannelGroup, csoundChanList[i].name, csoundChanList[i].type, false);
				if(co)
				{
					result = csoundGetChannelPtr(x->csound, &co->csoundChanPtr, co->name, co->type);
						
					if(result != 0) 
						error("csound~: Unable to get/create a Csound output control channel for \"%s\"", co->name);	
						
					if(co->csoundChanPtr) 
					{
						if(IsControlChannel(co))     co->value = *co->csoundChanPtr;
						else if(IsStringChannel(co)) GetChannelString(co, co->str);
					}
				}
			}
		}
	pthread_mutex_unlock(&x->outChannelGroup.mutex);
	
	if(csoundChanList) csoundDeleteChannelList(x->csound, csoundChanList);
}

// Set all Csound Channel pointers to NULL so that calls to SetInChannelVal()
// do not try to set a float that doesn't exist anymore.
void csound_ClearCsoundChannelPtrs(t_csound *x)
{
	int i;
	ChannelObject *co = NULL;
	
	pthread_mutex_lock(&x->inChannelGroup.mutex);
	for(i=0; i<HASH_TABLE_SIZE; i++)
	{
		co = x->inChannelGroup.hashTable[i];
		while(co)
		{
			co->csoundChanPtr = NULL;
			co = co->next;
		}
	}	
	pthread_mutex_unlock(&x->inChannelGroup.mutex);
	
	pthread_mutex_lock(&x->outChannelGroup.mutex);
	for(i=0; i<HASH_TABLE_SIZE; i++)
	{
		co = x->outChannelGroup.hashTable[i];
		while(co)
		{
			co->csoundChanPtr = NULL;
			co = co->next;
		}
	}	
	pthread_mutex_unlock(&x->outChannelGroup.mutex);
}

void csound_write(t_csound *x, t_symbol *s, short argc, t_atom *argv)
{
	Sequencer *seq = x->sequencer;
	int threadCreateResult;
	char *str = NULL;
	
	if(argc < 1 || argv[0].a_type != A_SYM) return;
	if(strlen(argv[0].a_w.w_sym->s_name) >= MAX_STRING_LENGTH)
	{
		error("csound~: Pathname of destination file too long. (Max = %d)", MAX_STRING_LENGTH - 1);
		return;
	}

	if(seq->readWriteThreadExists) 
	{
		// If we're already reading or writing a file, don't do anything.
		error("csound~: Write failed; still reading/writing another file.");
		return;
	}

	str = x->sequencer->writeFilename;

	strcpy(str, argv[0].a_w.w_sym->s_name);
	
	if(isQuoted(str)) removeQuotes(str);
	if(isAbsoluteMaxPath(str))
		convertMaxPathToPosixPath(str, str, MAX_STRING_LENGTH);
	
	threadCreateResult = pthread_create(&seq->readWriteThread, NULL, (void*) Sequencer_WriteToFile, (void*) seq);
	if(threadCreateResult != 0) error("csound~: Could not create write thread.");
	else seq->readWriteThreadExists = true;
}

void csound_read(t_csound *x, t_symbol *s, short argc, t_atom *argv)
{
	Sequencer *seq = x->sequencer;
	int threadCreateResult;
	char *str = NULL;
	
	if(argc < 1 || argv[0].a_type != A_SYM) return;
	if(strlen(argv[0].a_w.w_sym->s_name) >= MAX_STRING_LENGTH)
	{
		error("csound~: Pathname of source file too long. (Max = %d)", MAX_STRING_LENGTH - 1);
		return;
	}

	if(seq->readWriteThreadExists) 
	{
		// If we're already reading or writing a file, don't do anything.
		error("csound~: Read failed; still reading/writing another file.");
		return;
	}

	str = x->sequencer->readFilename;
	strcpy(str, argv[0].a_w.w_sym->s_name);
	if(isQuoted(str)) removeQuotes(str);	
	if(isAbsoluteMaxPath(str))
		convertMaxPathToPosixPath(str, str, MAX_STRING_LENGTH);
	
	threadCreateResult = pthread_create(&seq->readWriteThread, NULL, (void*) Sequencer_ReadFromFile, (void*) seq);
	if(threadCreateResult != 0) error("csound~: Could not create read thread.");
	else seq->readWriteThreadExists = true;
}

void csound_tempo(t_csound *x, double f)
{
	// Don't allow changes to bpm while recording.
	if(!x->sequencer->recordControl.recording) Sequencer_SetBPM(x->sequencer, (float) (f * DEFAULT_BPM));
}

void csound_bypass(t_csound *x, long n)
{
	x->bypass = (n ? true : false);
}

void csound_loadSample(t_csound *x, t_symbol *s, short argc, t_atom *argv)
{
	int tableNum, channel, result=0;
	char filename[MAX_STRING_LENGTH];
	float offsetSeconds = 0.0f;
	float sizeSeconds = 0.0f; 
	
	if(argc < 3 || argv[0].a_type != A_LONG || argv[1].a_type != A_LONG || argv[2].a_type != A_SYM) return;
	tableNum = argv[0].a_w.w_long;
	channel = argv[1].a_w.w_long;
	strncpy(filename, argv[2].a_w.w_sym->s_name, MAX_STRING_LENGTH-1);
	
	// If 4'th argument exists, it specifies offset time in seconds.
	if(argc > 3)
	{
		switch(argv[3].a_type) 
		{
		case A_FLOAT:
			offsetSeconds = argv[3].a_w.w_float;
			break;
		case A_LONG:
			offsetSeconds = (float) argv[3].a_w.w_long;
			break;
		}
	}
	
	// If 5'th argument exists, it specifies time to read in seconds.
	if(argc > 4)
	{
		switch(argv[4].a_type) 
		{
		case A_FLOAT:
			sizeSeconds = argv[4].a_w.w_float;
			break;
		case A_LONG:
			sizeSeconds = (float) argv[4].a_w.w_long;
			break;
		}
	}
	
	pthread_mutex_lock(&x->performMutex);
	
		if(x->compiled && !x->performanceFinished)
		{
			if(isQuoted(filename)) removeQuotes(filename);
			
			if(isAbsoluteMaxPath(filename)) convertMaxPathToPosixPath(filename, filename, MAX_STRING_LENGTH);
			
			if(!isAbsolutePath(filename))
			{
				// Set the current directory again (in case it was changed).
				if(strlen(x->path)) change_directory(x->path);
				else if(strlen(x->defaultPath)) change_directory(x->defaultPath);
			}
		
			// If tableNum < 0, then increase the size of the target table if necessary;
			// otherwise, just fill it up as much as possible.
			result = CsoundTable_LoadAudioFile(x->csound, filename, abs(tableNum), channel, (tableNum < 0 ? 1 : 0), offsetSeconds, sizeSeconds);
		}
	
	pthread_mutex_unlock(&x->performMutex);
}

void csound_readBuf(t_csound *x, t_symbol *s, short argc, t_atom *argv)
{
	int tableNum, channel, result=0;
	float offsetSeconds = 0.0f;
	float sizeSeconds = 0.0f;
	
	if(argc < 3 || argv[0].a_type != A_LONG || argv[1].a_type != A_LONG || argv[2].a_type != A_SYM) return;
	tableNum = argv[0].a_w.w_long;
	channel = argv[1].a_w.w_long;
	
	// If 4'th argument exists, it specifies offset time in seconds.
	if(argc > 3)
	{
		switch(argv[3].a_type) 
		{
		case A_FLOAT: offsetSeconds = argv[3].a_w.w_float;  break;
		case A_LONG:  offsetSeconds = (float) argv[3].a_w.w_long;  break;
		}
	}
	
	// If 5'th argument exists, it specifies time to read in seconds.
	if(argc > 4)
	{
		switch(argv[4].a_type) 
		{
		case A_FLOAT: sizeSeconds = argv[4].a_w.w_float;  break;
		case A_LONG:  sizeSeconds = (float) argv[4].a_w.w_long; break;
		}
	}

	pthread_mutex_lock(&x->performMutex);
	
		if(x->compiled && !x->performanceFinished)
			result = CsoundTable_ReadBufferTilde(x->csound, argv[2].a_w.w_sym, abs(tableNum), channel, (tableNum < 0 ? 1 : 0), offsetSeconds, sizeSeconds);
	
	pthread_mutex_unlock(&x->performMutex);
}

void csound_writeBuf(t_csound *x, t_symbol *s, short argc, t_atom *argv)
{
	int tableNum, channel;
	float offsetSeconds = 0.0f;
	float sizeSeconds = 0.0f; 
	
	if(argc < 3 || argv[0].a_type != A_LONG || argv[1].a_type != A_LONG || argv[2].a_type != A_SYM) return;
	tableNum = argv[0].a_w.w_long;
	channel = argv[1].a_w.w_long;
	
	// If 4'th argument exists, it specifies offset time in seconds.
	if(argc > 3)
	{
		switch(argv[3].a_type) 
		{
		case A_FLOAT: offsetSeconds = argv[3].a_w.w_float;  break;
		case A_LONG:  offsetSeconds = (float) argv[3].a_w.w_long;  break;
		}
	}
	
	// If 5'th argument exists, it specifies time to read in seconds.
	if(argc > 4)
	{
		switch(argv[4].a_type) 
		{
		case A_FLOAT: sizeSeconds = argv[4].a_w.w_float;  break;
		case A_LONG:  sizeSeconds = (float) argv[4].a_w.w_long;  break;
		}
	}

	pthread_mutex_lock(&x->performMutex);
	
		if(x->compiled && !x->performanceFinished)
			CsoundTable_WriteBufferTilde(x->csound, argv[2].a_w.w_sym, abs(tableNum), channel, offsetSeconds, sizeSeconds);
	
	pthread_mutex_unlock(&x->performMutex);
}

void csound_readSampleIndex(t_csound *x, t_symbol *s, short argc, t_atom *argv)
{
	int tableNum, index, result = -1;
	MYFLT val;
	
	if(argc != 2 || argv[0].a_type != A_LONG || argv[1].a_type != A_LONG) return;
	tableNum = argv[0].a_w.w_long;
	index = argv[1].a_w.w_long;
	if(index < 0) return;
	
	pthread_mutex_lock(&x->performMutex);
		
		if(x->compiled && !x->performanceFinished) result = CsoundTable_Get(x->csound, tableNum, index, &val);
		
	pthread_mutex_unlock(&x->performMutex);
	
	switch(result)
	{
	case 0:
		x->atomList[1].a_w.w_float = (float) val;
		outlet_list(x->message_outlet, 0L, 2, x->atomList);
		break;
	case 1:
		error("csound~: \"rsidx\" failed because table #%d doesn't exist.", tableNum);
		break;
	case 2:
		//error("csound~: \"rsidx\" failed because index %d is out of bounds.", index);
		break;
	default:
		break;
	}
}

void csound_writeSampleIndex(t_csound *x, t_symbol *s, short argc, t_atom *argv)
{
	int tableNum, index, result = 0;
	float val;
	
	if(argc != 3 || argv[0].a_type != A_LONG || argv[1].a_type != A_LONG || argv[2].a_type != A_FLOAT) return;
	tableNum = argv[0].a_w.w_long;
	index = argv[1].a_w.w_long;
	val = argv[2].a_w.w_float;
	if(index < 0) return;
	
	pthread_mutex_lock(&x->performMutex);
	
		if(x->compiled && !x->performanceFinished) 
		{
			result = CsoundTable_Set(x->csound, tableNum, index, val);
		}
		
	pthread_mutex_unlock(&x->performMutex);
	
	switch(result)
	{
	case 1:
		error("csound~: \"wsidx\" failed because table #%d doesn't exist.", tableNum);
		break;
	case 2:
		//error("csound~: \"wsidx\" failed because index %d is out of bounds.", index);
		break;
	default:
		break;
	}
}


#ifdef MACOSX
void csound_run(t_csound *x, t_symbol *s, short argc, t_atom *argv)
{
	int i, result;
	char tmp[MAX_STRING_LENGTH];
	char *args[MAX_ARGS];
	
	if(argc >= MAX_ARGS)
	{
		error("csound~: Too many arguments for \"run\". MAX_ARGS = %d", MAX_ARGS);
		return;
	}

	for(i=0; i<argc; i++)
	{
		switch(argv[i].a_type)
		{
		case A_FLOAT:
			snprintf(tmp, MAX_STRING_LENGTH-1, "%d", argv[i].a_w.w_long);
			args[i] = strdup(tmp);
			break;
		case A_LONG:
			snprintf(tmp, MAX_STRING_LENGTH-1, "%f", argv[i].a_w.w_float);
			args[i] = strdup(tmp);
			break;
		case A_SYM:
			strncpy(tmp, argv[i].a_w.w_sym->s_name, MAX_STRING_LENGTH-1);
			if(isQuoted(tmp)) removeQuotes(tmp);
			if(isAbsoluteMaxPath(tmp)) convertMaxPathToPosixPath(tmp, tmp, MAX_STRING_LENGTH);
			args[i] = strdup(tmp);
			break;
		}
	}
	
	args[argc] = NULL;
	
	// Set the current directory again (in case it was changed).
	if(strlen(x->path)) change_directory(x->path);
	else if(strlen(x->defaultPath)) change_directory(x->defaultPath);

	result = csoundRunCommand((const char * const *)args, 1);
	if(result < 0) error("csound~: 'run' command error: %d", result);
	
	// Free the arguments.
	for(i=0; i<argc; i++) free(args[i]);
}
#endif

#ifdef WINXP
void csound_run(t_csound *x, t_symbol *s, short argc, t_atom *argv)
{
	int i, result;
	char tmp[MAX_STRING_LENGTH];
	char tmp2[MAX_STRING_LENGTH];
	char command[MAX_STRING_LENGTH];
	char args[MAX_STRING_LENGTH];
	args[0] = '\0';

	for(i=0; i<argc; i++)
	{
		switch(argv[i].a_type)
		{
		case A_FLOAT:
			snprintf(tmp, MAX_STRING_LENGTH-1, "%d", argv[i].a_w.w_long);
			break;
		case A_LONG:
			snprintf(tmp, MAX_STRING_LENGTH-1, "%f", argv[i].a_w.w_float);
			break;
		case A_SYM:
			strncpy(tmp, argv[i].a_w.w_sym->s_name, MAX_STRING_LENGTH-1);
			if(hasSpace(tmp)) 
			{
				addQuotes(tmp, tmp2);
				strcpy(tmp, tmp2);
			}
			break;
		}

		if(i==0) strcpy(command, tmp);
		else
		{
			if(i>1) strncat(args, " ", MAX_STRING_LENGTH-strlen(args)-1);
			strncat(args, tmp, MAX_STRING_LENGTH-strlen(args)-1);
		}
	}
	
	// Set the current directory again (in case it was changed).
	if(strlen(x->path)) change_directory(x->path);
	else if(strlen(x->defaultPath)) change_directory(x->defaultPath);

	ShellExecute(NULL, "open", command, args, NULL, SW_SHOWNORMAL);
}
#endif

void csound_setClockInterval(t_csound *x, long n)
{
	if(n > 0)
		x->maxClockInterval = (double) n;
	else
		error("csound~: output_interval must be > 0");

}