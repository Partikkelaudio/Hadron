{
	"patcher" : 	{
		"fileversion" : 1,
		"rect" : [ 95.0, 75.0, 878.0, 384.0 ],
		"bglocked" : 0,
		"defrect" : [ 95.0, 75.0, 878.0, 384.0 ],
		"openrect" : [ 0.0, 0.0, 0.0, 0.0 ],
		"openinpresentation" : 0,
		"default_fontsize" : 12.0,
		"default_fontface" : 0,
		"default_fontname" : "Arial",
		"gridonopen" : 0,
		"gridsize" : [ 15.0, 15.0 ],
		"gridsnaponopen" : 0,
		"toolbarvisible" : 1,
		"boxanimatetime" : 200,
		"imprint" : 0,
		"enablehscroll" : 1,
		"enablevscroll" : 1,
		"devicewidth" : 0.0,
		"boxes" : [ 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "You can use either Max style or POSIX style paths.",
					"patching_rect" : [ 405.0, 335.0, 355.0, 20.0 ],
					"numinlets" : 1,
					"fontname" : "Arial",
					"numoutlets" : 0,
					"id" : "obj-1",
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "If a path contains spaces, put double-quotes around it.",
					"patching_rect" : [ 553.0, 155.0, 305.0, 20.0 ],
					"numinlets" : 1,
					"fontname" : "Arial",
					"numoutlets" : 0,
					"id" : "obj-20",
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "In Mac OSX, many apps are actually folders.  To get the actual binary executable, right click the app in Finder, select \"Show Package Contents\", navigate to Contents/MacOS/, the name of the executable will be there.  Right-click on it, select \"Get Info\".  The absolute path to the folder containing the executable is under the \"Where\" section.  ",
					"linecount" : 6,
					"patching_rect" : [ 405.0, 240.0, 370.0, 89.0 ],
					"numinlets" : 1,
					"fontname" : "Arial",
					"numoutlets" : 0,
					"id" : "obj-19",
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "If a command is not in your PATH environment variable, you must specify an absolute path.  ",
					"linecount" : 2,
					"patching_rect" : [ 405.0, 195.0, 355.0, 34.0 ],
					"numinlets" : 1,
					"fontname" : "Arial",
					"numoutlets" : 0,
					"id" : "obj-17",
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "Relative paths are relative to the folder containing the patch that contains [csound~].",
					"linecount" : 3,
					"patching_rect" : [ 165.0, 315.0, 204.0, 48.0 ],
					"numinlets" : 1,
					"fontname" : "Arial",
					"numoutlets" : 0,
					"id" : "obj-16",
					"fontface" : 3,
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "You can also use relative paths:",
					"patching_rect" : [ 165.0, 195.0, 204.0, 20.0 ],
					"numinlets" : 1,
					"fontname" : "Arial",
					"numoutlets" : 0,
					"id" : "obj-15",
					"fontface" : 3,
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "edit hello.csd",
					"patching_rect" : [ 210.0, 225.0, 81.0, 18.0 ],
					"numinlets" : 2,
					"fontname" : "Arial",
					"numoutlets" : 1,
					"bgcolor" : [ 0.92549, 0.92549, 0.92549, 1.0 ],
					"id" : "obj-13",
					"outlettype" : [ "" ],
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "edit sub/hello.csd",
					"patching_rect" : [ 210.0, 285.0, 105.0, 18.0 ],
					"numinlets" : 2,
					"fontname" : "Arial",
					"numoutlets" : 1,
					"bgcolor" : [ 0.92549, 0.92549, 0.92549, 1.0 ],
					"id" : "obj-12",
					"outlettype" : [ "" ],
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "edit ../hello.csd",
					"patching_rect" : [ 210.0, 255.0, 91.0, 18.0 ],
					"numinlets" : 2,
					"fontname" : "Arial",
					"numoutlets" : 1,
					"bgcolor" : [ 0.92549, 0.92549, 0.92549, 1.0 ],
					"id" : "obj-11",
					"outlettype" : [ "" ],
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "csound~ 1.0.6 or later required.",
					"patching_rect" : [ 542.0, 109.0, 215.0, 20.0 ],
					"numinlets" : 1,
					"fontname" : "Arial",
					"numoutlets" : 0,
					"frgb" : [ 0.65098, 0.0, 0.019608, 1.0 ],
					"id" : "obj-9",
					"textcolor" : [ 0.65098, 0.0, 0.019608, 1.0 ],
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "The \"run\" message allows you to execute commands.",
					"patching_rect" : [ 542.0, 130.0, 302.0, 20.0 ],
					"numinlets" : 1,
					"fontname" : "Arial",
					"numoutlets" : 0,
					"id" : "obj-10",
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "run",
					"patching_rect" : [ 542.0, 60.0, 68.0, 48.0 ],
					"numinlets" : 1,
					"fontname" : "Arial",
					"numoutlets" : 0,
					"frgb" : [ 0.337255, 0.254902, 0.113725, 1.0 ],
					"id" : "obj-33",
					"textcolor" : [ 0.337255, 0.254902, 0.113725, 1.0 ],
					"fontsize" : 36.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "panel",
					"patching_rect" : [ 536.0, 55.0, 310.0, 101.0 ],
					"numinlets" : 1,
					"rounded" : 0,
					"numoutlets" : 0,
					"bgcolor" : [ 0.952941, 0.933333, 0.917647, 1.0 ],
					"id" : "obj-106"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "csound~",
					"patching_rect" : [ 30.0, 285.0, 86.5, 20.0 ],
					"numinlets" : 2,
					"fontname" : "Arial",
					"numoutlets" : 6,
					"id" : "obj-8",
					"outlettype" : [ "signal", "signal", "list", "int", "bang", "bang" ],
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "\"/Users/davis/Applications/Audacity 1.3.7.1/Audacity.app/Contents/MacOS/Audacity\" /Users/davis/Music/Csound/berg.wav",
					"linecount" : 2,
					"patching_rect" : [ 90.0, 150.0, 462.0, 32.0 ],
					"numinlets" : 2,
					"fontname" : "Arial",
					"numoutlets" : 1,
					"bgcolor" : [ 0.92549, 0.92549, 0.92549, 1.0 ],
					"id" : "obj-7",
					"outlettype" : [ "" ],
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "pvanal -n256 -w4 mono.aif mono.pvx",
					"patching_rect" : [ 75.0, 120.0, 208.0, 18.0 ],
					"numinlets" : 2,
					"fontname" : "Arial",
					"numoutlets" : 1,
					"bgcolor" : [ 0.92549, 0.92549, 0.92549, 1.0 ],
					"id" : "obj-6",
					"outlettype" : [ "" ],
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "/Applications/TextEdit.app/Contents/MacOS/TextEdit readbuf.csd",
					"patching_rect" : [ 45.0, 60.0, 357.0, 18.0 ],
					"numinlets" : 2,
					"fontname" : "Arial",
					"numoutlets" : 1,
					"bgcolor" : [ 0.92549, 0.92549, 0.92549, 1.0 ],
					"id" : "obj-5",
					"outlettype" : [ "" ],
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "/Applications/Utilities/Terminal.app/Contents/MacOS/Terminal",
					"patching_rect" : [ 60.0, 90.0, 345.0, 18.0 ],
					"numinlets" : 2,
					"fontname" : "Arial",
					"numoutlets" : 1,
					"bgcolor" : [ 0.92549, 0.92549, 0.92549, 1.0 ],
					"id" : "obj-4",
					"outlettype" : [ "" ],
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "\"C:/Program Files/Audacity 1.3 Beta (Unicode)/Audacity.exe\" \"H:/samples/01 Bipolar 175bpm Ebmin/kick01.wav\"",
					"patching_rect" : [ 30.0, 30.0, 651.0, 18.0 ],
					"numinlets" : 2,
					"fontname" : "Arial",
					"numoutlets" : 1,
					"bgcolor" : [ 0.92549, 0.92549, 0.92549, 1.0 ],
					"id" : "obj-2",
					"outlettype" : [ "" ],
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "prepend run",
					"patching_rect" : [ 30.0, 255.0, 75.0, 20.0 ],
					"numinlets" : 1,
					"fontname" : "Arial",
					"numoutlets" : 1,
					"id" : "obj-112",
					"outlettype" : [ "" ],
					"fontsize" : 12.0
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"source" : [ "obj-112", 0 ],
					"destination" : [ "obj-8", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-6", 0 ],
					"destination" : [ "obj-112", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-5", 0 ],
					"destination" : [ "obj-112", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-4", 0 ],
					"destination" : [ "obj-112", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-2", 0 ],
					"destination" : [ "obj-112", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-7", 0 ],
					"destination" : [ "obj-112", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
 ]
	}

}
