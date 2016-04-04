﻿/********************************************************************** Copyright (c) 2009 Scaleform Corporation. All Rights Reserved.
 Portions of the integration code is from Epic Games as identified by Perforce annotations.
 Copyright © 2010 Epic Games, Inc. All rights reserved.

 Licensees may use this file in accordance with the valid Scaleform License Agreement provided with the software. This file is provided AS IS with NO WARRANTY OF ANY KIND, INCLUDING THE WARRANTY OF DESIGN, MERCHANTABILITY AND FITNESS FOR ANY PURPOSE.**********************************************************************//** * This intrinsic class replaces the built-in intrinsic class, and adds the Scaleform GFx methods and Properties of the TextFormat class, making the GFx properties compile-safe so they can be typed using dot-notation instead of bracket-access. */intrinsic class TextFormat {	var align:String;	var blockIndent:Number;	var bold:Boolean;	var bullet:Boolean;	var color:Number;	var font:String;	var indent:Number;	var italic:Boolean;	var kerning:Boolean;	var leading:Number;	var leftMargin:Number;	var letterSpacing:Number;	var rightMargin:Number;	var size:Number;	var tabStops:Array;	var target:String;	var underline:Boolean;	var url:String;	function TextFormat(font:String,size:Number,color:Number,                    	bold:Boolean,italic:Boolean,underline:Boolean,                    	url:String,target:String,align:String,                    	leftMargin:Number,rightMargin:Number,indent:Number,leading:Number);	function getTextExtent(text:String, width:Number):Object;	// GFx Extensions	var alpha:Number;}