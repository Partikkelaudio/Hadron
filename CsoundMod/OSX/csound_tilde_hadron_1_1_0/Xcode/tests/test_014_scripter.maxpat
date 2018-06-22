{
	"patcher" : 	{
		"fileversion" : 1,
		"rect" : [ 90.0, 305.0, 1124.0, 564.0 ],
		"bglocked" : 0,
		"defrect" : [ 90.0, 305.0, 1124.0, 564.0 ],
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
					"maxclass" : "message",
					"text" : "parse tosub",
					"fontsize" : 12.0,
					"id" : "obj-25",
					"numinlets" : 2,
					"presentation_rect" : [ 607.0, 302.0, 0.0, 0.0 ],
					"numoutlets" : 1,
					"patching_rect" : [ 600.0, 300.0, 76.0, 18.0 ],
					"outlettype" : [ "" ],
					"fontname" : "Arial"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "script newobject newobj @text \"pattrforward csound~\"",
					"fontface" : 1,
					"fontsize" : 12.0,
					"id" : "obj-22",
					"numinlets" : 2,
					"presentation_rect" : [ 27.0, 218.0, 0.0, 0.0 ],
					"numoutlets" : 1,
					"patching_rect" : [ 45.0, 315.0, 325.0, 18.0 ],
					"outlettype" : [ "" ],
					"fontname" : "Arial",
					"bgcolor" : [ 1.0, 0.984314, 0.678431, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "pak adfafa 0.",
					"fontsize" : 12.0,
					"id" : "obj-52",
					"numinlets" : 2,
					"numoutlets" : 1,
					"patching_rect" : [ 930.0, 480.0, 80.0, 20.0 ],
					"outlettype" : [ "" ],
					"fontname" : "Arial"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "adfafa",
					"fontsize" : 12.0,
					"id" : "obj-51",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 930.0, 300.0, 56.0, 20.0 ],
					"fontname" : "Arial"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "parse",
					"fontsize" : 12.0,
					"id" : "obj-7",
					"numinlets" : 2,
					"numoutlets" : 1,
					"patching_rect" : [ 540.0, 300.0, 42.0, 18.0 ],
					"outlettype" : [ "" ],
					"fontname" : "Arial"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "csound~ test_014_scripter.csd",
					"fontsize" : 12.0,
					"id" : "obj-6",
					"numinlets" : 2,
					"numoutlets" : 6,
					"patching_rect" : [ 540.0, 330.0, 180.0, 20.0 ],
					"outlettype" : [ "signal", "signal", "list", "int", "bang", "bang" ],
					"fontname" : "Arial",
					"saved_object_attributes" : 					{
						"matchsr" : 1,
						"message" : 1,
						"bypass" : 0,
						"scale" : 1,
						"interval" : 10,
						"autostart" : 0,
						"input" : 0,
						"args" : "test_014_scripter.csd",
						"output" : 0,
						"overdrive" : 0
					}

				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "script newobject newobj @text \"p subpatch\"",
					"fontface" : 1,
					"fontsize" : 12.0,
					"id" : "obj-21",
					"numinlets" : 2,
					"numoutlets" : 1,
					"patching_rect" : [ 45.0, 360.0, 264.0, 18.0 ],
					"outlettype" : [ "" ],
					"fontname" : "Arial",
					"bgcolor" : [ 1.0, 0.984314, 0.678431, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "script newobject newobj @text \"pak amp 0.\"",
					"fontface" : 1,
					"fontsize" : 12.0,
					"id" : "obj-17",
					"numinlets" : 2,
					"numoutlets" : 1,
					"patching_rect" : [ 45.0, 390.0, 263.0, 18.0 ],
					"outlettype" : [ "" ],
					"fontname" : "Arial",
					"bgcolor" : [ 1.0, 0.984314, 0.678431, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "loadbang",
					"fontsize" : 12.0,
					"id" : "obj-4",
					"numinlets" : 1,
					"numoutlets" : 1,
					"patching_rect" : [ 600.0, 0.0, 62.0, 20.0 ],
					"outlettype" : [ "bang" ],
					"fontname" : "Arial"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "print",
					"fontsize" : 12.0,
					"id" : "obj-1",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 990.0, 165.0, 34.0, 20.0 ],
					"fontname" : "Arial"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "read object_descriptions.json",
					"fontsize" : 12.0,
					"id" : "obj-15",
					"numinlets" : 2,
					"numoutlets" : 1,
					"patching_rect" : [ 600.0, 30.0, 173.0, 18.0 ],
					"outlettype" : [ "" ],
					"fontname" : "Arial",
					"bgcolor" : [ 1.0, 1.0, 1.0, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "write object_descriptions.json",
					"fontsize" : 12.0,
					"id" : "obj-13",
					"numinlets" : 2,
					"numoutlets" : 1,
					"patching_rect" : [ 600.0, 60.0, 174.0, 18.0 ],
					"outlettype" : [ "" ],
					"fontname" : "Arial",
					"bgcolor" : [ 1.0, 1.0, 1.0, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "number",
					"fontsize" : 12.0,
					"id" : "obj-11",
					"numinlets" : 1,
					"minimum" : 1,
					"numoutlets" : 2,
					"maximum" : 3,
					"patching_rect" : [ 780.0, 30.0, 50.0, 20.0 ],
					"outlettype" : [ "int", "bang" ],
					"fontname" : "Arial"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "store 3",
					"fontsize" : 11.595187,
					"id" : "obj-5",
					"numinlets" : 2,
					"numoutlets" : 1,
					"patching_rect" : [ 930.0, 30.0, 44.0, 18.0 ],
					"outlettype" : [ "" ],
					"fontname" : "Arial",
					"bgcolor" : [ 1.0, 1.0, 1.0, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "slider",
					"varname" : "kittens",
					"knobcolor" : [ 0.0, 1.0, 0.0, 1.0 ],
					"size" : 3.0,
					"id" : "obj-77",
					"numinlets" : 1,
					"numoutlets" : 1,
					"min" : -1.0,
					"patching_rect" : [ 630.0, 480.0, 200.0, 50.0 ],
					"outlettype" : [ "" ],
					"floatoutput" : 1,
					"orientation" : 1,
					"bgcolor" : [ 0.0, 0.0, 0.4, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"varname" : "binds",
					"text" : "p binds",
					"fontsize" : 12.0,
					"id" : "obj-3",
					"numinlets" : 0,
					"numoutlets" : 1,
					"patching_rect" : [ 990.0, 135.0, 51.0, 20.0 ],
					"outlettype" : [ "" ],
					"fontname" : "Arial",
					"patcher" : 					{
						"fileversion" : 1,
						"rect" : [ 365.0, 401.0, 958.0, 259.0 ],
						"bglocked" : 0,
						"defrect" : [ 365.0, 401.0, 958.0, 259.0 ],
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
						"boxes" : [ 							{
								"box" : 								{
									"maxclass" : "number",
									"fontsize" : 12.0,
									"id" : "obj-6",
									"numinlets" : 1,
									"numoutlets" : 2,
									"patching_rect" : [ 30.0, 45.0, 50.0, 20.0 ],
									"outlettype" : [ "int", "bang" ],
									"fontname" : "Arial"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "pattrforward this",
									"fontsize" : 12.0,
									"id" : "obj-68",
									"numinlets" : 1,
									"numoutlets" : 1,
									"patching_rect" : [ 375.0, 30.0, 98.0, 20.0 ],
									"outlettype" : [ "" ],
									"fontname" : "Arial"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "script newobject newobj @text \"pattr _poodle @bindto parent::poodle @invisible 1 @autorestore 0\"",
									"fontface" : 1,
									"fontsize" : 12.0,
									"id" : "obj-69",
									"numinlets" : 2,
									"numoutlets" : 1,
									"patching_rect" : [ 375.0, 0.0, 573.0, 18.0 ],
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"bgcolor" : [ 1.0, 0.984314, 0.678431, 1.0 ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "this",
									"fontsize" : 12.0,
									"id" : "obj-64",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 870.0, 190.0, 35.0, 20.0 ],
									"fontname" : "Arial"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"varname" : "this",
									"text" : "thispatcher",
									"fontsize" : 12.0,
									"id" : "obj-9",
									"numinlets" : 1,
									"numoutlets" : 2,
									"patching_rect" : [ 870.0, 210.0, 69.0, 20.0 ],
									"outlettype" : [ "", "" ],
									"fontname" : "Arial",
									"save" : [ "#N", "thispatcher", ";", "#Q", "end", ";" ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "outlet",
									"id" : "obj-2",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 15.0, 225.0, 25.0, 25.0 ],
									"comment" : ""
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "prepend c",
									"fontsize" : 12.0,
									"id" : "obj-1",
									"numinlets" : 1,
									"numoutlets" : 1,
									"patching_rect" : [ 15.0, 195.0, 65.0, 20.0 ],
									"outlettype" : [ "" ],
									"fontname" : "Arial"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"varname" : "_kittens",
									"text" : "pattr _kittens @bindto parent::kittens @invisible 1 @autorestore 0",
									"fontsize" : 12.0,
									"id" : "obj-74",
									"numinlets" : 1,
									"numoutlets" : 3,
									"patching_rect" : [ 15.0, 135.0, 368.0, 20.0 ],
									"outlettype" : [ "", "", "" ],
									"fontname" : "Arial",
									"restore" : [ 0.0 ],
									"saved_object_attributes" : 									{
										"parameter_enable" : 0
									}

								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "pak kittens 0.",
									"fontsize" : 12.0,
									"id" : "obj-4",
									"numinlets" : 2,
									"numoutlets" : 1,
									"patching_rect" : [ 15.0, 165.0, 82.0, 20.0 ],
									"outlettype" : [ "" ],
									"fontname" : "Arial"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"varname" : "_poodle",
									"text" : "pattr _poodle @bindto parent::poodle @invisible 1 @autorestore 0",
									"fontsize" : 12.0,
									"id" : "obj-3",
									"numinlets" : 1,
									"numoutlets" : 3,
									"patching_rect" : [ 0.0, 0.0, 369.0, 20.0 ],
									"outlettype" : [ "", "", "" ],
									"fontname" : "Arial",
									"restore" : [ 0 ],
									"saved_object_attributes" : 									{
										"parameter_enable" : 0
									}

								}

							}
 ],
						"lines" : [ 							{
								"patchline" : 								{
									"source" : [ "obj-74", 0 ],
									"destination" : [ "obj-4", 1 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-1", 0 ],
									"destination" : [ "obj-2", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-4", 0 ],
									"destination" : [ "obj-1", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-69", 0 ],
									"destination" : [ "obj-68", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-3", 0 ],
									"destination" : [ "obj-6", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
 ]
					}
,
					"saved_object_attributes" : 					{
						"fontface" : 0,
						"fontsize" : 12.0,
						"default_fontface" : 0,
						"globalpatchername" : "",
						"default_fontname" : "Arial",
						"fontname" : "Arial",
						"default_fontsize" : 12.0
					}

				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "storagewindow",
					"fontsize" : 12.0,
					"id" : "obj-2",
					"numinlets" : 2,
					"numoutlets" : 1,
					"patching_rect" : [ 885.0, 60.0, 94.0, 18.0 ],
					"outlettype" : [ "" ],
					"fontname" : "Arial",
					"bgcolor" : [ 1.0, 1.0, 1.0, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "store 2",
					"fontsize" : 11.595187,
					"id" : "obj-39",
					"numinlets" : 2,
					"numoutlets" : 1,
					"patching_rect" : [ 885.0, 30.0, 44.0, 18.0 ],
					"outlettype" : [ "" ],
					"fontname" : "Arial",
					"bgcolor" : [ 1.0, 1.0, 1.0, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "store 1",
					"fontsize" : 11.595187,
					"id" : "obj-40",
					"numinlets" : 2,
					"numoutlets" : 1,
					"patching_rect" : [ 838.0, 30.0, 44.0, 18.0 ],
					"outlettype" : [ "" ],
					"fontname" : "Arial",
					"bgcolor" : [ 1.0, 1.0, 1.0, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"varname" : "u145000152",
					"text" : "autopattr",
					"fontsize" : 12.0,
					"id" : "obj-79",
					"numinlets" : 1,
					"numoutlets" : 4,
					"patching_rect" : [ 855.0, 135.0, 59.5, 20.0 ],
					"outlettype" : [ "", "", "", "" ],
					"fontname" : "Arial",
					"restore" : 					{
						"adfafa" : [ 0.0 ],
						"binds" : [ "object (jpatcher)" ],
						"kittens" : [ 0.0 ]
					}

				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"varname" : "u058000118",
					"text" : "pattrstorage",
					"fontsize" : 12.0,
					"id" : "obj-78",
					"numinlets" : 1,
					"numoutlets" : 1,
					"patching_rect" : [ 780.0, 135.0, 76.0, 20.0 ],
					"outlettype" : [ "" ],
					"fontname" : "Arial",
					"autorestore" : "object_descriptions.json",
					"saved_object_attributes" : 					{
						"storage_rect" : [ 200, 200, 800, 500 ],
						"client_rect" : [ 596, 107, 996, 607 ],
						"parameter_enable" : 0,
						"paraminitmode" : 0
					}

				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "script newobject newobj @text \"pak amp 0.\"",
					"fontface" : 1,
					"fontsize" : 12.0,
					"id" : "obj-69",
					"numinlets" : 2,
					"numoutlets" : 1,
					"patching_rect" : [ 45.0, 420.0, 263.0, 18.0 ],
					"outlettype" : [ "" ],
					"fontname" : "Arial",
					"bgcolor" : [ 1.0, 0.984314, 0.678431, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "this",
					"fontsize" : 12.0,
					"id" : "obj-64",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 960.0, 105.0, 29.0, 20.0 ],
					"fontname" : "Arial"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "pattrforward this",
					"fontsize" : 12.0,
					"id" : "obj-62",
					"numinlets" : 1,
					"numoutlets" : 1,
					"patching_rect" : [ 15.0, 525.0, 102.0, 20.0 ],
					"outlettype" : [ "" ],
					"fontname" : "Arial"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "script newobject umenu @items 1 \\, 2 @fontname consolas",
					"fontface" : 1,
					"fontsize" : 12.0,
					"id" : "obj-38",
					"numinlets" : 2,
					"numoutlets" : 1,
					"patching_rect" : [ 45.0, 450.0, 347.0, 18.0 ],
					"outlettype" : [ "" ],
					"fontname" : "Arial",
					"bgcolor" : [ 1.0, 0.984314, 0.678431, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "script newobject slider @varname kittens @patching_rect 200. 50. 200. 50. @orientation 1 @bgcolor 0. 0. 0.4 1. @knobcolor 0. 1. 0. 1. @floatoutput 1 @min -1. @size 3.",
					"linecount" : 2,
					"fontface" : 1,
					"fontsize" : 12.0,
					"id" : "obj-8",
					"numinlets" : 2,
					"numoutlets" : 1,
					"patching_rect" : [ 45.0, 480.0, 582.0, 32.0 ],
					"outlettype" : [ "" ],
					"fontname" : "Arial",
					"bgcolor" : [ 1.0, 0.984314, 0.678431, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"varname" : "this",
					"text" : "thispatcher",
					"fontsize" : 12.0,
					"id" : "obj-9",
					"numinlets" : 1,
					"numoutlets" : 2,
					"patching_rect" : [ 990.0, 105.0, 69.0, 20.0 ],
					"outlettype" : [ "", "" ],
					"fontname" : "Arial",
					"save" : [ "#N", "thispatcher", ";", "#Q", "end", ";" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "patcher examples",
					"fontsize" : 12.0,
					"id" : "obj-10",
					"numinlets" : 0,
					"numoutlets" : 0,
					"patching_rect" : [ 990.0, 75.0, 108.0, 20.0 ],
					"fontname" : "Arial",
					"patcher" : 					{
						"fileversion" : 1,
						"rect" : [ 247.0, 496.0, 525.0, 542.0 ],
						"bglocked" : 0,
						"defrect" : [ 247.0, 496.0, 525.0, 542.0 ],
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
						"boxes" : [ 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "script newobject message @text \"toto titi tutu\" @varname messy @textcolor 0.2 0.6 0.9 1. @fontface bold @fontsize 32 @patching_position 515 305",
									"linecount" : 2,
									"fontface" : 1,
									"fontsize" : 12.0,
									"id" : "obj-44",
									"numinlets" : 2,
									"numoutlets" : 1,
									"patching_rect" : [ 57.0, 191.0, 470.0, 32.0 ],
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"bgcolor" : [ 1.0, 0.984314, 0.678431, 1.0 ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "script newobject comment @text \"I'm on top of the world!\" @orderfront 1",
									"fontface" : 1,
									"fontsize" : 12.0,
									"id" : "obj-37",
									"numinlets" : 2,
									"numoutlets" : 1,
									"patching_rect" : [ 45.0, 149.0, 423.0, 18.0 ],
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"bgcolor" : [ 1.0, 0.984314, 0.678431, 1.0 ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "script newobject newobj @text \"trigger b b b\" @fixwidth 1",
									"fontface" : 1,
									"fontsize" : 12.0,
									"id" : "obj-33",
									"numinlets" : 2,
									"numoutlets" : 1,
									"patching_rect" : [ 36.0, 100.0, 337.0, 18.0 ],
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"bgcolor" : [ 1.0, 0.984314, 0.678431, 1.0 ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "script newobject ezdac~ @varname onoff @presentation 1 @presentation_position 400 300",
									"linecount" : 2,
									"fontface" : 1,
									"fontsize" : 12.0,
									"id" : "obj-19",
									"numinlets" : 2,
									"numoutlets" : 1,
									"patching_rect" : [ 94.0, 385.0, 289.0, 32.0 ],
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"bgcolor" : [ 1.0, 0.984314, 0.678431, 1.0 ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "script newobject newobj @text number @hidden 1",
									"fontface" : 1,
									"fontsize" : 12.0,
									"id" : "obj-22",
									"numinlets" : 2,
									"numoutlets" : 1,
									"patching_rect" : [ 104.0, 331.0, 294.0, 18.0 ],
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"bgcolor" : [ 1.0, 0.984314, 0.678431, 1.0 ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "script newobject number @hidden 1",
									"fontface" : 1,
									"fontsize" : 12.0,
									"id" : "obj-17",
									"numinlets" : 2,
									"numoutlets" : 1,
									"patching_rect" : [ 104.0, 301.0, 213.0, 18.0 ],
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"bgcolor" : [ 1.0, 0.984314, 0.678431, 1.0 ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "script newobject number @triangle 0",
									"fontface" : 1,
									"fontsize" : 12.0,
									"id" : "obj-6",
									"numinlets" : 2,
									"numoutlets" : 1,
									"patching_rect" : [ 70.0, 256.0, 218.0, 18.0 ],
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"bgcolor" : [ 1.0, 0.984314, 0.678431, 1.0 ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "script newobject newobj @text coll @fontsize 24",
									"fontface" : 1,
									"fontsize" : 12.0,
									"id" : "obj-7",
									"numinlets" : 2,
									"numoutlets" : 1,
									"patching_rect" : [ 16.0, 59.0, 284.0, 18.0 ],
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"bgcolor" : [ 1.0, 0.984314, 0.678431, 1.0 ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "script newobject coll",
									"fontface" : 1,
									"fontsize" : 12.0,
									"id" : "obj-8",
									"numinlets" : 2,
									"numoutlets" : 1,
									"patching_rect" : [ 0.0, 15.0, 126.0, 18.0 ],
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"bgcolor" : [ 1.0, 0.984314, 0.678431, 1.0 ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "thispatcher",
									"fontsize" : 12.0,
									"id" : "obj-9",
									"numinlets" : 1,
									"numoutlets" : 2,
									"patching_rect" : [ 0.0, 460.0, 69.0, 20.0 ],
									"outlettype" : [ "", "" ],
									"fontname" : "Arial",
									"save" : [ "#N", "thispatcher", ";", "#Q", "end", ";" ]
								}

							}
 ],
						"lines" : [ 							{
								"patchline" : 								{
									"source" : [ "obj-44", 0 ],
									"destination" : [ "obj-9", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-37", 0 ],
									"destination" : [ "obj-9", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-33", 0 ],
									"destination" : [ "obj-9", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-19", 0 ],
									"destination" : [ "obj-9", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-8", 0 ],
									"destination" : [ "obj-9", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-7", 0 ],
									"destination" : [ "obj-9", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-6", 0 ],
									"destination" : [ "obj-9", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-17", 0 ],
									"destination" : [ "obj-9", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-22", 0 ],
									"destination" : [ "obj-9", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
 ]
					}
,
					"saved_object_attributes" : 					{
						"fontface" : 0,
						"fontsize" : 12.0,
						"default_fontface" : 0,
						"globalpatchername" : "",
						"default_fontname" : "Arial",
						"fontname" : "Arial",
						"default_fontsize" : 12.0
					}

				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "load objects.maxpat",
					"fontsize" : 12.0,
					"id" : "obj-14",
					"numinlets" : 2,
					"numoutlets" : 1,
					"patching_rect" : [ 990.0, 15.0, 120.0, 18.0 ],
					"outlettype" : [ "" ],
					"fontname" : "Arial",
					"bgcolor" : [ 1.0, 1.0, 1.0, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "pcontrol",
					"fontsize" : 12.0,
					"id" : "obj-12",
					"numinlets" : 1,
					"numoutlets" : 1,
					"patching_rect" : [ 990.0, 45.0, 54.0, 20.0 ],
					"outlettype" : [ "" ],
					"fontname" : "Arial"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "umenu",
					"types" : [  ],
					"fontsize" : 12.0,
					"id" : "obj-73",
					"numinlets" : 1,
					"numoutlets" : 3,
					"patching_rect" : [ 405.0, 450.0, 100.0, 21.0 ],
					"outlettype" : [ "int", "", "" ],
					"fontname" : "consolas",
					"items" : [ 1, ",", 2 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "pak amp 0.",
					"fontsize" : 12.0,
					"id" : "obj-18",
					"numinlets" : 2,
					"numoutlets" : 1,
					"patching_rect" : [ 315.0, 420.0, 100.0, 20.0 ],
					"outlettype" : [ "" ],
					"fontname" : "Arial"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "pak amp 0.",
					"fontsize" : 12.0,
					"id" : "obj-19",
					"numinlets" : 2,
					"numoutlets" : 1,
					"patching_rect" : [ 315.0, 390.0, 100.0, 20.0 ],
					"outlettype" : [ "" ],
					"fontname" : "Arial"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "p subpatch",
					"fontsize" : 12.0,
					"id" : "obj-23",
					"numinlets" : 0,
					"numoutlets" : 0,
					"patching_rect" : [ 315.0, 360.0, 150.0, 20.0 ],
					"fontname" : "Arial",
					"patcher" : 					{
						"fileversion" : 1,
						"rect" : [ 95.0, 75.0, 640.0, 480.0 ],
						"bglocked" : 0,
						"defrect" : [ 95.0, 75.0, 640.0, 480.0 ],
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
						"boxes" : [  ],
						"lines" : [  ]
					}
,
					"saved_object_attributes" : 					{
						"fontface" : 0,
						"fontsize" : 12.0,
						"default_fontface" : 0,
						"globalpatchername" : "",
						"default_fontname" : "Arial",
						"fontname" : "Arial",
						"default_fontsize" : 12.0
					}

				}

			}
, 			{
				"box" : 				{
					"maxclass" : "slider",
					"varname" : "adfafa",
					"size" : 3.0,
					"id" : "obj-36",
					"numinlets" : 1,
					"numoutlets" : 1,
					"min" : -1.0,
					"patching_rect" : [ 930.0, 330.0, 20.0, 140.0 ],
					"outlettype" : [ "" ],
					"floatoutput" : 1
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"source" : [ "obj-25", 0 ],
					"destination" : [ "obj-6", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-22", 0 ],
					"destination" : [ "obj-62", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-21", 0 ],
					"destination" : [ "obj-62", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-17", 0 ],
					"destination" : [ "obj-62", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-69", 0 ],
					"destination" : [ "obj-62", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-38", 0 ],
					"destination" : [ "obj-62", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-4", 0 ],
					"destination" : [ "obj-15", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-8", 0 ],
					"destination" : [ "obj-62", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-14", 0 ],
					"destination" : [ "obj-12", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-40", 0 ],
					"destination" : [ "obj-78", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-39", 0 ],
					"destination" : [ "obj-78", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-2", 0 ],
					"destination" : [ "obj-78", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-5", 0 ],
					"destination" : [ "obj-78", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-11", 0 ],
					"destination" : [ "obj-78", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-13", 0 ],
					"destination" : [ "obj-78", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-15", 0 ],
					"destination" : [ "obj-78", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-3", 0 ],
					"destination" : [ "obj-1", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-7", 0 ],
					"destination" : [ "obj-6", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-36", 0 ],
					"destination" : [ "obj-52", 1 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
 ],
		"parameters" : 		{

		}

	}

}
