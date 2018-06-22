{
	"patcher" : 	{
		"fileversion" : 1,
		"rect" : [ 453.0, 306.0, 978.0, 476.0 ],
		"bglocked" : 0,
		"defrect" : [ 453.0, 306.0, 978.0, 476.0 ],
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
					"text" : "script newobject newobj @text \"p subpatch\"",
					"outlettype" : [ "" ],
					"id" : "obj-21",
					"fontface" : 1,
					"fontsize" : 12.0,
					"bgcolor" : [ 1.0, 0.984314, 0.678431, 1.0 ],
					"patching_rect" : [ 30.0, 270.0, 264.0, 18.0 ],
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontname" : "Arial"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "script newobject newobj @text \"pak amp 0.\"",
					"outlettype" : [ "" ],
					"id" : "obj-17",
					"fontface" : 1,
					"fontsize" : 12.0,
					"bgcolor" : [ 1.0, 0.984314, 0.678431, 1.0 ],
					"patching_rect" : [ 30.0, 300.0, 263.0, 18.0 ],
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontname" : "Arial"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "loadbang",
					"outlettype" : [ "bang" ],
					"id" : "obj-4",
					"fontsize" : 12.0,
					"patching_rect" : [ 450.0, 0.0, 62.0, 20.0 ],
					"numinlets" : 1,
					"numoutlets" : 1,
					"fontname" : "Arial"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "print",
					"id" : "obj-1",
					"fontsize" : 12.0,
					"patching_rect" : [ 840.0, 165.0, 34.0, 20.0 ],
					"numinlets" : 1,
					"numoutlets" : 0,
					"fontname" : "Arial"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "read object_descriptions.json",
					"outlettype" : [ "" ],
					"id" : "obj-15",
					"fontsize" : 12.0,
					"bgcolor" : [ 1.0, 1.0, 1.0, 1.0 ],
					"patching_rect" : [ 450.0, 30.0, 173.0, 18.0 ],
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontname" : "Arial"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "write object_descriptions.json",
					"outlettype" : [ "" ],
					"id" : "obj-13",
					"fontsize" : 12.0,
					"bgcolor" : [ 1.0, 1.0, 1.0, 1.0 ],
					"patching_rect" : [ 450.0, 60.0, 174.0, 18.0 ],
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontname" : "Arial"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "number",
					"outlettype" : [ "int", "bang" ],
					"id" : "obj-11",
					"fontsize" : 12.0,
					"minimum" : 1,
					"patching_rect" : [ 630.0, 30.0, 50.0, 20.0 ],
					"maximum" : 3,
					"numinlets" : 1,
					"numoutlets" : 2,
					"fontname" : "Arial"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "store 3",
					"outlettype" : [ "" ],
					"id" : "obj-5",
					"fontsize" : 11.595187,
					"bgcolor" : [ 1.0, 1.0, 1.0, 1.0 ],
					"patching_rect" : [ 780.0, 30.0, 44.0, 18.0 ],
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontname" : "Arial"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "slider",
					"varname" : "kittens",
					"outlettype" : [ "" ],
					"id" : "obj-77",
					"size" : 3.0,
					"floatoutput" : 1,
					"bgcolor" : [ 0.0, 0.0, 0.4, 1.0 ],
					"patching_rect" : [ 615.0, 390.0, 200.0, 50.0 ],
					"min" : -1.0,
					"numinlets" : 1,
					"orientation" : 1,
					"numoutlets" : 1,
					"knobcolor" : [ 0.0, 1.0, 0.0, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"varname" : "binds",
					"text" : "p binds",
					"outlettype" : [ "" ],
					"id" : "obj-3",
					"fontsize" : 12.0,
					"patching_rect" : [ 840.0, 135.0, 51.0, 20.0 ],
					"numinlets" : 0,
					"numoutlets" : 1,
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
									"outlettype" : [ "int", "bang" ],
									"id" : "obj-6",
									"fontsize" : 12.0,
									"patching_rect" : [ 30.0, 45.0, 50.0, 20.0 ],
									"numinlets" : 1,
									"numoutlets" : 2,
									"fontname" : "Arial"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "pattrforward this",
									"outlettype" : [ "" ],
									"id" : "obj-68",
									"fontsize" : 12.0,
									"patching_rect" : [ 375.0, 30.0, 98.0, 20.0 ],
									"numinlets" : 1,
									"numoutlets" : 1,
									"fontname" : "Arial"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "script newobject newobj @text \"pattr _poodle @bindto parent::poodle @invisible 1 @autorestore 0\"",
									"outlettype" : [ "" ],
									"id" : "obj-69",
									"fontface" : 1,
									"fontsize" : 12.0,
									"bgcolor" : [ 1.0, 0.984314, 0.678431, 1.0 ],
									"patching_rect" : [ 375.0, 0.0, 573.0, 18.0 ],
									"numinlets" : 2,
									"numoutlets" : 1,
									"fontname" : "Arial"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "this",
									"id" : "obj-64",
									"fontsize" : 12.0,
									"patching_rect" : [ 870.0, 190.0, 35.0, 20.0 ],
									"numinlets" : 1,
									"numoutlets" : 0,
									"fontname" : "Arial"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"varname" : "this",
									"text" : "thispatcher",
									"outlettype" : [ "", "" ],
									"id" : "obj-9",
									"fontsize" : 12.0,
									"patching_rect" : [ 870.0, 210.0, 69.0, 20.0 ],
									"numinlets" : 1,
									"numoutlets" : 2,
									"fontname" : "Arial",
									"save" : [ "#N", "thispatcher", ";", "#Q", "end", ";" ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "outlet",
									"id" : "obj-2",
									"patching_rect" : [ 15.0, 225.0, 25.0, 25.0 ],
									"numinlets" : 1,
									"numoutlets" : 0,
									"comment" : ""
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "prepend c",
									"outlettype" : [ "" ],
									"id" : "obj-1",
									"fontsize" : 12.0,
									"patching_rect" : [ 15.0, 195.0, 65.0, 20.0 ],
									"numinlets" : 1,
									"numoutlets" : 1,
									"fontname" : "Arial"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"varname" : "_kittens",
									"text" : "pattr _kittens @bindto parent::kittens @invisible 1 @autorestore 0",
									"outlettype" : [ "", "", "" ],
									"id" : "obj-74",
									"fontsize" : 12.0,
									"patching_rect" : [ 15.0, 135.0, 368.0, 20.0 ],
									"numinlets" : 1,
									"numoutlets" : 3,
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
									"outlettype" : [ "" ],
									"id" : "obj-4",
									"fontsize" : 12.0,
									"patching_rect" : [ 15.0, 165.0, 82.0, 20.0 ],
									"numinlets" : 2,
									"numoutlets" : 1,
									"fontname" : "Arial"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"varname" : "_poodle",
									"text" : "pattr _poodle @bindto parent::poodle @invisible 1 @autorestore 0",
									"outlettype" : [ "", "", "" ],
									"id" : "obj-3",
									"fontsize" : 12.0,
									"patching_rect" : [ 0.0, 0.0, 369.0, 20.0 ],
									"numinlets" : 1,
									"numoutlets" : 3,
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
						"globalpatchername" : "",
						"default_fontface" : 0,
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
					"outlettype" : [ "" ],
					"id" : "obj-2",
					"fontsize" : 12.0,
					"bgcolor" : [ 1.0, 1.0, 1.0, 1.0 ],
					"patching_rect" : [ 735.0, 60.0, 94.0, 18.0 ],
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontname" : "Arial"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "store 2",
					"outlettype" : [ "" ],
					"id" : "obj-39",
					"fontsize" : 11.595187,
					"bgcolor" : [ 1.0, 1.0, 1.0, 1.0 ],
					"patching_rect" : [ 735.0, 30.0, 44.0, 18.0 ],
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontname" : "Arial"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "store 1",
					"outlettype" : [ "" ],
					"id" : "obj-40",
					"fontsize" : 11.595187,
					"bgcolor" : [ 1.0, 1.0, 1.0, 1.0 ],
					"patching_rect" : [ 688.0, 30.0, 44.0, 18.0 ],
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontname" : "Arial"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"varname" : "u431000131",
					"text" : "autopattr",
					"outlettype" : [ "", "", "", "" ],
					"id" : "obj-79",
					"fontsize" : 12.0,
					"patching_rect" : [ 705.0, 135.0, 59.5, 20.0 ],
					"numinlets" : 1,
					"numoutlets" : 4,
					"fontname" : "Arial",
					"restore" : 					{
						"binds" : [ "object (jpatcher)" ],
						"kittens" : [ 0.0 ]
					}

				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"varname" : "u130000123",
					"text" : "pattrstorage",
					"outlettype" : [ "" ],
					"id" : "obj-78",
					"fontsize" : 12.0,
					"patching_rect" : [ 630.0, 135.0, 76.0, 20.0 ],
					"numinlets" : 1,
					"numoutlets" : 1,
					"fontname" : "Arial",
					"autorestore" : "object_descriptions.json",
					"saved_object_attributes" : 					{
						"client_rect" : [ 596, 107, 996, 607 ],
						"paraminitmode" : 0,
						"storage_rect" : [ 200, 200, 800, 500 ],
						"parameter_enable" : 0
					}

				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "script newobject newobj @text \"pak amp 0.\"",
					"outlettype" : [ "" ],
					"id" : "obj-69",
					"fontface" : 1,
					"fontsize" : 12.0,
					"bgcolor" : [ 1.0, 0.984314, 0.678431, 1.0 ],
					"patching_rect" : [ 30.0, 330.0, 263.0, 18.0 ],
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontname" : "Arial"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "this",
					"id" : "obj-64",
					"fontsize" : 12.0,
					"patching_rect" : [ 810.0, 105.0, 29.0, 20.0 ],
					"numinlets" : 1,
					"numoutlets" : 0,
					"fontname" : "Arial"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "pattrforward this",
					"outlettype" : [ "" ],
					"id" : "obj-62",
					"fontsize" : 12.0,
					"patching_rect" : [ 0.0, 435.0, 98.0, 20.0 ],
					"numinlets" : 1,
					"numoutlets" : 1,
					"fontname" : "Arial"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "script newobject umenu @items 1 \\, 2 @fontname consolas",
					"outlettype" : [ "" ],
					"id" : "obj-38",
					"fontface" : 1,
					"fontsize" : 12.0,
					"bgcolor" : [ 1.0, 0.984314, 0.678431, 1.0 ],
					"patching_rect" : [ 30.0, 360.0, 347.0, 18.0 ],
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontname" : "Arial"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "script newobject slider @varname kittens @patching_rect 200. 50. 200. 50. @orientation 1 @bgcolor 0. 0. 0.4 1. @knobcolor 0. 1. 0. 1. @floatoutput 1 @min -1. @size 3.",
					"linecount" : 2,
					"outlettype" : [ "" ],
					"id" : "obj-8",
					"fontface" : 1,
					"fontsize" : 12.0,
					"bgcolor" : [ 1.0, 0.984314, 0.678431, 1.0 ],
					"patching_rect" : [ 30.0, 390.0, 582.0, 32.0 ],
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontname" : "Arial"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"varname" : "this",
					"text" : "thispatcher",
					"outlettype" : [ "", "" ],
					"id" : "obj-9",
					"fontsize" : 12.0,
					"patching_rect" : [ 840.0, 105.0, 69.0, 20.0 ],
					"numinlets" : 1,
					"numoutlets" : 2,
					"fontname" : "Arial",
					"save" : [ "#N", "thispatcher", ";", "#Q", "end", ";" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "patcher examples",
					"id" : "obj-10",
					"fontsize" : 12.0,
					"patching_rect" : [ 840.0, 75.0, 108.0, 20.0 ],
					"numinlets" : 0,
					"numoutlets" : 0,
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
									"outlettype" : [ "" ],
									"id" : "obj-44",
									"fontface" : 1,
									"fontsize" : 12.0,
									"bgcolor" : [ 1.0, 0.984314, 0.678431, 1.0 ],
									"patching_rect" : [ 57.0, 191.0, 470.0, 32.0 ],
									"numinlets" : 2,
									"numoutlets" : 1,
									"fontname" : "Arial"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "script newobject comment @text \"I'm on top of the world!\" @orderfront 1",
									"outlettype" : [ "" ],
									"id" : "obj-37",
									"fontface" : 1,
									"fontsize" : 12.0,
									"bgcolor" : [ 1.0, 0.984314, 0.678431, 1.0 ],
									"patching_rect" : [ 45.0, 149.0, 423.0, 18.0 ],
									"numinlets" : 2,
									"numoutlets" : 1,
									"fontname" : "Arial"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "script newobject newobj @text \"trigger b b b\" @fixwidth 1",
									"outlettype" : [ "" ],
									"id" : "obj-33",
									"fontface" : 1,
									"fontsize" : 12.0,
									"bgcolor" : [ 1.0, 0.984314, 0.678431, 1.0 ],
									"patching_rect" : [ 36.0, 100.0, 337.0, 18.0 ],
									"numinlets" : 2,
									"numoutlets" : 1,
									"fontname" : "Arial"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "script newobject ezdac~ @varname onoff @presentation 1 @presentation_position 400 300",
									"linecount" : 2,
									"outlettype" : [ "" ],
									"id" : "obj-19",
									"fontface" : 1,
									"fontsize" : 12.0,
									"bgcolor" : [ 1.0, 0.984314, 0.678431, 1.0 ],
									"patching_rect" : [ 94.0, 385.0, 289.0, 32.0 ],
									"numinlets" : 2,
									"numoutlets" : 1,
									"fontname" : "Arial"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "script newobject newobj @text number @hidden 1",
									"outlettype" : [ "" ],
									"id" : "obj-22",
									"fontface" : 1,
									"fontsize" : 12.0,
									"bgcolor" : [ 1.0, 0.984314, 0.678431, 1.0 ],
									"patching_rect" : [ 104.0, 331.0, 294.0, 18.0 ],
									"numinlets" : 2,
									"numoutlets" : 1,
									"fontname" : "Arial"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "script newobject number @hidden 1",
									"outlettype" : [ "" ],
									"id" : "obj-17",
									"fontface" : 1,
									"fontsize" : 12.0,
									"bgcolor" : [ 1.0, 0.984314, 0.678431, 1.0 ],
									"patching_rect" : [ 104.0, 301.0, 213.0, 18.0 ],
									"numinlets" : 2,
									"numoutlets" : 1,
									"fontname" : "Arial"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "script newobject number @triangle 0",
									"outlettype" : [ "" ],
									"id" : "obj-6",
									"fontface" : 1,
									"fontsize" : 12.0,
									"bgcolor" : [ 1.0, 0.984314, 0.678431, 1.0 ],
									"patching_rect" : [ 70.0, 256.0, 218.0, 18.0 ],
									"numinlets" : 2,
									"numoutlets" : 1,
									"fontname" : "Arial"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "script newobject newobj @text coll @fontsize 24",
									"outlettype" : [ "" ],
									"id" : "obj-7",
									"fontface" : 1,
									"fontsize" : 12.0,
									"bgcolor" : [ 1.0, 0.984314, 0.678431, 1.0 ],
									"patching_rect" : [ 16.0, 59.0, 284.0, 18.0 ],
									"numinlets" : 2,
									"numoutlets" : 1,
									"fontname" : "Arial"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "script newobject coll",
									"outlettype" : [ "" ],
									"id" : "obj-8",
									"fontface" : 1,
									"fontsize" : 12.0,
									"bgcolor" : [ 1.0, 0.984314, 0.678431, 1.0 ],
									"patching_rect" : [ 0.0, 15.0, 126.0, 18.0 ],
									"numinlets" : 2,
									"numoutlets" : 1,
									"fontname" : "Arial"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "thispatcher",
									"outlettype" : [ "", "" ],
									"id" : "obj-9",
									"fontsize" : 12.0,
									"patching_rect" : [ 0.0, 460.0, 69.0, 20.0 ],
									"numinlets" : 1,
									"numoutlets" : 2,
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
						"globalpatchername" : "",
						"default_fontface" : 0,
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
					"outlettype" : [ "" ],
					"id" : "obj-14",
					"fontsize" : 12.0,
					"bgcolor" : [ 1.0, 1.0, 1.0, 1.0 ],
					"patching_rect" : [ 840.0, 15.0, 120.0, 18.0 ],
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontname" : "Arial"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "pcontrol",
					"outlettype" : [ "" ],
					"id" : "obj-12",
					"fontsize" : 12.0,
					"patching_rect" : [ 840.0, 45.0, 54.0, 20.0 ],
					"numinlets" : 1,
					"numoutlets" : 1,
					"fontname" : "Arial"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "umenu",
					"outlettype" : [ "int", "", "" ],
					"id" : "obj-73",
					"fontsize" : 12.0,
					"patching_rect" : [ 390.0, 360.0, 100.0, 21.0 ],
					"numinlets" : 1,
					"items" : [ 1, ",", 2 ],
					"numoutlets" : 3,
					"fontname" : "consolas",
					"types" : [  ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "pak amp 0.",
					"outlettype" : [ "" ],
					"id" : "obj-18",
					"fontsize" : 12.0,
					"patching_rect" : [ 300.0, 330.0, 100.0, 20.0 ],
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontname" : "Arial"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "pak amp 0.",
					"outlettype" : [ "" ],
					"id" : "obj-19",
					"fontsize" : 12.0,
					"patching_rect" : [ 300.0, 300.0, 100.0, 20.0 ],
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontname" : "Arial"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "p subpatch",
					"id" : "obj-23",
					"fontsize" : 12.0,
					"patching_rect" : [ 300.0, 270.0, 100.0, 20.0 ],
					"numinlets" : 0,
					"numoutlets" : 0,
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
						"globalpatchername" : "",
						"default_fontface" : 0,
						"default_fontname" : "Arial",
						"fontname" : "Arial",
						"default_fontsize" : 12.0
					}

				}

			}
 ],
		"lines" : [ 			{
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
 ],
		"parameters" : 		{

		}

	}

}
