//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package org.robotlegs.v2.extensions.mediatorMap.impl
{
	import mockolate.runner.MockolateRule;
	import mockolate.runner.MockolateRunner;
	import mockolate.received;
	import org.flexunit.asserts.*;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.strictlyEqualTo;
	import org.robotlegs.v2.extensions.mediatorMap.impl.support.MediatorWatcher;
	import org.robotlegs.v2.extensions.eventMap.api.IEventMap;
	import org.robotlegs.v2.extensions.mediatorMap.impl.support.SugaryMediator;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import org.robotlegs.v2.extensions.eventMap.impl.support.CustomEvent;
	import flash.display.DisplayObject;
	
	// required
	MockolateRunner;

	[RunWith("mockolate.runner.MockolateRunner")]
	public class MediatorSugarTest
	{
		[Rule]
		public var mocks:MockolateRule = new MockolateRule();

		[Mock]
		public var eventMap:IEventMap;

		private var instance:SugaryMediator;

		private var mediatorWatcher:MediatorWatcher;
		
		private var eventDispatcher:IEventDispatcher = new EventDispatcher();
		
		private const VIEW:Sprite = new Sprite();
		private const EVENT_STRING:String = "event string";
		private const CALLBACK:Function = function():void{};
		private const EVENT_CLASS:Class = CustomEvent;
		
		private var view:DisplayObject;

		[Before]
		public function setUp():void
		{
			instance = new SugaryMediator();
			instance.eventMap = eventMap;
			instance.eventDispatcher = eventDispatcher;
			mediatorWatcher = new MediatorWatcher();
			view = new Sprite();
			instance.setViewComponent(view);
		}

		[After]
		public function tearDown():void
		{
			instance = null;
			mediatorWatcher = null;
		}
		
		[Test]
		public function addViewListener_passes_vars_to_the_eventMap():void
		{
			instance.try_addViewListener(EVENT_STRING, CALLBACK, EVENT_CLASS);
			assertThat(eventMap, received().method('mapListener')
											.args(	strictlyEqualTo(view), 
													strictlyEqualTo(EVENT_STRING), 
													strictlyEqualTo(CALLBACK), 
													strictlyEqualTo(EVENT_CLASS)));
		}
		
		[Test]
		public function addContextListener_passes_vars_to_the_eventMap():void
		{
			instance.try_addContextListener(EVENT_STRING, CALLBACK, EVENT_CLASS);
			assertThat(eventMap, received().method('mapListener')
											.args(	strictlyEqualTo(eventDispatcher), 
													strictlyEqualTo(EVENT_STRING), 
													strictlyEqualTo(CALLBACK), 
													strictlyEqualTo(EVENT_CLASS)));
		}
		
		[Test]
		public function removeViewListener_passes_vars_to_the_eventMap():void
		{
			instance.try_removeViewListener(EVENT_STRING, CALLBACK, EVENT_CLASS);
			assertThat(eventMap, received().method('unmapListener')
											.args(	strictlyEqualTo(view), 
													strictlyEqualTo(EVENT_STRING), 
													strictlyEqualTo(CALLBACK), 
													strictlyEqualTo(EVENT_CLASS)));
		}
		
		[Test]
		public function removeContextListener_passes_vars_to_the_eventMap():void
		{
			instance.try_removeContextListener(EVENT_STRING, CALLBACK, EVENT_CLASS);
			assertThat(eventMap, received().method('unmapListener')
											.args(	strictlyEqualTo(eventDispatcher), 
													strictlyEqualTo(EVENT_STRING), 
													strictlyEqualTo(CALLBACK), 
													strictlyEqualTo(EVENT_CLASS)));
		}
		
	}
}