//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package org.robotlegs.v2.extensions.mediatorMap.configs
{
	import org.robotlegs.v2.core.api.IContext;
	import org.robotlegs.v2.core.api.IContextConfig;
	import org.robotlegs.v2.extensions.mediatorMap.api.IMediatorMap;
	import org.robotlegs.v2.extensions.mediatorMap.utilities.triggers.DuckTypedMediatorTrigger;
		
	public class DuckTypedMediatorsConfig implements IContextConfig
	{
		protected var _strict:Boolean;
		
		public function DuckTypedMediatorsConfig(strict:Boolean = false)
		{
			_strict = strict;
		}

		public function configure(context:IContext):void
		{
			const mediatorMap:IMediatorMap = context.injector.getInstance(IMediatorMap);
			const trigger:DuckTypedMediatorTrigger = new DuckTypedMediatorTrigger(_strict);
			
			addUIComponentStrategiesIfFlex(trigger);
			
			mediatorMap.loadTrigger(trigger);	
		}
	}
}