{
	"patcher" : 	{
		"fileversion" : 1,
		"rect" : [ 275.0, 64.0, 821.0, 658.0 ],
		"bglocked" : 0,
		"defrect" : [ 275.0, 64.0, 821.0, 658.0 ],
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
					"maxclass" : "newobj",
					"text" : "pattrforward csIN",
					"id" : "obj-151",
					"fontsize" : 12.0,
					"patching_rect" : [ 90.0, 540.0, 103.0, 20.0 ],
					"numinlets" : 1,
					"numoutlets" : 1,
					"fontname" : "Arial",
					"outlettype" : [ "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "toggle",
					"id" : "obj-150",
					"patching_rect" : [ 180.0, 465.0, 20.0, 20.0 ],
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "int" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "toggle",
					"id" : "obj-149",
					"patching_rect" : [ 90.0, 465.0, 20.0, 20.0 ],
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "int" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "overdrive $1",
					"id" : "obj-147",
					"fontsize" : 12.0,
					"patching_rect" : [ 180.0, 495.0, 76.0, 18.0 ],
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontname" : "Arial",
					"outlettype" : [ "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "output $1",
					"id" : "obj-146",
					"fontsize" : 12.0,
					"patching_rect" : [ 90.0, 495.0, 61.0, 18.0 ],
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontname" : "Arial",
					"outlettype" : [ "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "button",
					"id" : "obj-138",
					"patching_rect" : [ 345.0, 428.0, 15.0, 15.0 ],
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "p shift down",
					"id" : "obj-139",
					"fontsize" : 12.0,
					"patching_rect" : [ 360.0, 428.0, 84.0, 20.0 ],
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontname" : "Arial",
					"outlettype" : [ "" ],
					"patcher" : 					{
						"fileversion" : 1,
						"rect" : [ 10.0, 59.0, 467.0, 286.0 ],
						"bglocked" : 0,
						"defrect" : [ 10.0, 59.0, 467.0, 286.0 ],
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
									"maxclass" : "comment",
									"text" : "Bang me to shift list up.",
									"id" : "obj-1",
									"fontsize" : 9.0,
									"patching_rect" : [ 28.0, 36.0, 122.0, 17.0 ],
									"numinlets" : 1,
									"numoutlets" : 0,
									"fontname" : "Arial"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "inlet",
									"id" : "obj-2",
									"patching_rect" : [ 74.0, 49.0, 15.0, 15.0 ],
									"numinlets" : 0,
									"numoutlets" : 1,
									"outlettype" : [ "bang" ],
									"comment" : "Bang me to reverse list."
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "inlet",
									"id" : "obj-3",
									"patching_rect" : [ 171.0, 50.0, 15.0, 15.0 ],
									"numinlets" : 0,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"comment" : "List input (must be 16 elements long)"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "outlet",
									"id" : "obj-4",
									"patching_rect" : [ 122.0, 212.0, 15.0, 15.0 ],
									"numinlets" : 1,
									"numoutlets" : 0,
									"comment" : ""
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "57 57 64 76 76 76 45 45 57 57 57 57 52 52 76 43",
									"id" : "obj-5",
									"fontsize" : 9.0,
									"patching_rect" : [ 74.0, 108.0, 295.0, 15.0 ],
									"numinlets" : 2,
									"numoutlets" : 1,
									"fontname" : "Arial",
									"outlettype" : [ "" ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "prepend set",
									"id" : "obj-6",
									"fontsize" : 9.0,
									"patching_rect" : [ 171.0, 70.0, 62.0, 17.0 ],
									"numinlets" : 1,
									"numoutlets" : 1,
									"fontname" : "Arial",
									"outlettype" : [ "" ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "zl group 16",
									"id" : "obj-7",
									"fontsize" : 9.0,
									"patching_rect" : [ 122.0, 191.0, 61.0, 17.0 ],
									"numinlets" : 2,
									"numoutlets" : 2,
									"fontname" : "Arial",
									"outlettype" : [ "", "" ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "unpack 0 0",
									"id" : "obj-8",
									"fontsize" : 9.0,
									"patching_rect" : [ 74.0, 149.0, 58.0, 17.0 ],
									"numinlets" : 1,
									"numoutlets" : 2,
									"fontname" : "Arial",
									"outlettype" : [ "int", "int" ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "- 1",
									"id" : "obj-9",
									"fontsize" : 9.0,
									"patching_rect" : [ 122.0, 170.0, 27.0, 17.0 ],
									"numinlets" : 2,
									"numoutlets" : 1,
									"fontname" : "Arial",
									"outlettype" : [ "int" ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "listfunnel",
									"id" : "obj-10",
									"color" : [ 1.0, 0.890196, 0.090196, 1.0 ],
									"fontsize" : 9.0,
									"patching_rect" : [ 74.0, 128.0, 50.0, 17.0 ],
									"numinlets" : 1,
									"numoutlets" : 1,
									"fontname" : "Arial",
									"outlettype" : [ "list" ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "List input (must be 16 elements long)",
									"id" : "obj-11",
									"fontsize" : 9.0,
									"patching_rect" : [ 187.0, 49.0, 183.0, 17.0 ],
									"numinlets" : 1,
									"numoutlets" : 0,
									"fontname" : "Arial"
								}

							}
 ],
						"lines" : [ 							{
								"patchline" : 								{
									"source" : [ "obj-6", 0 ],
									"destination" : [ "obj-5", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-2", 0 ],
									"destination" : [ "obj-5", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-5", 0 ],
									"destination" : [ "obj-10", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-10", 0 ],
									"destination" : [ "obj-8", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-8", 1 ],
									"destination" : [ "obj-9", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-9", 0 ],
									"destination" : [ "obj-7", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-7", 0 ],
									"destination" : [ "obj-4", 0 ],
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
						"default_fontface" : 0,
						"fontsize" : 12.0,
						"globalpatchername" : "",
						"default_fontname" : "Arial",
						"default_fontsize" : 12.0,
						"fontname" : "Arial"
					}

				}

			}
, 			{
				"box" : 				{
					"maxclass" : "button",
					"id" : "obj-140",
					"patching_rect" : [ 345.0, 398.0, 15.0, 15.0 ],
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "p shift up",
					"id" : "obj-141",
					"fontsize" : 12.0,
					"patching_rect" : [ 360.0, 398.0, 66.0, 20.0 ],
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontname" : "Arial",
					"outlettype" : [ "" ],
					"patcher" : 					{
						"fileversion" : 1,
						"rect" : [ 10.0, 59.0, 467.0, 286.0 ],
						"bglocked" : 0,
						"defrect" : [ 10.0, 59.0, 467.0, 286.0 ],
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
									"maxclass" : "comment",
									"text" : "Bang me to shift list up.",
									"id" : "obj-1",
									"fontsize" : 9.0,
									"patching_rect" : [ 28.0, 36.0, 122.0, 17.0 ],
									"numinlets" : 1,
									"numoutlets" : 0,
									"fontname" : "Arial"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "inlet",
									"id" : "obj-2",
									"patching_rect" : [ 74.0, 49.0, 15.0, 15.0 ],
									"numinlets" : 0,
									"numoutlets" : 1,
									"outlettype" : [ "bang" ],
									"comment" : "Bang me to reverse list."
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "inlet",
									"id" : "obj-3",
									"patching_rect" : [ 171.0, 50.0, 15.0, 15.0 ],
									"numinlets" : 0,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"comment" : "List input (must be 16 elements long)"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "outlet",
									"id" : "obj-4",
									"patching_rect" : [ 122.0, 212.0, 15.0, 15.0 ],
									"numinlets" : 1,
									"numoutlets" : 0,
									"comment" : ""
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "57 57 64 76 76 76 45 45 57 57 57 57 52 52 76 43",
									"id" : "obj-5",
									"fontsize" : 9.0,
									"patching_rect" : [ 74.0, 108.0, 295.0, 15.0 ],
									"numinlets" : 2,
									"numoutlets" : 1,
									"fontname" : "Arial",
									"outlettype" : [ "" ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "prepend set",
									"id" : "obj-6",
									"fontsize" : 9.0,
									"patching_rect" : [ 171.0, 70.0, 62.0, 17.0 ],
									"numinlets" : 1,
									"numoutlets" : 1,
									"fontname" : "Arial",
									"outlettype" : [ "" ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "zl group 16",
									"id" : "obj-7",
									"fontsize" : 9.0,
									"patching_rect" : [ 122.0, 191.0, 61.0, 17.0 ],
									"numinlets" : 2,
									"numoutlets" : 2,
									"fontname" : "Arial",
									"outlettype" : [ "", "" ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "unpack 0 0",
									"id" : "obj-8",
									"fontsize" : 9.0,
									"patching_rect" : [ 74.0, 149.0, 58.0, 17.0 ],
									"numinlets" : 1,
									"numoutlets" : 2,
									"fontname" : "Arial",
									"outlettype" : [ "int", "int" ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "+ 1",
									"id" : "obj-9",
									"fontsize" : 9.0,
									"patching_rect" : [ 122.0, 170.0, 29.0, 17.0 ],
									"numinlets" : 2,
									"numoutlets" : 1,
									"fontname" : "Arial",
									"outlettype" : [ "int" ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "listfunnel",
									"id" : "obj-10",
									"color" : [ 1.0, 0.890196, 0.090196, 1.0 ],
									"fontsize" : 9.0,
									"patching_rect" : [ 74.0, 128.0, 50.0, 17.0 ],
									"numinlets" : 1,
									"numoutlets" : 1,
									"fontname" : "Arial",
									"outlettype" : [ "list" ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "List input (must be 16 elements long)",
									"id" : "obj-11",
									"fontsize" : 9.0,
									"patching_rect" : [ 187.0, 49.0, 183.0, 17.0 ],
									"numinlets" : 1,
									"numoutlets" : 0,
									"fontname" : "Arial"
								}

							}
 ],
						"lines" : [ 							{
								"patchline" : 								{
									"source" : [ "obj-2", 0 ],
									"destination" : [ "obj-5", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-6", 0 ],
									"destination" : [ "obj-5", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-5", 0 ],
									"destination" : [ "obj-10", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-10", 0 ],
									"destination" : [ "obj-8", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-8", 1 ],
									"destination" : [ "obj-9", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-9", 0 ],
									"destination" : [ "obj-7", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-7", 0 ],
									"destination" : [ "obj-4", 0 ],
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
						"default_fontface" : 0,
						"fontsize" : 12.0,
						"globalpatchername" : "",
						"default_fontname" : "Arial",
						"default_fontsize" : 12.0,
						"fontname" : "Arial"
					}

				}

			}
, 			{
				"box" : 				{
					"maxclass" : "button",
					"id" : "obj-142",
					"patching_rect" : [ 345.0, 368.0, 15.0, 15.0 ],
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "p shift right",
					"id" : "obj-143",
					"fontsize" : 12.0,
					"patching_rect" : [ 360.0, 368.0, 81.0, 20.0 ],
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontname" : "Arial",
					"outlettype" : [ "" ],
					"patcher" : 					{
						"fileversion" : 1,
						"rect" : [ 679.0, 142.0, 425.0, 232.0 ],
						"bglocked" : 0,
						"defrect" : [ 679.0, 142.0, 425.0, 232.0 ],
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
									"maxclass" : "comment",
									"text" : "Bang me to rotate list left.",
									"id" : "obj-1",
									"fontsize" : 9.0,
									"patching_rect" : [ 28.0, 36.0, 126.0, 17.0 ],
									"numinlets" : 1,
									"numoutlets" : 0,
									"fontname" : "Arial"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "inlet",
									"id" : "obj-2",
									"patching_rect" : [ 74.0, 49.0, 15.0, 15.0 ],
									"numinlets" : 0,
									"numoutlets" : 1,
									"outlettype" : [ "bang" ],
									"comment" : "Bang me to reverse list."
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "inlet",
									"id" : "obj-3",
									"patching_rect" : [ 171.0, 50.0, 15.0, 15.0 ],
									"numinlets" : 0,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"comment" : "List input (must be 16 elements long)"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "outlet",
									"id" : "obj-4",
									"patching_rect" : [ 74.0, 149.0, 15.0, 15.0 ],
									"numinlets" : 1,
									"numoutlets" : 0,
									"comment" : ""
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "57 57 64 76 76 76 45 45 57 57 57 57 52 52 76 43",
									"id" : "obj-5",
									"fontsize" : 9.0,
									"patching_rect" : [ 74.0, 108.0, 295.0, 15.0 ],
									"numinlets" : 2,
									"numoutlets" : 1,
									"fontname" : "Arial",
									"outlettype" : [ "" ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "prepend set",
									"id" : "obj-6",
									"fontsize" : 9.0,
									"patching_rect" : [ 171.0, 70.0, 62.0, 17.0 ],
									"numinlets" : 1,
									"numoutlets" : 1,
									"fontname" : "Arial",
									"outlettype" : [ "" ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "zl rot 1",
									"id" : "obj-7",
									"fontsize" : 9.0,
									"patching_rect" : [ 74.0, 128.0, 44.0, 17.0 ],
									"numinlets" : 2,
									"numoutlets" : 2,
									"fontname" : "Arial",
									"outlettype" : [ "", "" ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "List input (must be 16 elements long)",
									"id" : "obj-8",
									"fontsize" : 9.0,
									"patching_rect" : [ 187.0, 49.0, 183.0, 17.0 ],
									"numinlets" : 1,
									"numoutlets" : 0,
									"fontname" : "Arial"
								}

							}
 ],
						"lines" : [ 							{
								"patchline" : 								{
									"source" : [ "obj-2", 0 ],
									"destination" : [ "obj-5", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-6", 0 ],
									"destination" : [ "obj-5", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-5", 0 ],
									"destination" : [ "obj-7", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-7", 0 ],
									"destination" : [ "obj-4", 0 ],
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
						"default_fontface" : 0,
						"fontsize" : 12.0,
						"globalpatchername" : "",
						"default_fontname" : "Arial",
						"default_fontsize" : 12.0,
						"fontname" : "Arial"
					}

				}

			}
, 			{
				"box" : 				{
					"maxclass" : "button",
					"id" : "obj-144",
					"patching_rect" : [ 345.0, 338.0, 15.0, 15.0 ],
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "p shift left",
					"id" : "obj-145",
					"fontsize" : 12.0,
					"patching_rect" : [ 360.0, 338.0, 75.0, 20.0 ],
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontname" : "Arial",
					"outlettype" : [ "" ],
					"patcher" : 					{
						"fileversion" : 1,
						"rect" : [ 679.0, 142.0, 425.0, 232.0 ],
						"bglocked" : 0,
						"defrect" : [ 679.0, 142.0, 425.0, 232.0 ],
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
									"maxclass" : "comment",
									"text" : "Bang me to rotate list left.",
									"id" : "obj-1",
									"fontsize" : 9.0,
									"patching_rect" : [ 28.0, 36.0, 126.0, 17.0 ],
									"numinlets" : 1,
									"numoutlets" : 0,
									"fontname" : "Arial"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "inlet",
									"id" : "obj-2",
									"patching_rect" : [ 74.0, 49.0, 15.0, 15.0 ],
									"numinlets" : 0,
									"numoutlets" : 1,
									"outlettype" : [ "bang" ],
									"comment" : "Bang me to reverse list."
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "inlet",
									"id" : "obj-3",
									"patching_rect" : [ 171.0, 50.0, 15.0, 15.0 ],
									"numinlets" : 0,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"comment" : "List input (must be 16 elements long)"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "outlet",
									"id" : "obj-4",
									"patching_rect" : [ 74.0, 149.0, 15.0, 15.0 ],
									"numinlets" : 1,
									"numoutlets" : 0,
									"comment" : ""
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "57 57 64 76 76 76 45 45 57 57 57 57 52 52 76 43",
									"id" : "obj-5",
									"fontsize" : 9.0,
									"patching_rect" : [ 74.0, 108.0, 295.0, 15.0 ],
									"numinlets" : 2,
									"numoutlets" : 1,
									"fontname" : "Arial",
									"outlettype" : [ "" ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "prepend set",
									"id" : "obj-6",
									"fontsize" : 9.0,
									"patching_rect" : [ 171.0, 70.0, 62.0, 17.0 ],
									"numinlets" : 1,
									"numoutlets" : 1,
									"fontname" : "Arial",
									"outlettype" : [ "" ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "zl rot -1",
									"id" : "obj-7",
									"fontsize" : 9.0,
									"patching_rect" : [ 74.0, 128.0, 49.0, 17.0 ],
									"numinlets" : 2,
									"numoutlets" : 2,
									"fontname" : "Arial",
									"outlettype" : [ "", "" ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "List input (must be 16 elements long)",
									"id" : "obj-8",
									"fontsize" : 9.0,
									"patching_rect" : [ 187.0, 49.0, 183.0, 17.0 ],
									"numinlets" : 1,
									"numoutlets" : 0,
									"fontname" : "Arial"
								}

							}
 ],
						"lines" : [ 							{
								"patchline" : 								{
									"source" : [ "obj-6", 0 ],
									"destination" : [ "obj-5", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-2", 0 ],
									"destination" : [ "obj-5", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-5", 0 ],
									"destination" : [ "obj-7", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-7", 0 ],
									"destination" : [ "obj-4", 0 ],
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
						"default_fontface" : 0,
						"fontsize" : 12.0,
						"globalpatchername" : "",
						"default_fontname" : "Arial",
						"default_fontsize" : 12.0,
						"fontname" : "Arial"
					}

				}

			}
, 			{
				"box" : 				{
					"maxclass" : "button",
					"id" : "obj-128",
					"patching_rect" : [ 345.0, 633.0, 15.0, 15.0 ],
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "p shift down",
					"id" : "obj-129",
					"fontsize" : 12.0,
					"patching_rect" : [ 360.0, 633.0, 84.0, 20.0 ],
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontname" : "Arial",
					"outlettype" : [ "" ],
					"patcher" : 					{
						"fileversion" : 1,
						"rect" : [ 10.0, 59.0, 467.0, 286.0 ],
						"bglocked" : 0,
						"defrect" : [ 10.0, 59.0, 467.0, 286.0 ],
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
									"maxclass" : "comment",
									"text" : "Bang me to shift list up.",
									"id" : "obj-1",
									"fontsize" : 9.0,
									"patching_rect" : [ 28.0, 36.0, 122.0, 17.0 ],
									"numinlets" : 1,
									"numoutlets" : 0,
									"fontname" : "Arial"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "inlet",
									"id" : "obj-2",
									"patching_rect" : [ 74.0, 49.0, 15.0, 15.0 ],
									"numinlets" : 0,
									"numoutlets" : 1,
									"outlettype" : [ "bang" ],
									"comment" : "Bang me to reverse list."
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "inlet",
									"id" : "obj-3",
									"patching_rect" : [ 171.0, 50.0, 15.0, 15.0 ],
									"numinlets" : 0,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"comment" : "List input (must be 16 elements long)"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "outlet",
									"id" : "obj-4",
									"patching_rect" : [ 122.0, 212.0, 15.0, 15.0 ],
									"numinlets" : 1,
									"numoutlets" : 0,
									"comment" : ""
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "-23 -9 -6 -54 0 -48 0 -29 21 -14 34 7 0 23 0 0",
									"id" : "obj-5",
									"fontsize" : 9.0,
									"patching_rect" : [ 74.0, 108.0, 295.0, 15.0 ],
									"numinlets" : 2,
									"numoutlets" : 1,
									"fontname" : "Arial",
									"outlettype" : [ "" ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "prepend set",
									"id" : "obj-6",
									"fontsize" : 9.0,
									"patching_rect" : [ 171.0, 70.0, 62.0, 17.0 ],
									"numinlets" : 1,
									"numoutlets" : 1,
									"fontname" : "Arial",
									"outlettype" : [ "" ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "zl group 16",
									"id" : "obj-7",
									"fontsize" : 9.0,
									"patching_rect" : [ 122.0, 191.0, 61.0, 17.0 ],
									"numinlets" : 2,
									"numoutlets" : 2,
									"fontname" : "Arial",
									"outlettype" : [ "", "" ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "unpack 0 0",
									"id" : "obj-8",
									"fontsize" : 9.0,
									"patching_rect" : [ 74.0, 149.0, 58.0, 17.0 ],
									"numinlets" : 1,
									"numoutlets" : 2,
									"fontname" : "Arial",
									"outlettype" : [ "int", "int" ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "- 1",
									"id" : "obj-9",
									"fontsize" : 9.0,
									"patching_rect" : [ 122.0, 170.0, 27.0, 17.0 ],
									"numinlets" : 2,
									"numoutlets" : 1,
									"fontname" : "Arial",
									"outlettype" : [ "int" ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "listfunnel",
									"id" : "obj-10",
									"color" : [ 1.0, 0.890196, 0.090196, 1.0 ],
									"fontsize" : 9.0,
									"patching_rect" : [ 74.0, 128.0, 50.0, 17.0 ],
									"numinlets" : 1,
									"numoutlets" : 1,
									"fontname" : "Arial",
									"outlettype" : [ "list" ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "List input (must be 16 elements long)",
									"id" : "obj-11",
									"fontsize" : 9.0,
									"patching_rect" : [ 187.0, 49.0, 183.0, 17.0 ],
									"numinlets" : 1,
									"numoutlets" : 0,
									"fontname" : "Arial"
								}

							}
 ],
						"lines" : [ 							{
								"patchline" : 								{
									"source" : [ "obj-3", 0 ],
									"destination" : [ "obj-6", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-7", 0 ],
									"destination" : [ "obj-4", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-9", 0 ],
									"destination" : [ "obj-7", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-8", 1 ],
									"destination" : [ "obj-9", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-10", 0 ],
									"destination" : [ "obj-8", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-5", 0 ],
									"destination" : [ "obj-10", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-2", 0 ],
									"destination" : [ "obj-5", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-6", 0 ],
									"destination" : [ "obj-5", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
 ]
					}
,
					"saved_object_attributes" : 					{
						"fontface" : 0,
						"default_fontface" : 0,
						"fontsize" : 12.0,
						"globalpatchername" : "",
						"default_fontname" : "Arial",
						"default_fontsize" : 12.0,
						"fontname" : "Arial"
					}

				}

			}
, 			{
				"box" : 				{
					"maxclass" : "button",
					"id" : "obj-130",
					"patching_rect" : [ 345.0, 603.0, 15.0, 15.0 ],
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "p shift up",
					"id" : "obj-131",
					"fontsize" : 12.0,
					"patching_rect" : [ 360.0, 603.0, 66.0, 20.0 ],
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontname" : "Arial",
					"outlettype" : [ "" ],
					"patcher" : 					{
						"fileversion" : 1,
						"rect" : [ 10.0, 59.0, 467.0, 286.0 ],
						"bglocked" : 0,
						"defrect" : [ 10.0, 59.0, 467.0, 286.0 ],
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
									"maxclass" : "comment",
									"text" : "Bang me to shift list up.",
									"id" : "obj-1",
									"fontsize" : 9.0,
									"patching_rect" : [ 28.0, 36.0, 122.0, 17.0 ],
									"numinlets" : 1,
									"numoutlets" : 0,
									"fontname" : "Arial"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "inlet",
									"id" : "obj-2",
									"patching_rect" : [ 74.0, 49.0, 15.0, 15.0 ],
									"numinlets" : 0,
									"numoutlets" : 1,
									"outlettype" : [ "bang" ],
									"comment" : "Bang me to reverse list."
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "inlet",
									"id" : "obj-3",
									"patching_rect" : [ 171.0, 50.0, 15.0, 15.0 ],
									"numinlets" : 0,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"comment" : "List input (must be 16 elements long)"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "outlet",
									"id" : "obj-4",
									"patching_rect" : [ 122.0, 212.0, 15.0, 15.0 ],
									"numinlets" : 1,
									"numoutlets" : 0,
									"comment" : ""
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "-23 -9 -6 -54 0 -48 0 -29 21 -14 34 7 0 23 0 0",
									"id" : "obj-5",
									"fontsize" : 9.0,
									"patching_rect" : [ 74.0, 108.0, 295.0, 15.0 ],
									"numinlets" : 2,
									"numoutlets" : 1,
									"fontname" : "Arial",
									"outlettype" : [ "" ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "prepend set",
									"id" : "obj-6",
									"fontsize" : 9.0,
									"patching_rect" : [ 171.0, 70.0, 62.0, 17.0 ],
									"numinlets" : 1,
									"numoutlets" : 1,
									"fontname" : "Arial",
									"outlettype" : [ "" ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "zl group 16",
									"id" : "obj-7",
									"fontsize" : 9.0,
									"patching_rect" : [ 122.0, 191.0, 61.0, 17.0 ],
									"numinlets" : 2,
									"numoutlets" : 2,
									"fontname" : "Arial",
									"outlettype" : [ "", "" ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "unpack 0 0",
									"id" : "obj-8",
									"fontsize" : 9.0,
									"patching_rect" : [ 74.0, 149.0, 58.0, 17.0 ],
									"numinlets" : 1,
									"numoutlets" : 2,
									"fontname" : "Arial",
									"outlettype" : [ "int", "int" ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "+ 1",
									"id" : "obj-9",
									"fontsize" : 9.0,
									"patching_rect" : [ 122.0, 170.0, 29.0, 17.0 ],
									"numinlets" : 2,
									"numoutlets" : 1,
									"fontname" : "Arial",
									"outlettype" : [ "int" ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "listfunnel",
									"id" : "obj-10",
									"color" : [ 1.0, 0.890196, 0.090196, 1.0 ],
									"fontsize" : 9.0,
									"patching_rect" : [ 74.0, 128.0, 50.0, 17.0 ],
									"numinlets" : 1,
									"numoutlets" : 1,
									"fontname" : "Arial",
									"outlettype" : [ "list" ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "List input (must be 16 elements long)",
									"id" : "obj-11",
									"fontsize" : 9.0,
									"patching_rect" : [ 187.0, 49.0, 183.0, 17.0 ],
									"numinlets" : 1,
									"numoutlets" : 0,
									"fontname" : "Arial"
								}

							}
 ],
						"lines" : [ 							{
								"patchline" : 								{
									"source" : [ "obj-3", 0 ],
									"destination" : [ "obj-6", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-7", 0 ],
									"destination" : [ "obj-4", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-9", 0 ],
									"destination" : [ "obj-7", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-8", 1 ],
									"destination" : [ "obj-9", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-10", 0 ],
									"destination" : [ "obj-8", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-5", 0 ],
									"destination" : [ "obj-10", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-6", 0 ],
									"destination" : [ "obj-5", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-2", 0 ],
									"destination" : [ "obj-5", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
 ]
					}
,
					"saved_object_attributes" : 					{
						"fontface" : 0,
						"default_fontface" : 0,
						"fontsize" : 12.0,
						"globalpatchername" : "",
						"default_fontname" : "Arial",
						"default_fontsize" : 12.0,
						"fontname" : "Arial"
					}

				}

			}
, 			{
				"box" : 				{
					"maxclass" : "button",
					"id" : "obj-132",
					"patching_rect" : [ 345.0, 573.0, 15.0, 15.0 ],
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "p shift right",
					"id" : "obj-133",
					"fontsize" : 12.0,
					"patching_rect" : [ 360.0, 573.0, 81.0, 20.0 ],
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontname" : "Arial",
					"outlettype" : [ "" ],
					"patcher" : 					{
						"fileversion" : 1,
						"rect" : [ 679.0, 142.0, 425.0, 232.0 ],
						"bglocked" : 0,
						"defrect" : [ 679.0, 142.0, 425.0, 232.0 ],
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
									"maxclass" : "comment",
									"text" : "Bang me to rotate list left.",
									"id" : "obj-1",
									"fontsize" : 9.0,
									"patching_rect" : [ 28.0, 36.0, 126.0, 17.0 ],
									"numinlets" : 1,
									"numoutlets" : 0,
									"fontname" : "Arial"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "inlet",
									"id" : "obj-2",
									"patching_rect" : [ 74.0, 49.0, 15.0, 15.0 ],
									"numinlets" : 0,
									"numoutlets" : 1,
									"outlettype" : [ "bang" ],
									"comment" : "Bang me to reverse list."
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "inlet",
									"id" : "obj-3",
									"patching_rect" : [ 171.0, 50.0, 15.0, 15.0 ],
									"numinlets" : 0,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"comment" : "List input (must be 16 elements long)"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "outlet",
									"id" : "obj-4",
									"patching_rect" : [ 74.0, 149.0, 15.0, 15.0 ],
									"numinlets" : 1,
									"numoutlets" : 0,
									"comment" : ""
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "-23 -9 -6 -54 0 -48 0 -29 21 -14 34 7 0 23 0 0",
									"id" : "obj-5",
									"fontsize" : 9.0,
									"patching_rect" : [ 74.0, 108.0, 295.0, 15.0 ],
									"numinlets" : 2,
									"numoutlets" : 1,
									"fontname" : "Arial",
									"outlettype" : [ "" ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "prepend set",
									"id" : "obj-6",
									"fontsize" : 9.0,
									"patching_rect" : [ 171.0, 70.0, 62.0, 17.0 ],
									"numinlets" : 1,
									"numoutlets" : 1,
									"fontname" : "Arial",
									"outlettype" : [ "" ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "zl rot 1",
									"id" : "obj-7",
									"fontsize" : 9.0,
									"patching_rect" : [ 74.0, 128.0, 44.0, 17.0 ],
									"numinlets" : 2,
									"numoutlets" : 2,
									"fontname" : "Arial",
									"outlettype" : [ "", "" ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "List input (must be 16 elements long)",
									"id" : "obj-8",
									"fontsize" : 9.0,
									"patching_rect" : [ 187.0, 49.0, 183.0, 17.0 ],
									"numinlets" : 1,
									"numoutlets" : 0,
									"fontname" : "Arial"
								}

							}
 ],
						"lines" : [ 							{
								"patchline" : 								{
									"source" : [ "obj-3", 0 ],
									"destination" : [ "obj-6", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-7", 0 ],
									"destination" : [ "obj-4", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-5", 0 ],
									"destination" : [ "obj-7", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-6", 0 ],
									"destination" : [ "obj-5", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-2", 0 ],
									"destination" : [ "obj-5", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
 ]
					}
,
					"saved_object_attributes" : 					{
						"fontface" : 0,
						"default_fontface" : 0,
						"fontsize" : 12.0,
						"globalpatchername" : "",
						"default_fontname" : "Arial",
						"default_fontsize" : 12.0,
						"fontname" : "Arial"
					}

				}

			}
, 			{
				"box" : 				{
					"maxclass" : "button",
					"id" : "obj-134",
					"patching_rect" : [ 345.0, 543.0, 15.0, 15.0 ],
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "p shift left",
					"id" : "obj-135",
					"fontsize" : 12.0,
					"patching_rect" : [ 360.0, 543.0, 75.0, 20.0 ],
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontname" : "Arial",
					"outlettype" : [ "" ],
					"patcher" : 					{
						"fileversion" : 1,
						"rect" : [ 679.0, 142.0, 425.0, 232.0 ],
						"bglocked" : 0,
						"defrect" : [ 679.0, 142.0, 425.0, 232.0 ],
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
									"maxclass" : "comment",
									"text" : "Bang me to rotate list left.",
									"id" : "obj-1",
									"fontsize" : 9.0,
									"patching_rect" : [ 28.0, 36.0, 126.0, 17.0 ],
									"numinlets" : 1,
									"numoutlets" : 0,
									"fontname" : "Arial"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "inlet",
									"id" : "obj-2",
									"patching_rect" : [ 74.0, 49.0, 15.0, 15.0 ],
									"numinlets" : 0,
									"numoutlets" : 1,
									"outlettype" : [ "bang" ],
									"comment" : "Bang me to reverse list."
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "inlet",
									"id" : "obj-3",
									"patching_rect" : [ 171.0, 50.0, 15.0, 15.0 ],
									"numinlets" : 0,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"comment" : "List input (must be 16 elements long)"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "outlet",
									"id" : "obj-4",
									"patching_rect" : [ 74.0, 149.0, 15.0, 15.0 ],
									"numinlets" : 1,
									"numoutlets" : 0,
									"comment" : ""
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "-23 -9 -6 -54 0 -48 0 -29 21 -14 34 7 0 23 0 0",
									"id" : "obj-5",
									"fontsize" : 9.0,
									"patching_rect" : [ 74.0, 108.0, 295.0, 15.0 ],
									"numinlets" : 2,
									"numoutlets" : 1,
									"fontname" : "Arial",
									"outlettype" : [ "" ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "prepend set",
									"id" : "obj-6",
									"fontsize" : 9.0,
									"patching_rect" : [ 171.0, 70.0, 62.0, 17.0 ],
									"numinlets" : 1,
									"numoutlets" : 1,
									"fontname" : "Arial",
									"outlettype" : [ "" ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "zl rot -1",
									"id" : "obj-7",
									"fontsize" : 9.0,
									"patching_rect" : [ 74.0, 128.0, 49.0, 17.0 ],
									"numinlets" : 2,
									"numoutlets" : 2,
									"fontname" : "Arial",
									"outlettype" : [ "", "" ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "List input (must be 16 elements long)",
									"id" : "obj-8",
									"fontsize" : 9.0,
									"patching_rect" : [ 187.0, 49.0, 183.0, 17.0 ],
									"numinlets" : 1,
									"numoutlets" : 0,
									"fontname" : "Arial"
								}

							}
 ],
						"lines" : [ 							{
								"patchline" : 								{
									"source" : [ "obj-3", 0 ],
									"destination" : [ "obj-6", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-7", 0 ],
									"destination" : [ "obj-4", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-5", 0 ],
									"destination" : [ "obj-7", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-2", 0 ],
									"destination" : [ "obj-5", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-6", 0 ],
									"destination" : [ "obj-5", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
 ]
					}
,
					"saved_object_attributes" : 					{
						"fontface" : 0,
						"default_fontface" : 0,
						"fontsize" : 12.0,
						"globalpatchername" : "",
						"default_fontname" : "Arial",
						"default_fontsize" : 12.0,
						"fontname" : "Arial"
					}

				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "pw $1",
					"id" : "obj-18",
					"fontsize" : 12.0,
					"patching_rect" : [ 459.0, 55.0, 43.0, 18.0 ],
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontname" : "Arial",
					"outlettype" : [ "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"id" : "obj-73",
					"fontface" : 1,
					"fontsize" : 12.0,
					"minimum" : 0.01,
					"patching_rect" : [ 459.0, 34.0, 57.0, 20.0 ],
					"numinlets" : 1,
					"maximum" : 0.99,
					"numoutlets" : 2,
					"htextcolor" : [ 0.870588, 0.870588, 0.870588, 1.0 ],
					"bgcolor" : [ 0.6, 1.0, 1.0, 1.0 ],
					"fontname" : "Arial",
					"triscale" : 0.9,
					"outlettype" : [ "float", "bang" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "pack clear 0",
					"id" : "obj-127",
					"fontsize" : 12.0,
					"patching_rect" : [ 273.0, 26.0, 75.0, 20.0 ],
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontname" : "Arial",
					"outlettype" : [ "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "button",
					"id" : "obj-126",
					"patching_rect" : [ 273.0, 3.0, 20.0, 20.0 ],
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "number",
					"id" : "obj-125",
					"fontsize" : 12.0,
					"minimum" : 1,
					"patching_rect" : [ 329.0, 2.0, 50.0, 20.0 ],
					"numinlets" : 1,
					"numoutlets" : 2,
					"fontname" : "Arial",
					"outlettype" : [ "int", "bang" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "p tempo",
					"id" : "obj-1",
					"fontsize" : 12.0,
					"patching_rect" : [ 315.0, 112.0, 58.0, 20.0 ],
					"numinlets" : 1,
					"numoutlets" : 1,
					"fontname" : "Arial",
					"outlettype" : [ "" ],
					"patcher" : 					{
						"fileversion" : 1,
						"rect" : [ 486.0, 221.0, 383.0, 285.0 ],
						"bglocked" : 0,
						"defrect" : [ 486.0, 221.0, 383.0, 285.0 ],
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
									"maxclass" : "outlet",
									"id" : "obj-1",
									"patching_rect" : [ 88.0, 126.0, 15.0, 15.0 ],
									"numinlets" : 1,
									"numoutlets" : 0,
									"comment" : ""
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "inlet",
									"id" : "obj-2",
									"patching_rect" : [ 88.0, 52.0, 15.0, 15.0 ],
									"numinlets" : 0,
									"numoutlets" : 1,
									"outlettype" : [ "float" ],
									"comment" : ""
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "if $i1 == 0. then 0.01 else $i1",
									"id" : "obj-3",
									"fontsize" : 9.0,
									"patching_rect" : [ 88.0, 77.0, 155.0, 17.0 ],
									"numinlets" : 1,
									"numoutlets" : 1,
									"fontname" : "Arial",
									"outlettype" : [ "" ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "expr 1 / (pow(($f1/60.)\\,-1.) * 4.)",
									"id" : "obj-4",
									"fontsize" : 9.0,
									"patching_rect" : [ 88.0, 104.0, 177.0, 17.0 ],
									"numinlets" : 1,
									"numoutlets" : 1,
									"fontname" : "Arial",
									"outlettype" : [ "" ]
								}

							}
 ],
						"lines" : [ 							{
								"patchline" : 								{
									"source" : [ "obj-2", 0 ],
									"destination" : [ "obj-3", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-3", 0 ],
									"destination" : [ "obj-4", 0 ],
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
 ]
					}
,
					"saved_object_attributes" : 					{
						"fontface" : 0,
						"default_fontface" : 0,
						"fontsize" : 12.0,
						"globalpatchername" : "",
						"default_fontname" : "Arial",
						"default_fontsize" : 12.0,
						"fontname" : "Arial"
					}

				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"id" : "obj-2",
					"fontface" : 1,
					"fontsize" : 12.0,
					"patching_rect" : [ 315.0, 90.0, 63.0, 20.0 ],
					"numinlets" : 1,
					"numoutlets" : 2,
					"htextcolor" : [ 0.870588, 0.870588, 0.870588, 1.0 ],
					"bgcolor" : [ 0.807843, 1.0, 0.94902, 1.0 ],
					"fontname" : "Arial",
					"triscale" : 0.9,
					"outlettype" : [ "float", "bang" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "pvar cIN",
					"id" : "obj-3",
					"fontsize" : 12.0,
					"patching_rect" : [ 315.0, 154.0, 61.0, 20.0 ],
					"hidden" : 1,
					"numinlets" : 1,
					"numoutlets" : 1,
					"fontname" : "Arial",
					"outlettype" : [ "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "pvar cIN",
					"id" : "obj-4",
					"fontsize" : 12.0,
					"patching_rect" : [ 657.0, 151.0, 61.0, 20.0 ],
					"hidden" : 1,
					"numinlets" : 1,
					"numoutlets" : 1,
					"fontname" : "Arial",
					"outlettype" : [ "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "pvar cIN",
					"id" : "obj-5",
					"fontsize" : 12.0,
					"patching_rect" : [ 398.0, 153.0, 61.0, 20.0 ],
					"hidden" : 1,
					"numinlets" : 1,
					"numoutlets" : 1,
					"fontname" : "Arial",
					"outlettype" : [ "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "pvar cIN",
					"id" : "obj-6",
					"fontsize" : 12.0,
					"patching_rect" : [ 282.0, 244.0, 61.0, 20.0 ],
					"hidden" : 1,
					"numinlets" : 1,
					"numoutlets" : 1,
					"fontname" : "Arial",
					"outlettype" : [ "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "prepend c",
					"id" : "obj-7",
					"fontsize" : 12.0,
					"patching_rect" : [ 103.0, 155.0, 68.0, 20.0 ],
					"hidden" : 1,
					"numinlets" : 1,
					"numoutlets" : 1,
					"fontname" : "Arial",
					"outlettype" : [ "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"varname" : "cIN",
					"text" : "t l",
					"id" : "obj-8",
					"fontsize" : 12.0,
					"patching_rect" : [ 102.0, 132.0, 21.0, 20.0 ],
					"numinlets" : 1,
					"numoutlets" : 1,
					"fontname" : "Arial",
					"outlettype" : [ "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "cIN",
					"id" : "obj-9",
					"textcolor" : [ 0.839216, 0.0, 0.0, 1.0 ],
					"fontsize" : 12.0,
					"patching_rect" : [ 78.0, 133.0, 34.0, 20.0 ],
					"numinlets" : 1,
					"frgb" : [ 0.839216, 0.0, 0.0, 1.0 ],
					"numoutlets" : 0,
					"fontname" : "Arial"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "pattrforward csIN",
					"id" : "obj-10",
					"fontsize" : 12.0,
					"patching_rect" : [ 735.0, 631.0, 102.0, 20.0 ],
					"hidden" : 1,
					"numinlets" : 1,
					"numoutlets" : 1,
					"fontname" : "Arial",
					"outlettype" : [ "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "p wsidx for table #3",
					"id" : "obj-11",
					"fontsize" : 12.0,
					"patching_rect" : [ 735.0, 607.0, 137.0, 20.0 ],
					"hidden" : 1,
					"numinlets" : 1,
					"numoutlets" : 1,
					"fontname" : "Arial",
					"outlettype" : [ "" ],
					"patcher" : 					{
						"fileversion" : 1,
						"rect" : [ 15.0, 55.0, 305.0, 219.0 ],
						"bglocked" : 0,
						"defrect" : [ 15.0, 55.0, 305.0, 219.0 ],
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
									"maxclass" : "comment",
									"text" : "IMPORTANT: On WinXP, never use [iter]. It doesn't like [csound~]. Don't ask me how or why. Use [zl iter 1] instead.",
									"linecount" : 3,
									"id" : "obj-1",
									"textcolor" : [ 0.772549, 0.019608, 0.003922, 1.0 ],
									"fontsize" : 9.0,
									"patching_rect" : [ 86.0, 47.0, 207.0, 38.0 ],
									"numinlets" : 1,
									"frgb" : [ 0.772549, 0.019608, 0.003922, 1.0 ],
									"numoutlets" : 0,
									"fontname" : "Arial"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "pack wsidx 3 0 0.",
									"id" : "obj-2",
									"fontsize" : 9.0,
									"patching_rect" : [ 40.0, 128.0, 100.0, 17.0 ],
									"numinlets" : 4,
									"numoutlets" : 1,
									"fontname" : "Arial",
									"outlettype" : [ "" ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "t b b f",
									"id" : "obj-3",
									"fontsize" : 9.0,
									"patching_rect" : [ 40.0, 75.0, 40.0, 17.0 ],
									"numinlets" : 1,
									"numoutlets" : 3,
									"fontname" : "Arial",
									"outlettype" : [ "bang", "bang", "float" ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "counter 0 15",
									"id" : "obj-4",
									"fontsize" : 9.0,
									"patching_rect" : [ 55.0, 100.0, 68.0, 17.0 ],
									"numinlets" : 5,
									"numoutlets" : 4,
									"fontname" : "Arial",
									"outlettype" : [ "int", "", "", "int" ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "zl iter 1",
									"id" : "obj-5",
									"fontsize" : 9.0,
									"patching_rect" : [ 40.0, 50.0, 38.0, 17.0 ],
									"numinlets" : 2,
									"numoutlets" : 2,
									"fontname" : "Arial",
									"outlettype" : [ "", "" ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "outlet",
									"id" : "obj-6",
									"patching_rect" : [ 40.0, 156.0, 15.0, 15.0 ],
									"numinlets" : 1,
									"numoutlets" : 0,
									"comment" : ""
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "inlet",
									"id" : "obj-7",
									"patching_rect" : [ 40.0, 28.0, 15.0, 15.0 ],
									"numinlets" : 0,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"comment" : ""
								}

							}
 ],
						"lines" : [ 							{
								"patchline" : 								{
									"source" : [ "obj-7", 0 ],
									"destination" : [ "obj-5", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-5", 0 ],
									"destination" : [ "obj-3", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-3", 0 ],
									"destination" : [ "obj-2", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-2", 0 ],
									"destination" : [ "obj-6", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-3", 1 ],
									"destination" : [ "obj-4", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-4", 0 ],
									"destination" : [ "obj-2", 2 ],
									"hidden" : 0,
									"midpoints" : [ 64.5, 122.0, 103.5, 122.0 ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-3", 2 ],
									"destination" : [ "obj-2", 3 ],
									"hidden" : 0,
									"midpoints" : [ 70.5, 95.0, 130.5, 95.0 ]
								}

							}
 ]
					}
,
					"saved_object_attributes" : 					{
						"fontface" : 0,
						"default_fontface" : 0,
						"fontsize" : 12.0,
						"globalpatchername" : "",
						"default_fontname" : "Arial",
						"default_fontsize" : 12.0,
						"fontname" : "Arial"
					}

				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "p wsidx for table #2",
					"id" : "obj-12",
					"fontsize" : 12.0,
					"patching_rect" : [ 735.0, 407.0, 137.0, 20.0 ],
					"hidden" : 1,
					"numinlets" : 1,
					"numoutlets" : 1,
					"fontname" : "Arial",
					"outlettype" : [ "" ],
					"patcher" : 					{
						"fileversion" : 1,
						"rect" : [ 15.0, 55.0, 322.0, 234.0 ],
						"bglocked" : 0,
						"defrect" : [ 15.0, 55.0, 322.0, 234.0 ],
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
									"maxclass" : "newobj",
									"text" : "pack wsidx 2 0 0.",
									"id" : "obj-1",
									"fontsize" : 9.0,
									"patching_rect" : [ 40.0, 128.0, 100.0, 17.0 ],
									"numinlets" : 4,
									"numoutlets" : 1,
									"fontname" : "Arial",
									"outlettype" : [ "" ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "t b b f",
									"id" : "obj-2",
									"fontsize" : 9.0,
									"patching_rect" : [ 40.0, 75.0, 40.0, 17.0 ],
									"numinlets" : 1,
									"numoutlets" : 3,
									"fontname" : "Arial",
									"outlettype" : [ "bang", "bang", "float" ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "counter 0 15",
									"id" : "obj-3",
									"fontsize" : 9.0,
									"patching_rect" : [ 55.0, 100.0, 68.0, 17.0 ],
									"numinlets" : 5,
									"numoutlets" : 4,
									"fontname" : "Arial",
									"outlettype" : [ "int", "", "", "int" ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "zl iter 1",
									"id" : "obj-4",
									"fontsize" : 9.0,
									"patching_rect" : [ 40.0, 50.0, 38.0, 17.0 ],
									"numinlets" : 2,
									"numoutlets" : 2,
									"fontname" : "Arial",
									"outlettype" : [ "", "" ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "outlet",
									"id" : "obj-5",
									"patching_rect" : [ 40.0, 156.0, 15.0, 15.0 ],
									"numinlets" : 1,
									"numoutlets" : 0,
									"comment" : ""
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "inlet",
									"id" : "obj-6",
									"patching_rect" : [ 40.0, 28.0, 15.0, 15.0 ],
									"numinlets" : 0,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"comment" : ""
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "IMPORTANT: On WinXP, never use [iter]. It doesn't like [csound~]. Don't ask me how or why. Use [zl iter 1] instead.",
									"linecount" : 3,
									"id" : "obj-7",
									"textcolor" : [ 0.772549, 0.019608, 0.003922, 1.0 ],
									"fontsize" : 9.0,
									"patching_rect" : [ 86.0, 48.0, 207.0, 38.0 ],
									"numinlets" : 1,
									"frgb" : [ 0.772549, 0.019608, 0.003922, 1.0 ],
									"numoutlets" : 0,
									"fontname" : "Arial"
								}

							}
 ],
						"lines" : [ 							{
								"patchline" : 								{
									"source" : [ "obj-6", 0 ],
									"destination" : [ "obj-4", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-4", 0 ],
									"destination" : [ "obj-2", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-2", 0 ],
									"destination" : [ "obj-1", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-1", 0 ],
									"destination" : [ "obj-5", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-2", 1 ],
									"destination" : [ "obj-3", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-3", 0 ],
									"destination" : [ "obj-1", 2 ],
									"hidden" : 0,
									"midpoints" : [ 64.5, 122.0, 103.5, 122.0 ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-2", 2 ],
									"destination" : [ "obj-1", 3 ],
									"hidden" : 0,
									"midpoints" : [ 70.5, 95.0, 130.5, 95.0 ]
								}

							}
 ]
					}
,
					"saved_object_attributes" : 					{
						"fontface" : 0,
						"default_fontface" : 0,
						"fontsize" : 12.0,
						"globalpatchername" : "",
						"default_fontname" : "Arial",
						"default_fontsize" : 12.0,
						"fontname" : "Arial"
					}

				}

			}
, 			{
				"box" : 				{
					"maxclass" : "toggle",
					"id" : "obj-13",
					"patching_rect" : [ 679.0, 200.0, 19.0, 19.0 ],
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "int" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "useFiltTable $1",
					"id" : "obj-14",
					"fontsize" : 12.0,
					"patching_rect" : [ 679.0, 221.0, 96.0, 18.0 ],
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontname" : "Arial",
					"outlettype" : [ "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "simplefollow $1",
					"id" : "obj-15",
					"fontsize" : 12.0,
					"patching_rect" : [ 569.0, 221.0, 100.0, 18.0 ],
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontname" : "Arial",
					"outlettype" : [ "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "umenu",
					"id" : "obj-16",
					"fontsize" : 12.0,
					"patching_rect" : [ 569.0, 200.0, 104.0, 20.0 ],
					"numinlets" : 1,
					"items" : [ "special", "follow", ",", "simple", "follow" ],
					"numoutlets" : 3,
					"fontname" : "Arial",
					"types" : [  ],
					"outlettype" : [ "int", "", "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "spectroscope~",
					"peakcolor" : [ 0.952941, 0.8, 0.8, 1.0 ],
					"domain" : [ 50.0, 22050.0 ],
					"id" : "obj-17",
					"bordercolor" : [ 0.0, 0.0, 0.0, 1.0 ],
					"interval" : 15,
					"sonomedcolor" : [ 0.0, 0.74902, 0.498039, 1.0 ],
					"patching_rect" : [ 3.0, 308.0, 334.0, 130.0 ],
					"sonomedlocolor" : [ 0.498039, 0.0, 0.498039, 1.0 ],
					"numinlets" : 2,
					"logfreq" : 1,
					"sonomedhicolor" : [ 1.0, 0.74902, 0.0, 1.0 ],
					"numoutlets" : 1,
					"bgcolor" : [ 1.0, 1.0, 1.0, 1.0 ],
					"rounded" : 0,
					"markercolor" : [ 0.721569, 0.721569, 0.721569, 1.0 ],
					"fgcolor" : [ 0.878431, 0.878431, 0.878431, 1.0 ],
					"outlettype" : [ "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "gain~",
					"id" : "obj-19",
					"knobcolor" : [ 0.0, 0.0, 0.0, 1.0 ],
					"patching_rect" : [ 46.0, 121.0, 22.0, 101.0 ],
					"numinlets" : 2,
					"numoutlets" : 2,
					"orientation" : 2,
					"bgcolor" : [ 0.792157, 0.792157, 0.792157, 1.0 ],
					"outlettype" : [ "signal", "int" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "distMethod $1",
					"id" : "obj-20",
					"fontsize" : 12.0,
					"patching_rect" : [ 456.0, 129.0, 88.0, 18.0 ],
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontname" : "Arial",
					"outlettype" : [ "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "umenu",
					"id" : "obj-21",
					"fontsize" : 12.0,
					"patching_rect" : [ 456.0, 107.0, 73.0, 20.0 ],
					"numinlets" : 1,
					"items" : [ "distort", ",", "distort1", ",", "tanhDist" ],
					"numoutlets" : 3,
					"fontname" : "Arial",
					"types" : [  ],
					"outlettype" : [ "int", "", "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "drive $1",
					"id" : "obj-22",
					"fontsize" : 12.0,
					"patching_rect" : [ 398.0, 130.0, 53.0, 18.0 ],
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontname" : "Arial",
					"outlettype" : [ "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"id" : "obj-23",
					"fontface" : 1,
					"fontsize" : 12.0,
					"minimum" : 0.1,
					"patching_rect" : [ 398.0, 107.0, 57.0, 20.0 ],
					"numinlets" : 1,
					"numoutlets" : 2,
					"htextcolor" : [ 0.870588, 0.870588, 0.870588, 1.0 ],
					"bgcolor" : [ 1.0, 0.360784, 0.988235, 1.0 ],
					"fontname" : "Arial",
					"triscale" : 0.9,
					"outlettype" : [ "float", "bang" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "meter~",
					"tepidcolor" : [ 0.6, 0.729412, 0.0, 1.0 ],
					"id" : "obj-24",
					"warmcolor" : [ 0.85098, 0.85098, 0.0, 1.0 ],
					"interval" : 10,
					"patching_rect" : [ 3.0, 284.0, 334.0, 25.0 ],
					"numinlets" : 1,
					"numoutlets" : 1,
					"coldcolor" : [ 0.0, 0.658824, 0.0, 1.0 ],
					"bgcolor" : [ 0.12549, 0.12549, 0.12549, 1.0 ],
					"outlettype" : [ "float" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "pak set 0",
					"id" : "obj-25",
					"fontsize" : 12.0,
					"patching_rect" : [ 71.0, 200.0, 65.0, 20.0 ],
					"hidden" : 1,
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontname" : "Arial",
					"outlettype" : [ "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "ftype $1",
					"id" : "obj-26",
					"fontsize" : 12.0,
					"patching_rect" : [ 282.0, 221.0, 54.0, 18.0 ],
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontname" : "Arial",
					"outlettype" : [ "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "umenu",
					"id" : "obj-27",
					"fontsize" : 12.0,
					"patching_rect" : [ 282.0, 199.0, 50.0, 20.0 ],
					"numinlets" : 1,
					"items" : [ "LP", ",", "HP", ",", "BP" ],
					"numoutlets" : 3,
					"fontname" : "Arial",
					"types" : [  ],
					"outlettype" : [ "int", "", "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "number",
					"id" : "obj-28",
					"fontsize" : 12.0,
					"patching_rect" : [ 71.0, 182.0, 41.0, 20.0 ],
					"numinlets" : 1,
					"numoutlets" : 2,
					"htextcolor" : [ 0.870588, 0.870588, 0.870588, 1.0 ],
					"bgcolor" : [ 0.866667, 0.866667, 0.866667, 1.0 ],
					"fontname" : "Arial",
					"triscale" : 0.9,
					"outlettype" : [ "int", "bang" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "pitch follow",
					"id" : "obj-29",
					"fontsize" : 12.0,
					"patching_rect" : [ 505.0, 180.0, 81.0, 20.0 ],
					"numinlets" : 1,
					"numoutlets" : 0,
					"fontname" : "Arial"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "follow $1",
					"id" : "obj-30",
					"fontsize" : 12.0,
					"patching_rect" : [ 507.0, 221.0, 61.0, 18.0 ],
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontname" : "Arial",
					"outlettype" : [ "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"id" : "obj-31",
					"textcolor" : [ 1.0, 1.0, 1.0, 1.0 ],
					"fontface" : 1,
					"fontsize" : 12.0,
					"patching_rect" : [ 507.0, 200.0, 57.0, 20.0 ],
					"numinlets" : 1,
					"numoutlets" : 2,
					"htextcolor" : [ 0.870588, 0.870588, 0.870588, 1.0 ],
					"bgcolor" : [ 0.0, 0.0, 0.0, 1.0 ],
					"fontname" : "Arial",
					"triscale" : 0.9,
					"outlettype" : [ "float", "bang" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "button",
					"id" : "obj-32",
					"patching_rect" : [ 345.0, 513.0, 16.0, 16.0 ],
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "p reverse",
					"id" : "obj-33",
					"fontsize" : 12.0,
					"patching_rect" : [ 360.0, 513.0, 72.0, 20.0 ],
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontname" : "Arial",
					"outlettype" : [ "" ],
					"patcher" : 					{
						"fileversion" : 1,
						"rect" : [ 10.0, 59.0, 425.0, 232.0 ],
						"bglocked" : 0,
						"defrect" : [ 10.0, 59.0, 425.0, 232.0 ],
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
									"maxclass" : "comment",
									"text" : "Bang me to reverse list.",
									"id" : "obj-1",
									"fontsize" : 9.0,
									"patching_rect" : [ 28.0, 36.0, 122.0, 17.0 ],
									"numinlets" : 1,
									"numoutlets" : 0,
									"fontname" : "Arial"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "inlet",
									"id" : "obj-2",
									"patching_rect" : [ 74.0, 49.0, 15.0, 15.0 ],
									"numinlets" : 0,
									"numoutlets" : 1,
									"outlettype" : [ "bang" ],
									"comment" : "Bang me to reverse list."
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "inlet",
									"id" : "obj-3",
									"patching_rect" : [ 171.0, 50.0, 15.0, 15.0 ],
									"numinlets" : 0,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"comment" : "List input (must be 16 elements long)"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "outlet",
									"id" : "obj-4",
									"patching_rect" : [ 74.0, 149.0, 15.0, 15.0 ],
									"numinlets" : 1,
									"numoutlets" : 0,
									"comment" : ""
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "-23 -9 -6 -54 0 -48 0 -29 21 -14 34 7 0 23 0 0",
									"id" : "obj-5",
									"fontsize" : 9.0,
									"patching_rect" : [ 74.0, 108.0, 295.0, 15.0 ],
									"numinlets" : 2,
									"numoutlets" : 1,
									"fontname" : "Arial",
									"outlettype" : [ "" ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "prepend set",
									"id" : "obj-6",
									"fontsize" : 9.0,
									"patching_rect" : [ 171.0, 70.0, 62.0, 17.0 ],
									"numinlets" : 1,
									"numoutlets" : 1,
									"fontname" : "Arial",
									"outlettype" : [ "" ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "zl rev",
									"id" : "obj-7",
									"fontsize" : 9.0,
									"patching_rect" : [ 74.0, 128.0, 37.0, 17.0 ],
									"numinlets" : 2,
									"numoutlets" : 2,
									"fontname" : "Arial",
									"outlettype" : [ "", "" ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "List input (must be 16 elements long)",
									"id" : "obj-8",
									"fontsize" : 9.0,
									"patching_rect" : [ 187.0, 49.0, 183.0, 17.0 ],
									"numinlets" : 1,
									"numoutlets" : 0,
									"fontname" : "Arial"
								}

							}
 ],
						"lines" : [ 							{
								"patchline" : 								{
									"source" : [ "obj-2", 0 ],
									"destination" : [ "obj-5", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-6", 0 ],
									"destination" : [ "obj-5", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-5", 0 ],
									"destination" : [ "obj-7", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-7", 0 ],
									"destination" : [ "obj-4", 0 ],
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
						"default_fontface" : 0,
						"fontsize" : 12.0,
						"globalpatchername" : "",
						"default_fontname" : "Arial",
						"default_fontsize" : 12.0,
						"fontname" : "Arial"
					}

				}

			}
, 			{
				"box" : 				{
					"maxclass" : "button",
					"id" : "obj-34",
					"patching_rect" : [ 345.0, 483.0, 16.0, 16.0 ],
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "p invert",
					"id" : "obj-35",
					"fontsize" : 12.0,
					"patching_rect" : [ 360.0, 483.0, 61.0, 20.0 ],
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontname" : "Arial",
					"outlettype" : [ "" ],
					"patcher" : 					{
						"fileversion" : 1,
						"rect" : [ 10.0, 59.0, 467.0, 286.0 ],
						"bglocked" : 0,
						"defrect" : [ 10.0, 59.0, 467.0, 286.0 ],
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
									"maxclass" : "outlet",
									"id" : "obj-13",
									"patching_rect" : [ 135.0, 250.0, 25.0, 25.0 ],
									"numinlets" : 1,
									"numoutlets" : 0,
									"comment" : ""
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "* -1",
									"id" : "obj-1",
									"fontsize" : 12.0,
									"patching_rect" : [ 135.0, 190.0, 37.0, 20.0 ],
									"numinlets" : 2,
									"numoutlets" : 1,
									"fontname" : "Arial",
									"outlettype" : [ "int" ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "Bang me to invert list.",
									"id" : "obj-2",
									"fontsize" : 12.0,
									"patching_rect" : [ 30.0, 30.0, 160.0, 20.0 ],
									"numinlets" : 1,
									"numoutlets" : 0,
									"fontname" : "Arial"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "inlet",
									"id" : "obj-3",
									"patching_rect" : [ 74.0, 49.0, 31.0, 31.0 ],
									"numinlets" : 0,
									"numoutlets" : 1,
									"outlettype" : [ "bang" ],
									"comment" : "Bang me to invert list."
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "inlet",
									"id" : "obj-4",
									"patching_rect" : [ 180.0, 45.0, 27.0, 27.0 ],
									"numinlets" : 0,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"comment" : "List input (must be 16 elements long)"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "-23 -9 -6 -54 0 -48 0 -29 21 -14 34 7 0 23 0 0",
									"id" : "obj-6",
									"fontsize" : 12.0,
									"patching_rect" : [ 74.0, 108.0, 389.0, 18.0 ],
									"numinlets" : 2,
									"numoutlets" : 1,
									"fontname" : "Arial",
									"outlettype" : [ "" ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "prepend set",
									"id" : "obj-7",
									"fontsize" : 12.0,
									"patching_rect" : [ 180.0, 75.0, 80.0, 20.0 ],
									"numinlets" : 1,
									"numoutlets" : 1,
									"fontname" : "Arial",
									"outlettype" : [ "" ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "zl group 16",
									"id" : "obj-8",
									"fontsize" : 12.0,
									"patching_rect" : [ 135.0, 225.0, 79.0, 20.0 ],
									"numinlets" : 2,
									"numoutlets" : 2,
									"fontname" : "Arial",
									"outlettype" : [ "", "" ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "unpack 0 0",
									"id" : "obj-9",
									"fontsize" : 12.0,
									"patching_rect" : [ 74.0, 159.0, 80.0, 20.0 ],
									"numinlets" : 1,
									"numoutlets" : 2,
									"fontname" : "Arial",
									"outlettype" : [ "int", "int" ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "listfunnel",
									"id" : "obj-10",
									"color" : [ 1.0, 0.890196, 0.090196, 1.0 ],
									"fontsize" : 12.0,
									"patching_rect" : [ 74.0, 128.0, 64.0, 20.0 ],
									"numinlets" : 1,
									"numoutlets" : 1,
									"fontname" : "Arial",
									"outlettype" : [ "list" ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "List input (must be 16 elements long)",
									"id" : "obj-11",
									"fontsize" : 12.0,
									"patching_rect" : [ 210.0, 45.0, 241.0, 20.0 ],
									"numinlets" : 1,
									"numoutlets" : 0,
									"fontname" : "Arial"
								}

							}
 ],
						"lines" : [ 							{
								"patchline" : 								{
									"source" : [ "obj-8", 0 ],
									"destination" : [ "obj-13", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-7", 0 ],
									"destination" : [ "obj-6", 0 ],
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
, 							{
								"patchline" : 								{
									"source" : [ "obj-6", 0 ],
									"destination" : [ "obj-10", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-10", 0 ],
									"destination" : [ "obj-9", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-9", 1 ],
									"destination" : [ "obj-1", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-1", 0 ],
									"destination" : [ "obj-8", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-4", 0 ],
									"destination" : [ "obj-7", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
 ]
					}
,
					"saved_object_attributes" : 					{
						"fontface" : 0,
						"default_fontface" : 0,
						"fontsize" : 12.0,
						"globalpatchername" : "",
						"default_fontname" : "Arial",
						"default_fontsize" : 12.0,
						"fontname" : "Arial"
					}

				}

			}
, 			{
				"box" : 				{
					"maxclass" : "button",
					"id" : "obj-36",
					"patching_rect" : [ 345.0, 308.0, 16.0, 16.0 ],
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "p reverse",
					"id" : "obj-37",
					"fontsize" : 12.0,
					"patching_rect" : [ 360.0, 308.0, 65.0, 20.0 ],
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontname" : "Arial",
					"outlettype" : [ "" ],
					"patcher" : 					{
						"fileversion" : 1,
						"rect" : [ 10.0, 59.0, 425.0, 232.0 ],
						"bglocked" : 0,
						"defrect" : [ 10.0, 59.0, 425.0, 232.0 ],
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
									"maxclass" : "comment",
									"text" : "Bang me to reverse list.",
									"id" : "obj-1",
									"fontsize" : 9.0,
									"patching_rect" : [ 28.0, 36.0, 122.0, 17.0 ],
									"numinlets" : 1,
									"numoutlets" : 0,
									"fontname" : "Arial"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "inlet",
									"id" : "obj-2",
									"patching_rect" : [ 74.0, 49.0, 15.0, 15.0 ],
									"numinlets" : 0,
									"numoutlets" : 1,
									"outlettype" : [ "bang" ],
									"comment" : "Bang me to reverse list."
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "inlet",
									"id" : "obj-3",
									"patching_rect" : [ 171.0, 50.0, 15.0, 15.0 ],
									"numinlets" : 0,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"comment" : "List input (must be 16 elements long)"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "outlet",
									"id" : "obj-4",
									"patching_rect" : [ 74.0, 149.0, 15.0, 15.0 ],
									"numinlets" : 1,
									"numoutlets" : 0,
									"comment" : ""
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "57 57 64 76 76 76 45 45 57 57 57 57 52 52 76 43",
									"id" : "obj-5",
									"fontsize" : 9.0,
									"patching_rect" : [ 74.0, 108.0, 295.0, 15.0 ],
									"numinlets" : 2,
									"numoutlets" : 1,
									"fontname" : "Arial",
									"outlettype" : [ "" ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "prepend set",
									"id" : "obj-6",
									"fontsize" : 9.0,
									"patching_rect" : [ 171.0, 70.0, 62.0, 17.0 ],
									"numinlets" : 1,
									"numoutlets" : 1,
									"fontname" : "Arial",
									"outlettype" : [ "" ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "zl rev",
									"id" : "obj-7",
									"fontsize" : 9.0,
									"patching_rect" : [ 74.0, 128.0, 37.0, 17.0 ],
									"numinlets" : 2,
									"numoutlets" : 2,
									"fontname" : "Arial",
									"outlettype" : [ "", "" ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "List input (must be 16 elements long)",
									"id" : "obj-8",
									"fontsize" : 9.0,
									"patching_rect" : [ 187.0, 49.0, 183.0, 17.0 ],
									"numinlets" : 1,
									"numoutlets" : 0,
									"fontname" : "Arial"
								}

							}
 ],
						"lines" : [ 							{
								"patchline" : 								{
									"source" : [ "obj-6", 0 ],
									"destination" : [ "obj-5", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-2", 0 ],
									"destination" : [ "obj-5", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-5", 0 ],
									"destination" : [ "obj-7", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-7", 0 ],
									"destination" : [ "obj-4", 0 ],
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
						"default_fontface" : 0,
						"fontsize" : 12.0,
						"globalpatchername" : "",
						"default_fontname" : "Arial",
						"default_fontsize" : 12.0,
						"fontname" : "Arial"
					}

				}

			}
, 			{
				"box" : 				{
					"maxclass" : "button",
					"id" : "obj-38",
					"patching_rect" : [ 345.0, 278.0, 16.0, 16.0 ],
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "p invert",
					"id" : "obj-39",
					"fontsize" : 12.0,
					"patching_rect" : [ 360.0, 278.0, 54.0, 20.0 ],
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontname" : "Arial",
					"outlettype" : [ "" ],
					"patcher" : 					{
						"fileversion" : 1,
						"rect" : [ 70.0, 59.0, 467.0, 286.0 ],
						"bglocked" : 0,
						"defrect" : [ 70.0, 59.0, 467.0, 286.0 ],
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
									"maxclass" : "comment",
									"text" : "Bang me to invert list.",
									"id" : "obj-1",
									"fontsize" : 12.0,
									"patching_rect" : [ 15.0, 15.0, 133.0, 20.0 ],
									"numinlets" : 1,
									"numoutlets" : 0,
									"fontname" : "Arial"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "inlet",
									"id" : "obj-2",
									"patching_rect" : [ 60.0, 45.0, 25.0, 25.0 ],
									"numinlets" : 0,
									"numoutlets" : 1,
									"outlettype" : [ "bang" ],
									"comment" : "Bang me to invert list."
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "inlet",
									"id" : "obj-3",
									"patching_rect" : [ 165.0, 45.0, 25.0, 25.0 ],
									"numinlets" : 0,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"comment" : "List input (must be 16 elements long)"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "outlet",
									"id" : "obj-4",
									"patching_rect" : [ 120.0, 255.0, 27.0, 27.0 ],
									"numinlets" : 1,
									"numoutlets" : 0,
									"comment" : ""
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "57 57 64 76 76 76 45 45 57 57 57 57 52 52 76 43",
									"id" : "obj-5",
									"fontsize" : 12.0,
									"patching_rect" : [ 60.0, 105.0, 384.0, 18.0 ],
									"numinlets" : 2,
									"numoutlets" : 1,
									"fontname" : "Arial",
									"outlettype" : [ "" ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "prepend set",
									"id" : "obj-6",
									"fontsize" : 12.0,
									"patching_rect" : [ 165.0, 75.0, 81.0, 20.0 ],
									"numinlets" : 1,
									"numoutlets" : 1,
									"fontname" : "Arial",
									"outlettype" : [ "" ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "zl group 16",
									"id" : "obj-7",
									"fontsize" : 12.0,
									"patching_rect" : [ 120.0, 225.0, 79.0, 20.0 ],
									"numinlets" : 2,
									"numoutlets" : 2,
									"fontname" : "Arial",
									"outlettype" : [ "", "" ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "unpack 0 0",
									"id" : "obj-8",
									"fontsize" : 12.0,
									"patching_rect" : [ 60.0, 165.0, 79.0, 20.0 ],
									"numinlets" : 1,
									"numoutlets" : 2,
									"fontname" : "Arial",
									"outlettype" : [ "int", "int" ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "expr 64 - ($i1 - 64)",
									"id" : "obj-9",
									"fontsize" : 12.0,
									"patching_rect" : [ 120.0, 195.0, 130.0, 20.0 ],
									"numinlets" : 1,
									"numoutlets" : 1,
									"fontname" : "Arial",
									"outlettype" : [ "" ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "listfunnel",
									"id" : "obj-10",
									"color" : [ 1.0, 0.890196, 0.090196, 1.0 ],
									"fontsize" : 12.0,
									"patching_rect" : [ 60.0, 135.0, 64.0, 20.0 ],
									"numinlets" : 1,
									"numoutlets" : 1,
									"fontname" : "Arial",
									"outlettype" : [ "list" ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "List input (must be 16 elements long)",
									"id" : "obj-11",
									"fontsize" : 12.0,
									"patching_rect" : [ 150.0, 15.0, 240.0, 20.0 ],
									"numinlets" : 1,
									"numoutlets" : 0,
									"fontname" : "Arial"
								}

							}
 ],
						"lines" : [ 							{
								"patchline" : 								{
									"source" : [ "obj-2", 0 ],
									"destination" : [ "obj-5", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-6", 0 ],
									"destination" : [ "obj-5", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-5", 0 ],
									"destination" : [ "obj-10", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-10", 0 ],
									"destination" : [ "obj-8", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-8", 1 ],
									"destination" : [ "obj-9", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-9", 0 ],
									"destination" : [ "obj-7", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-7", 0 ],
									"destination" : [ "obj-4", 0 ],
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
						"default_fontface" : 0,
						"fontsize" : 12.0,
						"globalpatchername" : "",
						"default_fontname" : "Arial",
						"default_fontsize" : 12.0,
						"fontname" : "Arial"
					}

				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "Csound Table #3: Filter MIDI pitch",
					"id" : "obj-40",
					"fontsize" : 12.0,
					"patching_rect" : [ 497.0, 451.0, 218.0, 20.0 ],
					"numinlets" : 1,
					"numoutlets" : 0,
					"fontname" : "Arial"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "Csound Table #2: Oscillator MIDI pitch",
					"id" : "obj-41",
					"fontsize" : 12.0,
					"patching_rect" : [ 494.0, 247.0, 248.0, 20.0 ],
					"numinlets" : 1,
					"numoutlets" : 0,
					"fontname" : "Arial"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "shift VCO pitch",
					"linecount" : 2,
					"id" : "obj-42",
					"fontsize" : 12.0,
					"patching_rect" : [ 399.0, 4.0, 66.0, 34.0 ],
					"numinlets" : 1,
					"numoutlets" : 0,
					"fontname" : "Arial"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "pshift $1",
					"id" : "obj-43",
					"fontsize" : 12.0,
					"patching_rect" : [ 399.0, 55.0, 59.0, 18.0 ],
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontname" : "Arial",
					"outlettype" : [ "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"id" : "obj-44",
					"fontface" : 1,
					"fontsize" : 12.0,
					"minimum" : -127.0,
					"patching_rect" : [ 399.0, 34.0, 55.0, 20.0 ],
					"numinlets" : 1,
					"maximum" : 127.0,
					"numoutlets" : 2,
					"htextcolor" : [ 0.870588, 0.870588, 0.870588, 1.0 ],
					"bgcolor" : [ 0.921569, 0.87451, 1.0, 1.0 ],
					"fontname" : "Arial",
					"triscale" : 0.9,
					"outlettype" : [ "float", "bang" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "shift filt pitch",
					"id" : "obj-45",
					"fontsize" : 12.0,
					"patching_rect" : [ 329.0, 182.0, 75.0, 20.0 ],
					"numinlets" : 1,
					"numoutlets" : 0,
					"fontname" : "Arial"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "fshift $1",
					"id" : "obj-46",
					"fontsize" : 12.0,
					"patching_rect" : [ 338.0, 221.0, 57.0, 18.0 ],
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontname" : "Arial",
					"outlettype" : [ "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"id" : "obj-47",
					"fontface" : 1,
					"fontsize" : 12.0,
					"minimum" : -127.0,
					"patching_rect" : [ 338.0, 200.0, 56.0, 20.0 ],
					"numinlets" : 1,
					"maximum" : 127.0,
					"numoutlets" : 2,
					"htextcolor" : [ 0.870588, 0.870588, 0.870588, 1.0 ],
					"bgcolor" : [ 0.921569, 0.87451, 1.0, 1.0 ],
					"fontname" : "Arial",
					"triscale" : 0.9,
					"outlettype" : [ "float", "bang" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "delay amp",
					"id" : "obj-49",
					"fontsize" : 12.0,
					"patching_rect" : [ 748.0, 67.0, 70.0, 20.0 ],
					"numinlets" : 1,
					"numoutlets" : 0,
					"fontname" : "Arial"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "delay feedback",
					"linecount" : 2,
					"id" : "obj-50",
					"fontsize" : 12.0,
					"patching_rect" : [ 684.0, 76.0, 60.0, 34.0 ],
					"numinlets" : 1,
					"numoutlets" : 0,
					"fontname" : "Arial"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "delay cutoff",
					"linecount" : 2,
					"id" : "obj-51",
					"fontsize" : 12.0,
					"patching_rect" : [ 621.0, 76.0, 53.0, 34.0 ],
					"numinlets" : 1,
					"numoutlets" : 0,
					"fontname" : "Arial"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "delay time",
					"id" : "obj-52",
					"fontsize" : 12.0,
					"patching_rect" : [ 551.0, 88.0, 71.0, 20.0 ],
					"numinlets" : 1,
					"numoutlets" : 0,
					"fontname" : "Arial"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "Q",
					"id" : "obj-53",
					"fontsize" : 12.0,
					"patching_rect" : [ 414.0, 180.0, 23.0, 20.0 ],
					"numinlets" : 1,
					"numoutlets" : 0,
					"fontname" : "Arial"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "filt glide",
					"id" : "obj-54",
					"fontsize" : 12.0,
					"patching_rect" : [ 451.0, 180.0, 61.0, 20.0 ],
					"numinlets" : 1,
					"numoutlets" : 0,
					"fontname" : "Arial"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "pitch glide",
					"id" : "obj-55",
					"fontsize" : 12.0,
					"patching_rect" : [ 519.0, 16.0, 70.0, 20.0 ],
					"numinlets" : 1,
					"numoutlets" : 0,
					"fontname" : "Arial"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "dbtoa",
					"id" : "obj-56",
					"fontsize" : 12.0,
					"patching_rect" : [ 747.0, 107.0, 43.0, 20.0 ],
					"numinlets" : 1,
					"numoutlets" : 1,
					"fontname" : "Arial",
					"outlettype" : [ "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "delAmp $1",
					"id" : "obj-57",
					"fontsize" : 12.0,
					"patching_rect" : [ 747.0, 128.0, 69.0, 18.0 ],
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontname" : "Arial",
					"outlettype" : [ "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"id" : "obj-58",
					"fontface" : 1,
					"fontsize" : 12.0,
					"minimum" : -90.0,
					"patching_rect" : [ 747.0, 86.0, 62.0, 20.0 ],
					"numinlets" : 1,
					"maximum" : 0.0,
					"numoutlets" : 2,
					"htextcolor" : [ 0.870588, 0.870588, 0.870588, 1.0 ],
					"bgcolor" : [ 1.0, 0.678431, 0.678431, 1.0 ],
					"fontname" : "Arial",
					"triscale" : 0.9,
					"outlettype" : [ "float", "bang" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"id" : "obj-59",
					"fontface" : 1,
					"fontsize" : 12.0,
					"minimum" : 0.01,
					"patching_rect" : [ 554.0, 107.0, 51.0, 20.0 ],
					"numinlets" : 1,
					"numoutlets" : 2,
					"htextcolor" : [ 0.870588, 0.870588, 0.870588, 1.0 ],
					"bgcolor" : [ 0.811765, 0.87451, 1.0, 1.0 ],
					"fontname" : "Arial",
					"triscale" : 0.9,
					"outlettype" : [ "float", "bang" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "delFdbk $1",
					"id" : "obj-60",
					"fontsize" : 12.0,
					"patching_rect" : [ 676.0, 128.0, 70.0, 18.0 ],
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontname" : "Arial",
					"outlettype" : [ "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"id" : "obj-61",
					"fontface" : 1,
					"fontsize" : 12.0,
					"minimum" : 0.0,
					"patching_rect" : [ 676.0, 107.0, 63.0, 20.0 ],
					"numinlets" : 1,
					"maximum" : 0.99,
					"numoutlets" : 2,
					"htextcolor" : [ 0.870588, 0.870588, 0.870588, 1.0 ],
					"bgcolor" : [ 1.0, 0.776471, 0.490196, 1.0 ],
					"fontname" : "Arial",
					"triscale" : 0.9,
					"outlettype" : [ "float", "bang" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "delCut $1",
					"id" : "obj-62",
					"fontsize" : 12.0,
					"patching_rect" : [ 612.0, 128.0, 63.0, 18.0 ],
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontname" : "Arial",
					"outlettype" : [ "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"id" : "obj-63",
					"fontface" : 1,
					"fontsize" : 12.0,
					"minimum" : 100.0,
					"patching_rect" : [ 612.0, 107.0, 63.0, 20.0 ],
					"numinlets" : 1,
					"numoutlets" : 2,
					"htextcolor" : [ 0.870588, 0.870588, 0.870588, 1.0 ],
					"bgcolor" : [ 0.854902, 0.678431, 1.0, 1.0 ],
					"fontname" : "Arial",
					"triscale" : 0.9,
					"outlettype" : [ "float", "bang" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "delay $1",
					"id" : "obj-64",
					"fontsize" : 12.0,
					"patching_rect" : [ 554.0, 128.0, 57.0, 18.0 ],
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontname" : "Arial",
					"outlettype" : [ "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "reso $1",
					"id" : "obj-65",
					"fontsize" : 12.0,
					"patching_rect" : [ 397.0, 221.0, 50.0, 18.0 ],
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontname" : "Arial",
					"outlettype" : [ "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"id" : "obj-66",
					"fontface" : 1,
					"fontsize" : 12.0,
					"minimum" : 1.0,
					"patching_rect" : [ 397.0, 200.0, 50.0, 20.0 ],
					"numinlets" : 1,
					"maximum" : 500.0,
					"numoutlets" : 2,
					"htextcolor" : [ 0.870588, 0.870588, 0.870588, 1.0 ],
					"bgcolor" : [ 0.984314, 1.0, 0.419608, 1.0 ],
					"fontname" : "Arial",
					"triscale" : 0.9,
					"outlettype" : [ "float", "bang" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "fglide $1",
					"id" : "obj-67",
					"fontsize" : 12.0,
					"patching_rect" : [ 449.0, 221.0, 56.0, 18.0 ],
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontname" : "Arial",
					"outlettype" : [ "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"id" : "obj-68",
					"fontface" : 1,
					"fontsize" : 12.0,
					"minimum" : 0.0,
					"patching_rect" : [ 449.0, 200.0, 57.0, 20.0 ],
					"numinlets" : 1,
					"numoutlets" : 2,
					"htextcolor" : [ 0.870588, 0.870588, 0.870588, 1.0 ],
					"bgcolor" : [ 0.709804, 1.0, 0.615686, 1.0 ],
					"fontname" : "Arial",
					"triscale" : 0.9,
					"outlettype" : [ "float", "bang" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "pglide $1",
					"id" : "obj-69",
					"fontsize" : 12.0,
					"patching_rect" : [ 519.0, 55.0, 59.0, 18.0 ],
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontname" : "Arial",
					"outlettype" : [ "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"id" : "obj-70",
					"fontface" : 1,
					"fontsize" : 12.0,
					"minimum" : 0.0,
					"patching_rect" : [ 519.0, 34.0, 57.0, 20.0 ],
					"numinlets" : 1,
					"numoutlets" : 2,
					"htextcolor" : [ 0.870588, 0.870588, 0.870588, 1.0 ],
					"bgcolor" : [ 0.709804, 1.0, 0.615686, 1.0 ],
					"fontname" : "Arial",
					"triscale" : 0.9,
					"outlettype" : [ "float", "bang" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "pvar cIN",
					"id" : "obj-71",
					"fontsize" : 12.0,
					"patching_rect" : [ 399.0, 78.0, 61.0, 20.0 ],
					"hidden" : 1,
					"numinlets" : 1,
					"numoutlets" : 1,
					"fontname" : "Arial",
					"outlettype" : [ "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "speed $1",
					"id" : "obj-72",
					"fontsize" : 12.0,
					"patching_rect" : [ 315.0, 135.0, 64.0, 18.0 ],
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontname" : "Arial",
					"outlettype" : [ "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "preset",
					"spacing" : 2,
					"id" : "obj-74",
					"bubblesize" : 8,
					"margin" : 4,
					"patching_rect" : [ 181.0, 30.0, 87.0, 18.0 ],
					"numinlets" : 1,
					"numoutlets" : 4,
					"outlettype" : [ "preset", "int", "preset", "int" ],
					"preset_data" : [ 						{
							"number" : 1,
							"data" : [ 20, "obj-114", "multislider", "list", 61, 61, 64, 52, 52, 52, 83, 83, 71, 71, 78, 57, 57, 71, 52, 85, 5, "obj-110", "led", "int", 0, 5, "obj-108", "number", "int", 14, 5, "obj-107", "led", "int", 0, 5, "obj-106", "led", "int", 0, 5, "obj-105", "led", "int", 0, 5, "obj-104", "led", "int", 0, 5, "obj-103", "led", "int", 0, 5, "obj-102", "led", "int", 0, 5, "obj-101", "led", "int", 0, 5, "obj-100", "led", "int", 0, 5, "obj-99", "led", "int", 0, 5, "obj-98", "led", "int", 0, 5, "obj-97", "led", "int", 0, 5, "obj-96", "led", "int", 0, 5, "obj-95", "led", "int", 0, 5, "obj-94", "led", "int", 1, 5, "obj-93", "led", "int", 0, 20, "obj-92", "multislider", "list", 0, 26, 15, 13, 28, 39, 2, 0, 0, 23, 0, 7, 32, 24, 21, 20, 5, "obj-90", "led", "int", 0, 5, "obj-89", "led", "int", 0, 5, "obj-88", "led", "int", 0, 5, "obj-87", "led", "int", 0, 5, "obj-86", "led", "int", 0, 5, "obj-85", "led", "int", 0, 5, "obj-84", "led", "int", 0, 5, "obj-83", "led", "int", 0, 5, "obj-82", "led", "int", 0, 5, "obj-81", "led", "int", 0, 5, "obj-80", "led", "int", 0, 5, "obj-79", "led", "int", 0, 5, "obj-78", "led", "int", 0, 5, "obj-77", "led", "int", 0, 5, "obj-76", "led", "int", 1, 5, "obj-75", "led", "int", 0, 5, "obj-70", "flonum", "float", 0.126, 5, "obj-68", "flonum", "float", 0.093, 5, "obj-66", "flonum", "float", 4.0, 5, "obj-63", "flonum", "float", 2825.0, 5, "obj-61", "flonum", "float", 0.62, 5, "obj-59", "flonum", "float", 3.0, 5, "obj-58", "flonum", "float", -12.0, 5, "obj-47", "flonum", "float", 16.5, 5, "obj-44", "flonum", "float", -20.0, 5, "obj-31", "flonum", "float", 1.62, 5, "obj-27", "umenu", "int", 0, 5, "obj-23", "flonum", "float", 0.42, 5, "obj-21", "umenu", "int", 0, 5, "obj-16", "umenu", "int", 1, 5, "obj-13", "toggle", "int", 1, 5, "obj-2", "flonum", "float", 115.0, 5, "obj-125", "number", "int", 1, 5, "obj-73", "flonum", "float", 0.5 ]
						}
, 						{
							"number" : 2,
							"data" : [ 20, "obj-114", "multislider", "list", 57, 57, 64, 76, 76, 76, 45, 45, 57, 57, 57, 57, 52, 52, 76, 43, 5, "obj-110", "led", "int", 0, 5, "obj-108", "number", "int", 9, 5, "obj-107", "led", "int", 0, 5, "obj-106", "led", "int", 0, 5, "obj-105", "led", "int", 0, 5, "obj-104", "led", "int", 0, 5, "obj-103", "led", "int", 0, 5, "obj-102", "led", "int", 0, 5, "obj-101", "led", "int", 0, 5, "obj-100", "led", "int", 0, 5, "obj-99", "led", "int", 1, 5, "obj-98", "led", "int", 0, 5, "obj-97", "led", "int", 0, 5, "obj-96", "led", "int", 0, 5, "obj-95", "led", "int", 0, 5, "obj-94", "led", "int", 0, 5, "obj-93", "led", "int", 0, 20, "obj-92", "multislider", "list", -23, -9, -6, -54, 0, -48, 0, -29, 21, -14, 34, 7, 0, 23, 0, 0, 5, "obj-90", "led", "int", 0, 5, "obj-89", "led", "int", 0, 5, "obj-88", "led", "int", 0, 5, "obj-87", "led", "int", 0, 5, "obj-86", "led", "int", 0, 5, "obj-85", "led", "int", 0, 5, "obj-84", "led", "int", 0, 5, "obj-83", "led", "int", 0, 5, "obj-82", "led", "int", 0, 5, "obj-81", "led", "int", 1, 5, "obj-80", "led", "int", 0, 5, "obj-79", "led", "int", 0, 5, "obj-78", "led", "int", 0, 5, "obj-77", "led", "int", 0, 5, "obj-76", "led", "int", 0, 5, "obj-75", "led", "int", 0, 5, "obj-70", "flonum", "float", 0.01, 5, "obj-68", "flonum", "float", 0.08, 5, "obj-66", "flonum", "float", 10.0, 5, "obj-63", "flonum", "float", 2825.0, 5, "obj-61", "flonum", "float", 0.59, 5, "obj-59", "flonum", "float", 3.0, 5, "obj-58", "flonum", "float", -10.0, 5, "obj-47", "flonum", "float", 7.0, 5, "obj-44", "flonum", "float", -16.0, 5, "obj-31", "flonum", "float", 0.42, 5, "obj-27", "umenu", "int", 2, 5, "obj-23", "flonum", "float", 1.01, 5, "obj-21", "umenu", "int", 2, 5, "obj-16", "umenu", "int", 0, 5, "obj-13", "toggle", "int", 1, 5, "obj-2", "flonum", "float", -96.0 ]
						}
, 						{
							"number" : 3,
							"data" : [ 20, "obj-114", "multislider", "list", 61, 61, 64, 52, 52, 52, 83, 83, 71, 71, 78, 57, 76, 76, 52, 85, 5, "obj-110", "led", "int", 0, 5, "obj-108", "number", "int", 13, 5, "obj-107", "led", "int", 0, 5, "obj-106", "led", "int", 0, 5, "obj-105", "led", "int", 0, 5, "obj-104", "led", "int", 0, 5, "obj-103", "led", "int", 0, 5, "obj-102", "led", "int", 0, 5, "obj-101", "led", "int", 0, 5, "obj-100", "led", "int", 0, 5, "obj-99", "led", "int", 0, 5, "obj-98", "led", "int", 0, 5, "obj-97", "led", "int", 0, 5, "obj-96", "led", "int", 0, 5, "obj-95", "led", "int", 1, 5, "obj-94", "led", "int", 0, 5, "obj-93", "led", "int", 0, 20, "obj-92", "multislider", "list", 0, 0, 23, 0, 7, 32, 24, 21, 20, 0, 7, 0, -10, 42, -19, 1, 5, "obj-90", "led", "int", 0, 5, "obj-89", "led", "int", 0, 5, "obj-88", "led", "int", 0, 5, "obj-87", "led", "int", 0, 5, "obj-86", "led", "int", 0, 5, "obj-85", "led", "int", 0, 5, "obj-84", "led", "int", 0, 5, "obj-83", "led", "int", 0, 5, "obj-82", "led", "int", 0, 5, "obj-81", "led", "int", 0, 5, "obj-80", "led", "int", 0, 5, "obj-79", "led", "int", 0, 5, "obj-78", "led", "int", 0, 5, "obj-77", "led", "int", 1, 5, "obj-76", "led", "int", 0, 5, "obj-75", "led", "int", 0, 5, "obj-70", "flonum", "float", 0.12, 5, "obj-68", "flonum", "float", 0.08, 5, "obj-66", "flonum", "float", 6.0, 5, "obj-63", "flonum", "float", 2825.0, 5, "obj-61", "flonum", "float", 0.59, 5, "obj-59", "flonum", "float", 3.0, 5, "obj-58", "flonum", "float", -7.0, 5, "obj-47", "flonum", "float", 1.0, 5, "obj-44", "flonum", "float", -10.0, 5, "obj-31", "flonum", "float", 0.05, 5, "obj-27", "umenu", "int", 0, 5, "obj-23", "flonum", "float", 1.11, 5, "obj-21", "umenu", "int", 2, 5, "obj-16", "umenu", "int", 1, 5, "obj-13", "toggle", "int", 1, 5, "obj-2", "flonum", "float", -111.0 ]
						}
, 						{
							"number" : 4,
							"data" : [ 20, "obj-114", "multislider", "list", 61, 61, 64, 52, 52, 52, 83, 83, 71, 71, 78, 57, 76, 76, 52, 85, 5, "obj-110", "led", "int", 0, 5, "obj-108", "number", "int", 6, 5, "obj-107", "led", "int", 0, 5, "obj-106", "led", "int", 0, 5, "obj-105", "led", "int", 0, 5, "obj-104", "led", "int", 0, 5, "obj-103", "led", "int", 0, 5, "obj-102", "led", "int", 1, 5, "obj-101", "led", "int", 0, 5, "obj-100", "led", "int", 0, 5, "obj-99", "led", "int", 0, 5, "obj-98", "led", "int", 0, 5, "obj-97", "led", "int", 0, 5, "obj-96", "led", "int", 0, 5, "obj-95", "led", "int", 0, 5, "obj-94", "led", "int", 0, 5, "obj-93", "led", "int", 0, 20, "obj-92", "multislider", "list", -14, -19, 50, -10, 0, 7, 0, 21, 21, -24, 50, 7, 0, 23, 0, 0, 5, "obj-90", "led", "int", 0, 5, "obj-89", "led", "int", 0, 5, "obj-88", "led", "int", 0, 5, "obj-87", "led", "int", 0, 5, "obj-86", "led", "int", 0, 5, "obj-85", "led", "int", 0, 5, "obj-84", "led", "int", 1, 5, "obj-83", "led", "int", 0, 5, "obj-82", "led", "int", 0, 5, "obj-81", "led", "int", 0, 5, "obj-80", "led", "int", 0, 5, "obj-79", "led", "int", 0, 5, "obj-78", "led", "int", 0, 5, "obj-77", "led", "int", 0, 5, "obj-76", "led", "int", 0, 5, "obj-75", "led", "int", 0, 5, "obj-70", "flonum", "float", 0.01, 5, "obj-68", "flonum", "float", 0.08, 5, "obj-66", "flonum", "float", 10.0, 5, "obj-63", "flonum", "float", 2825.0, 5, "obj-61", "flonum", "float", 0.59, 5, "obj-59", "flonum", "float", 3.0, 5, "obj-58", "flonum", "float", -10.0, 5, "obj-47", "flonum", "float", 13.0, 5, "obj-44", "flonum", "float", -21.0, 5, "obj-31", "flonum", "float", 0.42, 5, "obj-27", "umenu", "int", 2, 5, "obj-23", "flonum", "float", 1.01, 5, "obj-21", "umenu", "int", 2, 5, "obj-16", "umenu", "int", 0, 5, "obj-13", "toggle", "int", 1, 5, "obj-2", "flonum", "float", -111.0 ]
						}
, 						{
							"number" : 5,
							"data" : [ 20, "obj-114", "multislider", "list", 71, 71, 64, 52, 52, 52, 83, 83, 71, 71, 71, 71, 76, 76, 52, 85, 5, "obj-110", "led", "int", 1, 5, "obj-108", "number", "int", 0, 5, "obj-107", "led", "int", 0, 5, "obj-106", "led", "int", 0, 5, "obj-105", "led", "int", 0, 5, "obj-104", "led", "int", 0, 5, "obj-103", "led", "int", 0, 5, "obj-102", "led", "int", 0, 5, "obj-101", "led", "int", 0, 5, "obj-100", "led", "int", 0, 5, "obj-99", "led", "int", 0, 5, "obj-98", "led", "int", 0, 5, "obj-97", "led", "int", 0, 5, "obj-96", "led", "int", 0, 5, "obj-95", "led", "int", 0, 5, "obj-94", "led", "int", 0, 5, "obj-93", "led", "int", 0, 20, "obj-92", "multislider", "list", 23, 9, 6, 54, 0, 48, 0, 29, -21, 14, -34, -7, 0, -23, 0, 0, 5, "obj-90", "led", "int", 1, 5, "obj-89", "led", "int", 0, 5, "obj-88", "led", "int", 0, 5, "obj-87", "led", "int", 0, 5, "obj-86", "led", "int", 0, 5, "obj-85", "led", "int", 0, 5, "obj-84", "led", "int", 0, 5, "obj-83", "led", "int", 0, 5, "obj-82", "led", "int", 0, 5, "obj-81", "led", "int", 0, 5, "obj-80", "led", "int", 0, 5, "obj-79", "led", "int", 0, 5, "obj-78", "led", "int", 0, 5, "obj-77", "led", "int", 0, 5, "obj-76", "led", "int", 0, 5, "obj-75", "led", "int", 0, 5, "obj-70", "flonum", "float", 0.01, 5, "obj-68", "flonum", "float", 0.08, 5, "obj-66", "flonum", "float", 10.0, 5, "obj-63", "flonum", "float", 2825.0, 5, "obj-61", "flonum", "float", 0.59, 5, "obj-59", "flonum", "float", 3.0, 5, "obj-58", "flonum", "float", -10.0, 5, "obj-47", "flonum", "float", 0.0, 5, "obj-44", "flonum", "float", -16.0, 5, "obj-31", "flonum", "float", 0.42, 5, "obj-27", "umenu", "int", 2, 5, "obj-23", "flonum", "float", 1.01, 5, "obj-21", "umenu", "int", 0, 5, "obj-16", "umenu", "int", 0, 5, "obj-13", "toggle", "int", 1, 5, "obj-2", "flonum", "float", 96.0 ]
						}
, 						{
							"number" : 6,
							"data" : [ 20, "obj-114", "multislider", "list", 71, 71, 64, 52, 52, 52, 83, 83, 71, 59, 71, 64, 76, 83, 52, 85, 5, "obj-110", "led", "int", 0, 5, "obj-108", "number", "int", 15, 5, "obj-107", "led", "int", 0, 5, "obj-106", "led", "int", 0, 5, "obj-105", "led", "int", 0, 5, "obj-104", "led", "int", 0, 5, "obj-103", "led", "int", 0, 5, "obj-102", "led", "int", 0, 5, "obj-101", "led", "int", 0, 5, "obj-100", "led", "int", 0, 5, "obj-99", "led", "int", 0, 5, "obj-98", "led", "int", 0, 5, "obj-97", "led", "int", 0, 5, "obj-96", "led", "int", 0, 5, "obj-95", "led", "int", 0, 5, "obj-94", "led", "int", 0, 5, "obj-93", "led", "int", 1, 20, "obj-92", "multislider", "list", 23, -21, -8, 28, 0, 28, 0, 29, -21, 14, -34, -7, 0, 29, 0, 0, 5, "obj-90", "led", "int", 0, 5, "obj-89", "led", "int", 0, 5, "obj-88", "led", "int", 0, 5, "obj-87", "led", "int", 0, 5, "obj-86", "led", "int", 0, 5, "obj-85", "led", "int", 0, 5, "obj-84", "led", "int", 0, 5, "obj-83", "led", "int", 0, 5, "obj-82", "led", "int", 0, 5, "obj-81", "led", "int", 0, 5, "obj-80", "led", "int", 0, 5, "obj-79", "led", "int", 0, 5, "obj-78", "led", "int", 0, 5, "obj-77", "led", "int", 0, 5, "obj-76", "led", "int", 0, 5, "obj-75", "led", "int", 1, 5, "obj-70", "flonum", "float", 0.01, 5, "obj-68", "flonum", "float", 0.08, 5, "obj-66", "flonum", "float", 10.0, 5, "obj-63", "flonum", "float", 2825.0, 5, "obj-61", "flonum", "float", 0.59, 5, "obj-59", "flonum", "float", 3.0, 5, "obj-58", "flonum", "float", -10.0, 5, "obj-47", "flonum", "float", 0.0, 5, "obj-44", "flonum", "float", -16.0, 5, "obj-31", "flonum", "float", 0.42, 5, "obj-27", "umenu", "int", 2, 5, "obj-23", "flonum", "float", 1.01, 5, "obj-21", "umenu", "int", 0, 5, "obj-16", "umenu", "int", 0, 5, "obj-13", "toggle", "int", 1, 5, "obj-2", "flonum", "float", 96.0, 5, "obj-125", "number", "int", 1 ]
						}
, 						{
							"number" : 7,
							"data" : [ 20, "obj-114", "multislider", "list", 43, 76, 45, 52, 64, 57, 69, 57, 45, 45, 76, 76, 76, 64, 57, 57, 5, "obj-110", "led", "int", 0, 5, "obj-108", "number", "int", 4, 5, "obj-107", "led", "int", 0, 5, "obj-106", "led", "int", 0, 5, "obj-105", "led", "int", 0, 5, "obj-104", "led", "int", 1, 5, "obj-103", "led", "int", 0, 5, "obj-102", "led", "int", 0, 5, "obj-101", "led", "int", 0, 5, "obj-100", "led", "int", 0, 5, "obj-99", "led", "int", 0, 5, "obj-98", "led", "int", 0, 5, "obj-97", "led", "int", 0, 5, "obj-96", "led", "int", 0, 5, "obj-95", "led", "int", 0, 5, "obj-94", "led", "int", 0, 5, "obj-93", "led", "int", 0, 20, "obj-92", "multislider", "list", 23, -21, -8, 28, 0, 28, 0, 29, -21, 14, -34, -7, 0, 29, 0, 0, 5, "obj-90", "led", "int", 0, 5, "obj-89", "led", "int", 0, 5, "obj-88", "led", "int", 0, 5, "obj-87", "led", "int", 0, 5, "obj-86", "led", "int", 1, 5, "obj-85", "led", "int", 0, 5, "obj-84", "led", "int", 0, 5, "obj-83", "led", "int", 0, 5, "obj-82", "led", "int", 0, 5, "obj-81", "led", "int", 0, 5, "obj-80", "led", "int", 0, 5, "obj-79", "led", "int", 0, 5, "obj-78", "led", "int", 0, 5, "obj-77", "led", "int", 0, 5, "obj-76", "led", "int", 0, 5, "obj-75", "led", "int", 0, 5, "obj-70", "flonum", "float", 0.01, 5, "obj-68", "flonum", "float", 0.08, 5, "obj-66", "flonum", "float", 6.0, 5, "obj-63", "flonum", "float", 2825.0, 5, "obj-61", "flonum", "float", 0.59, 5, "obj-59", "flonum", "float", 3.0, 5, "obj-58", "flonum", "float", -10.0, 5, "obj-47", "flonum", "float", 6.0, 5, "obj-44", "flonum", "float", -12.0, 5, "obj-31", "flonum", "float", 0.6, 5, "obj-27", "umenu", "int", 2, 5, "obj-23", "flonum", "float", 1.01, 5, "obj-21", "umenu", "int", 0, 5, "obj-16", "umenu", "int", 0, 5, "obj-13", "toggle", "int", 1, 5, "obj-2", "flonum", "float", 96.0, 5, "obj-125", "number", "int", 1 ]
						}
, 						{
							"number" : 8,
							"data" : [ 20, "obj-114", "multislider", "list", 71, 71, 64, 52, 52, 52, 83, 83, 56, 59, 71, 64, 76, 83, 52, 83, 5, "obj-110", "led", "int", 0, 5, "obj-108", "number", "int", 1, 5, "obj-107", "led", "int", 1, 5, "obj-106", "led", "int", 0, 5, "obj-105", "led", "int", 0, 5, "obj-104", "led", "int", 0, 5, "obj-103", "led", "int", 0, 5, "obj-102", "led", "int", 0, 5, "obj-101", "led", "int", 0, 5, "obj-100", "led", "int", 0, 5, "obj-99", "led", "int", 0, 5, "obj-98", "led", "int", 0, 5, "obj-97", "led", "int", 0, 5, "obj-96", "led", "int", 0, 5, "obj-95", "led", "int", 0, 5, "obj-94", "led", "int", 0, 5, "obj-93", "led", "int", 0, 20, "obj-92", "multislider", "list", -21, 30, -7, 1, 29, 0, 0, 23, -21, -8, 28, 0, 28, 0, 29, -21, 5, "obj-90", "led", "int", 0, 5, "obj-89", "led", "int", 1, 5, "obj-88", "led", "int", 0, 5, "obj-87", "led", "int", 0, 5, "obj-86", "led", "int", 0, 5, "obj-85", "led", "int", 0, 5, "obj-84", "led", "int", 0, 5, "obj-83", "led", "int", 0, 5, "obj-82", "led", "int", 0, 5, "obj-81", "led", "int", 0, 5, "obj-80", "led", "int", 0, 5, "obj-79", "led", "int", 0, 5, "obj-78", "led", "int", 0, 5, "obj-77", "led", "int", 0, 5, "obj-76", "led", "int", 0, 5, "obj-75", "led", "int", 0, 5, "obj-70", "flonum", "float", 0.21, 5, "obj-68", "flonum", "float", 0.2, 5, "obj-66", "flonum", "float", 9.0, 5, "obj-63", "flonum", "float", 3041.0, 5, "obj-61", "flonum", "float", 0.704, 5, "obj-59", "flonum", "float", 3.0, 5, "obj-58", "flonum", "float", -5.9, 5, "obj-47", "flonum", "float", -4.0, 5, "obj-44", "flonum", "float", -16.0, 5, "obj-31", "flonum", "float", -0.6, 5, "obj-27", "umenu", "int", 0, 5, "obj-23", "flonum", "float", 1.03, 5, "obj-21", "umenu", "int", 0, 5, "obj-16", "umenu", "int", 0, 5, "obj-13", "toggle", "int", 1, 5, "obj-2", "flonum", "float", -125.0, 5, "obj-125", "number", "int", 1, 5, "obj-73", "flonum", "float", 0.166 ]
						}
 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "led",
					"id" : "obj-75",
					"oncolor" : [ 0.0, 1.0, 0.0, 1.0 ],
					"offcolor" : [ 0.0, 0.266667, 0.0, 1.0 ],
					"patching_rect" : [ 705.0, 470.0, 17.0, 17.0 ],
					"numinlets" : 1,
					"blinktime" : 500,
					"numoutlets" : 1,
					"bgcolor" : [ 0.223529, 0.223529, 0.223529, 1.0 ],
					"outlettype" : [ "int" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "led",
					"id" : "obj-76",
					"oncolor" : [ 0.0, 1.0, 0.0, 1.0 ],
					"offcolor" : [ 0.0, 0.266667, 0.0, 1.0 ],
					"patching_rect" : [ 688.0, 470.0, 17.0, 17.0 ],
					"numinlets" : 1,
					"blinktime" : 500,
					"numoutlets" : 1,
					"bgcolor" : [ 0.223529, 0.223529, 0.223529, 1.0 ],
					"outlettype" : [ "int" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "led",
					"id" : "obj-77",
					"oncolor" : [ 0.0, 1.0, 0.0, 1.0 ],
					"offcolor" : [ 0.0, 0.266667, 0.0, 1.0 ],
					"patching_rect" : [ 671.0, 470.0, 17.0, 17.0 ],
					"numinlets" : 1,
					"blinktime" : 500,
					"numoutlets" : 1,
					"bgcolor" : [ 0.223529, 0.223529, 0.223529, 1.0 ],
					"outlettype" : [ "int" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "led",
					"id" : "obj-78",
					"oncolor" : [ 1.0, 0.501961, 0.0, 1.0 ],
					"offcolor" : [ 0.266667, 0.211765, 0.0, 1.0 ],
					"patching_rect" : [ 654.0, 470.0, 17.0, 17.0 ],
					"numinlets" : 1,
					"blinktime" : 500,
					"numoutlets" : 1,
					"bgcolor" : [ 0.223529, 0.223529, 0.223529, 1.0 ],
					"outlettype" : [ "int" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "led",
					"id" : "obj-79",
					"oncolor" : [ 0.0, 1.0, 0.0, 1.0 ],
					"offcolor" : [ 0.0, 0.266667, 0.0, 1.0 ],
					"patching_rect" : [ 637.0, 470.0, 17.0, 17.0 ],
					"numinlets" : 1,
					"blinktime" : 500,
					"numoutlets" : 1,
					"bgcolor" : [ 0.223529, 0.223529, 0.223529, 1.0 ],
					"outlettype" : [ "int" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "led",
					"id" : "obj-80",
					"oncolor" : [ 0.0, 1.0, 0.0, 1.0 ],
					"offcolor" : [ 0.0, 0.266667, 0.0, 1.0 ],
					"patching_rect" : [ 620.0, 470.0, 17.0, 17.0 ],
					"numinlets" : 1,
					"blinktime" : 500,
					"numoutlets" : 1,
					"bgcolor" : [ 0.223529, 0.223529, 0.223529, 1.0 ],
					"outlettype" : [ "int" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "led",
					"id" : "obj-81",
					"oncolor" : [ 0.0, 1.0, 0.0, 1.0 ],
					"offcolor" : [ 0.0, 0.266667, 0.0, 1.0 ],
					"patching_rect" : [ 603.0, 470.0, 17.0, 17.0 ],
					"numinlets" : 1,
					"blinktime" : 500,
					"numoutlets" : 1,
					"bgcolor" : [ 0.223529, 0.223529, 0.223529, 1.0 ],
					"outlettype" : [ "int" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "led",
					"id" : "obj-82",
					"oncolor" : [ 0.0, 1.0, 1.0, 1.0 ],
					"offcolor" : [ 0.0, 0.0, 0.466667, 1.0 ],
					"patching_rect" : [ 586.0, 470.0, 17.0, 17.0 ],
					"numinlets" : 1,
					"blinktime" : 500,
					"numoutlets" : 1,
					"bgcolor" : [ 0.223529, 0.223529, 0.223529, 1.0 ],
					"outlettype" : [ "int" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "led",
					"id" : "obj-83",
					"oncolor" : [ 0.0, 1.0, 0.0, 1.0 ],
					"offcolor" : [ 0.0, 0.266667, 0.0, 1.0 ],
					"patching_rect" : [ 569.0, 470.0, 17.0, 17.0 ],
					"numinlets" : 1,
					"blinktime" : 500,
					"numoutlets" : 1,
					"bgcolor" : [ 0.223529, 0.223529, 0.223529, 1.0 ],
					"outlettype" : [ "int" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "led",
					"id" : "obj-84",
					"oncolor" : [ 0.0, 1.0, 0.0, 1.0 ],
					"offcolor" : [ 0.0, 0.266667, 0.0, 1.0 ],
					"patching_rect" : [ 552.0, 470.0, 17.0, 17.0 ],
					"numinlets" : 1,
					"blinktime" : 500,
					"numoutlets" : 1,
					"bgcolor" : [ 0.223529, 0.223529, 0.223529, 1.0 ],
					"outlettype" : [ "int" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "led",
					"id" : "obj-85",
					"oncolor" : [ 0.0, 1.0, 0.0, 1.0 ],
					"offcolor" : [ 0.0, 0.266667, 0.0, 1.0 ],
					"patching_rect" : [ 535.0, 470.0, 17.0, 17.0 ],
					"numinlets" : 1,
					"blinktime" : 500,
					"numoutlets" : 1,
					"bgcolor" : [ 0.223529, 0.223529, 0.223529, 1.0 ],
					"outlettype" : [ "int" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "led",
					"id" : "obj-86",
					"oncolor" : [ 1.0, 0.501961, 0.0, 1.0 ],
					"offcolor" : [ 0.266667, 0.211765, 0.0, 1.0 ],
					"patching_rect" : [ 518.0, 470.0, 17.0, 17.0 ],
					"numinlets" : 1,
					"blinktime" : 500,
					"numoutlets" : 1,
					"bgcolor" : [ 0.223529, 0.223529, 0.223529, 1.0 ],
					"outlettype" : [ "int" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "led",
					"id" : "obj-87",
					"oncolor" : [ 0.0, 1.0, 0.0, 1.0 ],
					"offcolor" : [ 0.0, 0.266667, 0.0, 1.0 ],
					"patching_rect" : [ 501.0, 470.0, 17.0, 17.0 ],
					"numinlets" : 1,
					"blinktime" : 500,
					"numoutlets" : 1,
					"bgcolor" : [ 0.223529, 0.223529, 0.223529, 1.0 ],
					"outlettype" : [ "int" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "led",
					"id" : "obj-88",
					"oncolor" : [ 0.0, 1.0, 0.0, 1.0 ],
					"offcolor" : [ 0.0, 0.266667, 0.0, 1.0 ],
					"patching_rect" : [ 484.0, 470.0, 17.0, 17.0 ],
					"numinlets" : 1,
					"blinktime" : 500,
					"numoutlets" : 1,
					"bgcolor" : [ 0.223529, 0.223529, 0.223529, 1.0 ],
					"outlettype" : [ "int" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "led",
					"id" : "obj-89",
					"oncolor" : [ 0.0, 1.0, 0.0, 1.0 ],
					"offcolor" : [ 0.0, 0.266667, 0.0, 1.0 ],
					"patching_rect" : [ 467.0, 470.0, 17.0, 17.0 ],
					"numinlets" : 1,
					"blinktime" : 500,
					"numoutlets" : 1,
					"bgcolor" : [ 0.223529, 0.223529, 0.223529, 1.0 ],
					"outlettype" : [ "int" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "led",
					"id" : "obj-90",
					"oncolor" : [ 0.0, 1.0, 1.0, 1.0 ],
					"offcolor" : [ 0.0, 0.0, 0.466667, 1.0 ],
					"patching_rect" : [ 450.0, 470.0, 17.0, 17.0 ],
					"numinlets" : 1,
					"blinktime" : 500,
					"numoutlets" : 1,
					"bgcolor" : [ 0.223529, 0.223529, 0.223529, 1.0 ],
					"outlettype" : [ "int" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "decode 16",
					"id" : "obj-91",
					"fontsize" : 12.0,
					"patching_rect" : [ 450.0, 452.0, 351.0, 20.0 ],
					"hidden" : 1,
					"numinlets" : 3,
					"numoutlets" : 16,
					"fontname" : "Arial",
					"outlettype" : [ "int", "int", "int", "int", "int", "int", "int", "int", "int", "int", "int", "int", "int", "int", "int", "int" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "multislider",
					"peakcolor" : [ 0.498039, 0.498039, 0.498039, 1.0 ],
					"contdata" : 1,
					"candicane3" : [ 0.290196, 0.411765, 0.713726, 1.0 ],
					"id" : "obj-92",
					"size" : 16,
					"candicane8" : [ 0.027451, 0.447059, 0.501961, 1.0 ],
					"candicane2" : [ 0.145098, 0.203922, 0.356863, 1.0 ],
					"candicane7" : [ 0.878431, 0.243137, 0.145098, 1.0 ],
					"settype" : 0,
					"patching_rect" : [ 450.0, 487.0, 272.0, 166.0 ],
					"candicane6" : [ 0.733333, 0.035294, 0.788235, 1.0 ],
					"numinlets" : 1,
					"candicane5" : [ 0.584314, 0.827451, 0.431373, 1.0 ],
					"numoutlets" : 2,
					"setminmax" : [ -63.0, 63.0 ],
					"candicane4" : [ 0.439216, 0.619608, 0.070588, 1.0 ],
					"outlettype" : [ "", "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "led",
					"id" : "obj-93",
					"oncolor" : [ 0.0, 1.0, 0.0, 1.0 ],
					"offcolor" : [ 0.0, 0.266667, 0.0, 1.0 ],
					"patching_rect" : [ 705.0, 266.0, 17.0, 17.0 ],
					"numinlets" : 1,
					"blinktime" : 500,
					"numoutlets" : 1,
					"bgcolor" : [ 0.223529, 0.223529, 0.223529, 1.0 ],
					"outlettype" : [ "int" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "led",
					"id" : "obj-94",
					"oncolor" : [ 0.0, 1.0, 0.0, 1.0 ],
					"offcolor" : [ 0.0, 0.266667, 0.0, 1.0 ],
					"patching_rect" : [ 688.0, 266.0, 17.0, 17.0 ],
					"numinlets" : 1,
					"blinktime" : 500,
					"numoutlets" : 1,
					"bgcolor" : [ 0.223529, 0.223529, 0.223529, 1.0 ],
					"outlettype" : [ "int" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "led",
					"id" : "obj-95",
					"oncolor" : [ 0.0, 1.0, 0.0, 1.0 ],
					"offcolor" : [ 0.0, 0.266667, 0.0, 1.0 ],
					"patching_rect" : [ 671.0, 266.0, 17.0, 17.0 ],
					"numinlets" : 1,
					"blinktime" : 500,
					"numoutlets" : 1,
					"bgcolor" : [ 0.223529, 0.223529, 0.223529, 1.0 ],
					"outlettype" : [ "int" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "led",
					"id" : "obj-96",
					"oncolor" : [ 1.0, 0.501961, 0.0, 1.0 ],
					"offcolor" : [ 0.266667, 0.211765, 0.0, 1.0 ],
					"patching_rect" : [ 654.0, 266.0, 17.0, 17.0 ],
					"numinlets" : 1,
					"blinktime" : 500,
					"numoutlets" : 1,
					"bgcolor" : [ 0.223529, 0.223529, 0.223529, 1.0 ],
					"outlettype" : [ "int" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "led",
					"id" : "obj-97",
					"oncolor" : [ 0.0, 1.0, 0.0, 1.0 ],
					"offcolor" : [ 0.0, 0.266667, 0.0, 1.0 ],
					"patching_rect" : [ 637.0, 266.0, 17.0, 17.0 ],
					"numinlets" : 1,
					"blinktime" : 500,
					"numoutlets" : 1,
					"bgcolor" : [ 0.223529, 0.223529, 0.223529, 1.0 ],
					"outlettype" : [ "int" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "led",
					"id" : "obj-98",
					"oncolor" : [ 0.0, 1.0, 0.0, 1.0 ],
					"offcolor" : [ 0.0, 0.266667, 0.0, 1.0 ],
					"patching_rect" : [ 620.0, 266.0, 17.0, 17.0 ],
					"numinlets" : 1,
					"blinktime" : 500,
					"numoutlets" : 1,
					"bgcolor" : [ 0.223529, 0.223529, 0.223529, 1.0 ],
					"outlettype" : [ "int" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "led",
					"id" : "obj-99",
					"oncolor" : [ 0.0, 1.0, 0.0, 1.0 ],
					"offcolor" : [ 0.0, 0.266667, 0.0, 1.0 ],
					"patching_rect" : [ 603.0, 266.0, 17.0, 17.0 ],
					"numinlets" : 1,
					"blinktime" : 500,
					"numoutlets" : 1,
					"bgcolor" : [ 0.223529, 0.223529, 0.223529, 1.0 ],
					"outlettype" : [ "int" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "led",
					"id" : "obj-100",
					"oncolor" : [ 0.0, 1.0, 1.0, 1.0 ],
					"offcolor" : [ 0.0, 0.0, 0.466667, 1.0 ],
					"patching_rect" : [ 586.0, 266.0, 17.0, 17.0 ],
					"numinlets" : 1,
					"blinktime" : 500,
					"numoutlets" : 1,
					"bgcolor" : [ 0.223529, 0.223529, 0.223529, 1.0 ],
					"outlettype" : [ "int" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "led",
					"id" : "obj-101",
					"oncolor" : [ 0.0, 1.0, 0.0, 1.0 ],
					"offcolor" : [ 0.0, 0.266667, 0.0, 1.0 ],
					"patching_rect" : [ 569.0, 266.0, 17.0, 17.0 ],
					"numinlets" : 1,
					"blinktime" : 500,
					"numoutlets" : 1,
					"bgcolor" : [ 0.223529, 0.223529, 0.223529, 1.0 ],
					"outlettype" : [ "int" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "led",
					"id" : "obj-102",
					"oncolor" : [ 0.0, 1.0, 0.0, 1.0 ],
					"offcolor" : [ 0.0, 0.266667, 0.0, 1.0 ],
					"patching_rect" : [ 552.0, 266.0, 17.0, 17.0 ],
					"numinlets" : 1,
					"blinktime" : 500,
					"numoutlets" : 1,
					"bgcolor" : [ 0.223529, 0.223529, 0.223529, 1.0 ],
					"outlettype" : [ "int" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "led",
					"id" : "obj-103",
					"oncolor" : [ 0.0, 1.0, 0.0, 1.0 ],
					"offcolor" : [ 0.0, 0.266667, 0.0, 1.0 ],
					"patching_rect" : [ 535.0, 266.0, 17.0, 17.0 ],
					"numinlets" : 1,
					"blinktime" : 500,
					"numoutlets" : 1,
					"bgcolor" : [ 0.223529, 0.223529, 0.223529, 1.0 ],
					"outlettype" : [ "int" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "led",
					"id" : "obj-104",
					"oncolor" : [ 1.0, 0.501961, 0.0, 1.0 ],
					"offcolor" : [ 0.266667, 0.211765, 0.0, 1.0 ],
					"patching_rect" : [ 518.0, 266.0, 17.0, 17.0 ],
					"numinlets" : 1,
					"blinktime" : 500,
					"numoutlets" : 1,
					"bgcolor" : [ 0.223529, 0.223529, 0.223529, 1.0 ],
					"outlettype" : [ "int" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "led",
					"id" : "obj-105",
					"oncolor" : [ 0.0, 1.0, 0.0, 1.0 ],
					"offcolor" : [ 0.0, 0.266667, 0.0, 1.0 ],
					"patching_rect" : [ 501.0, 266.0, 17.0, 17.0 ],
					"numinlets" : 1,
					"blinktime" : 500,
					"numoutlets" : 1,
					"bgcolor" : [ 0.223529, 0.223529, 0.223529, 1.0 ],
					"outlettype" : [ "int" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "led",
					"id" : "obj-106",
					"oncolor" : [ 0.0, 1.0, 0.0, 1.0 ],
					"offcolor" : [ 0.0, 0.266667, 0.0, 1.0 ],
					"patching_rect" : [ 484.0, 266.0, 17.0, 17.0 ],
					"numinlets" : 1,
					"blinktime" : 500,
					"numoutlets" : 1,
					"bgcolor" : [ 0.223529, 0.223529, 0.223529, 1.0 ],
					"outlettype" : [ "int" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "led",
					"id" : "obj-107",
					"oncolor" : [ 0.0, 1.0, 0.0, 1.0 ],
					"offcolor" : [ 0.0, 0.266667, 0.0, 1.0 ],
					"patching_rect" : [ 467.0, 266.0, 17.0, 17.0 ],
					"numinlets" : 1,
					"blinktime" : 500,
					"numoutlets" : 1,
					"bgcolor" : [ 0.223529, 0.223529, 0.223529, 1.0 ],
					"outlettype" : [ "int" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "number",
					"id" : "obj-108",
					"fontface" : 1,
					"fontsize" : 12.0,
					"patching_rect" : [ 161.0, 230.0, 41.0, 20.0 ],
					"numinlets" : 1,
					"numoutlets" : 2,
					"htextcolor" : [ 0.870588, 0.870588, 0.870588, 1.0 ],
					"bgcolor" : [ 0.866667, 0.866667, 0.866667, 1.0 ],
					"fontname" : "Arial",
					"triscale" : 0.9,
					"outlettype" : [ "int", "bang" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "stop",
					"id" : "obj-109",
					"fontsize" : 12.0,
					"patching_rect" : [ 86.0, 52.0, 35.0, 18.0 ],
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontname" : "Arial",
					"outlettype" : [ "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "led",
					"id" : "obj-110",
					"oncolor" : [ 0.0, 1.0, 1.0, 1.0 ],
					"offcolor" : [ 0.0, 0.0, 0.466667, 1.0 ],
					"patching_rect" : [ 450.0, 266.0, 17.0, 17.0 ],
					"numinlets" : 1,
					"blinktime" : 500,
					"numoutlets" : 1,
					"bgcolor" : [ 0.223529, 0.223529, 0.223529, 1.0 ],
					"outlettype" : [ "int" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "decode 16",
					"id" : "obj-111",
					"fontsize" : 12.0,
					"patching_rect" : [ 450.0, 246.0, 351.0, 20.0 ],
					"hidden" : 1,
					"numinlets" : 3,
					"numoutlets" : 16,
					"fontname" : "Arial",
					"outlettype" : [ "int", "int", "int", "int", "int", "int", "int", "int", "int", "int", "int", "int", "int", "int", "int", "int" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "pattrforward csIN",
					"id" : "obj-112",
					"fontsize" : 12.0,
					"patching_rect" : [ 735.0, 430.0, 102.0, 20.0 ],
					"hidden" : 1,
					"numinlets" : 1,
					"numoutlets" : 1,
					"fontname" : "Arial",
					"outlettype" : [ "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"varname" : "csIN",
					"text" : "t l",
					"id" : "obj-113",
					"fontsize" : 12.0,
					"patching_rect" : [ 102.0, 109.0, 21.0, 20.0 ],
					"numinlets" : 1,
					"numoutlets" : 1,
					"fontname" : "Arial",
					"outlettype" : [ "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "multislider",
					"peakcolor" : [ 0.498039, 0.498039, 0.498039, 1.0 ],
					"contdata" : 1,
					"candicane3" : [ 0.290196, 0.411765, 0.713726, 1.0 ],
					"id" : "obj-114",
					"size" : 16,
					"candicane8" : [ 0.027451, 0.447059, 0.501961, 1.0 ],
					"candicane2" : [ 0.145098, 0.203922, 0.356863, 1.0 ],
					"candicane7" : [ 0.878431, 0.243137, 0.145098, 1.0 ],
					"settype" : 0,
					"patching_rect" : [ 450.0, 282.0, 272.0, 167.0 ],
					"candicane6" : [ 0.733333, 0.035294, 0.788235, 1.0 ],
					"numinlets" : 1,
					"candicane5" : [ 0.584314, 0.827451, 0.431373, 1.0 ],
					"numoutlets" : 2,
					"setminmax" : [ 40.0, 96.0 ],
					"candicane4" : [ 0.439216, 0.619608, 0.070588, 1.0 ],
					"outlettype" : [ "", "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "route idx",
					"id" : "obj-116",
					"fontsize" : 12.0,
					"patching_rect" : [ 161.0, 207.0, 66.0, 20.0 ],
					"numinlets" : 1,
					"numoutlets" : 2,
					"fontname" : "Arial",
					"outlettype" : [ "", "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "105",
					"id" : "obj-117",
					"fontsize" : 12.0,
					"patching_rect" : [ 45.0, 34.0, 32.0, 18.0 ],
					"hidden" : 1,
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontname" : "Arial",
					"outlettype" : [ "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "ezdac~",
					"offgradcolor1" : [ 0.392157, 0.392157, 0.392157, 1.0 ],
					"ongradcolor1" : [ 1.0, 0.0, 0.0, 1.0 ],
					"id" : "obj-118",
					"ongradcolor2" : [ 1.0, 1.0, 0.133333, 1.0 ],
					"offgradcolor2" : [ 0.0, 0.0, 0.0, 1.0 ],
					"patching_rect" : [ 45.0, 226.0, 51.0, 51.0 ],
					"numinlets" : 2,
					"numoutlets" : 0,
					"bgcolor" : [ 0.0, 0.0, 0.0, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "t b b 1",
					"id" : "obj-119",
					"fontsize" : 12.0,
					"patching_rect" : [ 123.0, 31.0, 55.0, 20.0 ],
					"hidden" : 1,
					"numinlets" : 1,
					"numoutlets" : 3,
					"fontname" : "Arial",
					"outlettype" : [ "bang", "bang", "int" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "loadbang",
					"id" : "obj-120",
					"fontsize" : 12.0,
					"patching_rect" : [ 123.0, 8.0, 61.0, 20.0 ],
					"hidden" : 1,
					"numinlets" : 1,
					"numoutlets" : 1,
					"fontname" : "Arial",
					"outlettype" : [ "bang" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "button",
					"id" : "obj-121",
					"patching_rect" : [ 123.0, 52.0, 18.0, 18.0 ],
					"numinlets" : 1,
					"numoutlets" : 1,
					"fgcolor" : [ 0.156863, 0.8, 0.54902, 1.0 ],
					"outlettype" : [ "bang" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "csound wsidx_monosynth.csd",
					"id" : "obj-122",
					"fontsize" : 12.0,
					"patching_rect" : [ 150.0, 60.0, 176.0, 18.0 ],
					"numinlets" : 2,
					"numoutlets" : 1,
					"bgcolor" : [ 1.0, 0.890196, 0.090196, 1.0 ],
					"fontname" : "Arial",
					"outlettype" : [ "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "csound~",
					"id" : "obj-123",
					"fontsize" : 12.0,
					"patching_rect" : [ 123.0, 109.0, 113.0, 20.0 ],
					"numinlets" : 2,
					"numoutlets" : 6,
					"fontname" : "Arial",
					"outlettype" : [ "signal", "signal", "list", "int", "bang", "bang" ],
					"saved_object_attributes" : 					{
						"bypass" : 0,
						"message" : 1,
						"input" : 1,
						"interval" : 10,
						"args" : "",
						"output" : 1,
						"autostart" : 0,
						"matchsr" : 1,
						"overdrive" : 1
					}

				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "csIN",
					"id" : "obj-124",
					"textcolor" : [ 0.839216, 0.0, 0.0, 1.0 ],
					"fontsize" : 12.0,
					"patching_rect" : [ 72.0, 110.0, 35.0, 20.0 ],
					"numinlets" : 1,
					"frgb" : [ 0.839216, 0.0, 0.0, 1.0 ],
					"numoutlets" : 0,
					"fontname" : "Arial"
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"source" : [ "obj-108", 0 ],
					"destination" : [ "obj-111", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-108", 0 ],
					"destination" : [ "obj-91", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-139", 0 ],
					"destination" : [ "obj-114", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-141", 0 ],
					"destination" : [ "obj-114", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-143", 0 ],
					"destination" : [ "obj-114", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-145", 0 ],
					"destination" : [ "obj-114", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-114", 0 ],
					"destination" : [ "obj-139", 1 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-114", 0 ],
					"destination" : [ "obj-141", 1 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-114", 0 ],
					"destination" : [ "obj-143", 1 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-114", 0 ],
					"destination" : [ "obj-145", 1 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-138", 0 ],
					"destination" : [ "obj-139", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-140", 0 ],
					"destination" : [ "obj-141", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-142", 0 ],
					"destination" : [ "obj-143", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-144", 0 ],
					"destination" : [ "obj-145", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-92", 0 ],
					"destination" : [ "obj-129", 1 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-92", 0 ],
					"destination" : [ "obj-131", 1 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-92", 0 ],
					"destination" : [ "obj-133", 1 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-92", 0 ],
					"destination" : [ "obj-135", 1 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-129", 0 ],
					"destination" : [ "obj-92", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-131", 0 ],
					"destination" : [ "obj-92", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-133", 0 ],
					"destination" : [ "obj-92", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-135", 0 ],
					"destination" : [ "obj-92", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-35", 0 ],
					"destination" : [ "obj-92", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-11", 0 ],
					"destination" : [ "obj-10", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-12", 0 ],
					"destination" : [ "obj-112", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-134", 0 ],
					"destination" : [ "obj-135", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-132", 0 ],
					"destination" : [ "obj-133", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-130", 0 ],
					"destination" : [ "obj-131", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-128", 0 ],
					"destination" : [ "obj-129", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-19", 0 ],
					"destination" : [ "obj-24", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-19", 0 ],
					"destination" : [ "obj-17", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-120", 0 ],
					"destination" : [ "obj-117", 0 ],
					"hidden" : 1,
					"midpoints" : [ 132.5, 28.0, 54.5, 28.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-74", 2 ],
					"destination" : [ "obj-19", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-25", 0 ],
					"destination" : [ "obj-19", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-117", 0 ],
					"destination" : [ "obj-19", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-19", 0 ],
					"destination" : [ "obj-118", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-74", 2 ],
					"destination" : [ "obj-28", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-19", 1 ],
					"destination" : [ "obj-28", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-19", 0 ],
					"destination" : [ "obj-118", 1 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-8", 0 ],
					"destination" : [ "obj-7", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-28", 0 ],
					"destination" : [ "obj-25", 1 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-116", 0 ],
					"destination" : [ "obj-108", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-2", 0 ],
					"destination" : [ "obj-1", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-1", 0 ],
					"destination" : [ "obj-72", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-72", 0 ],
					"destination" : [ "obj-3", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-27", 0 ],
					"destination" : [ "obj-26", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-14", 0 ],
					"destination" : [ "obj-6", 0 ],
					"hidden" : 1,
					"midpoints" : [ 688.5, 240.0, 291.5, 240.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-15", 0 ],
					"destination" : [ "obj-6", 0 ],
					"hidden" : 1,
					"midpoints" : [ 578.5, 240.0, 291.5, 240.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-30", 0 ],
					"destination" : [ "obj-6", 0 ],
					"hidden" : 1,
					"midpoints" : [ 516.5, 240.0, 291.5, 240.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-67", 0 ],
					"destination" : [ "obj-6", 0 ],
					"hidden" : 1,
					"midpoints" : [ 458.5, 240.0, 291.5, 240.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-65", 0 ],
					"destination" : [ "obj-6", 0 ],
					"hidden" : 1,
					"midpoints" : [ 406.5, 240.0, 291.5, 240.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-46", 0 ],
					"destination" : [ "obj-6", 0 ],
					"hidden" : 1,
					"midpoints" : [ 347.5, 240.0, 291.5, 240.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-26", 0 ],
					"destination" : [ "obj-6", 0 ],
					"hidden" : 1,
					"midpoints" : [ 291.5, 240.0, 291.5, 240.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-47", 0 ],
					"destination" : [ "obj-46", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-38", 0 ],
					"destination" : [ "obj-39", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-36", 0 ],
					"destination" : [ "obj-37", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-114", 0 ],
					"destination" : [ "obj-39", 1 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-44", 0 ],
					"destination" : [ "obj-43", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-69", 0 ],
					"destination" : [ "obj-71", 0 ],
					"hidden" : 1,
					"midpoints" : [ 528.5, 73.0, 408.5, 73.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-43", 0 ],
					"destination" : [ "obj-71", 0 ],
					"hidden" : 1,
					"midpoints" : [ 408.5, 73.0, 408.5, 73.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-114", 0 ],
					"destination" : [ "obj-37", 1 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-66", 0 ],
					"destination" : [ "obj-65", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-111", 0 ],
					"destination" : [ "obj-110", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-37", 0 ],
					"destination" : [ "obj-114", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-39", 0 ],
					"destination" : [ "obj-114", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-114", 0 ],
					"destination" : [ "obj-12", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-111", 1 ],
					"destination" : [ "obj-107", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-111", 2 ],
					"destination" : [ "obj-106", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-70", 0 ],
					"destination" : [ "obj-69", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-68", 0 ],
					"destination" : [ "obj-67", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-111", 3 ],
					"destination" : [ "obj-105", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-111", 4 ],
					"destination" : [ "obj-104", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-111", 5 ],
					"destination" : [ "obj-103", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-31", 0 ],
					"destination" : [ "obj-30", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-111", 6 ],
					"destination" : [ "obj-102", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-111", 7 ],
					"destination" : [ "obj-101", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-111", 8 ],
					"destination" : [ "obj-100", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-23", 0 ],
					"destination" : [ "obj-22", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-20", 0 ],
					"destination" : [ "obj-5", 0 ],
					"hidden" : 1,
					"midpoints" : [ 465.5, 148.0, 407.5, 148.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-22", 0 ],
					"destination" : [ "obj-5", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-111", 9 ],
					"destination" : [ "obj-99", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-16", 0 ],
					"destination" : [ "obj-15", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-111", 10 ],
					"destination" : [ "obj-98", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-111", 11 ],
					"destination" : [ "obj-97", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-21", 0 ],
					"destination" : [ "obj-20", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-111", 12 ],
					"destination" : [ "obj-96", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-111", 13 ],
					"destination" : [ "obj-95", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-111", 14 ],
					"destination" : [ "obj-94", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-13", 0 ],
					"destination" : [ "obj-14", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-111", 15 ],
					"destination" : [ "obj-93", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-91", 0 ],
					"destination" : [ "obj-90", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-33", 0 ],
					"destination" : [ "obj-92", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-92", 0 ],
					"destination" : [ "obj-11", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-91", 1 ],
					"destination" : [ "obj-89", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-91", 2 ],
					"destination" : [ "obj-88", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-91", 3 ],
					"destination" : [ "obj-87", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-91", 4 ],
					"destination" : [ "obj-86", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-91", 5 ],
					"destination" : [ "obj-85", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-59", 0 ],
					"destination" : [ "obj-64", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-57", 0 ],
					"destination" : [ "obj-4", 0 ],
					"hidden" : 1,
					"midpoints" : [ 756.5, 146.0, 666.5, 146.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-60", 0 ],
					"destination" : [ "obj-4", 0 ],
					"hidden" : 1,
					"midpoints" : [ 685.5, 146.0, 666.5, 146.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-62", 0 ],
					"destination" : [ "obj-4", 0 ],
					"hidden" : 1,
					"midpoints" : [ 621.5, 146.0, 666.5, 146.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-64", 0 ],
					"destination" : [ "obj-4", 0 ],
					"hidden" : 1,
					"midpoints" : [ 563.5, 146.0, 666.5, 146.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-91", 6 ],
					"destination" : [ "obj-84", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-91", 7 ],
					"destination" : [ "obj-83", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-91", 8 ],
					"destination" : [ "obj-82", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-63", 0 ],
					"destination" : [ "obj-62", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-91", 9 ],
					"destination" : [ "obj-81", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-91", 10 ],
					"destination" : [ "obj-80", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-91", 11 ],
					"destination" : [ "obj-79", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-91", 12 ],
					"destination" : [ "obj-78", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-61", 0 ],
					"destination" : [ "obj-60", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-91", 13 ],
					"destination" : [ "obj-77", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-91", 14 ],
					"destination" : [ "obj-76", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-91", 15 ],
					"destination" : [ "obj-75", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-58", 0 ],
					"destination" : [ "obj-56", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-56", 0 ],
					"destination" : [ "obj-57", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-34", 0 ],
					"destination" : [ "obj-35", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-32", 0 ],
					"destination" : [ "obj-33", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-92", 0 ],
					"destination" : [ "obj-35", 1 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-92", 0 ],
					"destination" : [ "obj-33", 1 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-126", 0 ],
					"destination" : [ "obj-127", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-125", 0 ],
					"destination" : [ "obj-127", 1 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-127", 0 ],
					"destination" : [ "obj-74", 0 ],
					"hidden" : 0,
					"midpoints" : [ 282.5, 47.0, 270.0, 47.0, 270.0, 25.0, 190.5, 25.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-119", 2 ],
					"destination" : [ "obj-74", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-119", 1 ],
					"destination" : [ "obj-122", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-119", 0 ],
					"destination" : [ "obj-121", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-120", 0 ],
					"destination" : [ "obj-119", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-73", 0 ],
					"destination" : [ "obj-18", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-18", 0 ],
					"destination" : [ "obj-71", 0 ],
					"hidden" : 1,
					"midpoints" : [ 468.5, 73.0, 408.5, 73.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-123", 0 ],
					"destination" : [ "obj-19", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-7", 0 ],
					"destination" : [ "obj-123", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-122", 0 ],
					"destination" : [ "obj-123", 0 ],
					"hidden" : 1,
					"midpoints" : [ 159.5, 76.0, 132.5, 76.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-121", 0 ],
					"destination" : [ "obj-123", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-109", 0 ],
					"destination" : [ "obj-123", 0 ],
					"hidden" : 1,
					"midpoints" : [ 95.5, 75.0, 132.5, 75.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-113", 0 ],
					"destination" : [ "obj-123", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-123", 2 ],
					"destination" : [ "obj-116", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-123", 4 ],
					"destination" : [ "obj-114", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-123", 4 ],
					"destination" : [ "obj-92", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-149", 0 ],
					"destination" : [ "obj-146", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-150", 0 ],
					"destination" : [ "obj-147", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-146", 0 ],
					"destination" : [ "obj-151", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-147", 0 ],
					"destination" : [ "obj-151", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
 ]
	}

}
