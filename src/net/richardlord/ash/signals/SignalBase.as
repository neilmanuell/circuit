/*
 * Based on ideas used in Robert Penner's AS3-signals - https://github.com/robertpenner/as3-signals
 */

package net.richardlord.ash.signals
{
	import flash.utils.Dictionary;

	/**
	 * The base class for all the signal classes.
	 */
	public class SignalBase
	{
		internal var head : ListenerNode;
		internal var tail : ListenerNode;
		
		private var nodes : Dictionary;
		private var listenerNodePool : ListenerNodePool;
		private var toAddHead : ListenerNode;
		private var toAddTail : ListenerNode;
		private var dispatching : Boolean;

		public function SignalBase()
		{
			nodes = new Dictionary( true );
			listenerNodePool = new ListenerNodePool();
		}
		
		protected function startDispatch() : void
		{
			dispatching = true;
		}
		
		protected function endDispatch() : void
		{
			dispatching = false;
			if( toAddHead )
			{
				if( !head )
				{
					head = toAddHead;
					tail = toAddTail;
				}
				else
				{
					tail.next = toAddHead;
					toAddHead.previous = tail;
					tail = toAddTail;
				}
				toAddHead = null;
				toAddTail = null;
			}
			listenerNodePool.releaseCache();
		}

		public function add( listener : Function ) : void
		{
			if( nodes[ listener ] )
			{
				return;
			}
			var node : ListenerNode = listenerNodePool.get();
			node.listener = listener;
			nodes[ listener ] = node;
			if( dispatching )
			{
				if( !toAddHead )
				{
					toAddHead = toAddTail = node;
				}
				else
				{
					toAddTail.next = node;
					node.previous = toAddTail;
					toAddTail = node;
				}
			}
			else
			{
				if ( !head )
				{
					head = tail = node;
				}
				else
				{
					tail.next = node;
					node.previous = tail;
					tail = node;
				}
			}
		}

		public function remove( listener : Function ) : void
		{
			var node : ListenerNode = nodes[ listener ];
			if ( node )
			{
				if ( head == node)
				{
					head = head.next;
				}
				if ( tail == node)
				{
					tail = tail.previous;
				}
				if ( toAddHead == node)
				{
					toAddHead = toAddHead.next;
				}
				if ( toAddTail == node)
				{
					toAddTail = toAddTail.previous;
				}
				if (node.previous)
				{
					node.previous.next = node.next;
				}
				if (node.next)
				{
					node.next.previous = node.previous;
				}
				delete nodes[ listener ];
				if( dispatching )
				{
					listenerNodePool.cache( node );
				}
				else
				{
					listenerNodePool.dispose( node );
				}
			}
		}
		
		public function removeAll() : void
		{
			while( head )
			{
				var listener : ListenerNode = head;
				head = head.next;
				listener.previous = null;
				listener.next = null;
			}
			tail = null;
			toAddHead = null;
			toAddTail = null;
		}
	}
}
