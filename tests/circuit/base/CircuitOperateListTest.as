package circuit.base
{
import circuit.core.*;

import flash.events.Event;

import mockolate.nice;
import mockolate.prepare;
import mockolate.received;

import net.lists.LinkedList;
import net.lists.nodes.ListNode;

import org.flexunit.async.Async;
import org.hamcrest.assertThat;

public class CircuitOperateListTest
{
    private var _circuitA:CircuitNodeOperate;
    private var _circuitB:CircuitNodeOperate;
    private var _circuitC:CircuitNodeOperate;
    private var _received:Array;
    private var _classUnderTest:CircuitOperateList;
    private var _linkedList:LinkedList;

    [Before(order=1, async, timeout=5000)]
    public function prepareMockolates():void
    {
        Async.proceedOnEvent( this,
                prepare( CircuitNodeOperate ),
                Event.COMPLETE );
    }

    [Before(order=2)]
    public function before():void
    {
        _circuitA = nice( CircuitNodeOperate );
        _circuitB = nice( CircuitNodeOperate );
        _circuitC = nice( CircuitNodeOperate );
        _linkedList = new LinkedList();
        _received = [];
        _classUnderTest = new CircuitOperateList();
    }


    [After]
    public function after():void
    {
        _circuitA = null;
        _circuitB = null;
        _circuitC = null;
        _received = null;
        _classUnderTest = null;
    }


    [Test]
    public function invalidateAll__calls_invalidate_on_children():void
    {
        fillList();
        _classUnderTest.invalidateAll();
        assertMethodCalledOnAll( "invalidate" );
    }

    [Test]
    public function validateAll__calls_apply_on_children():void
    {
        fillList();
        _classUnderTest.validateAll();
        assertMethodCalledOnAll( "validate" );
    }

    [Test]
    public function markAllAsConnected__calls_markAsConnected_on_children():void
    {
        fillList();
        _classUnderTest.markAllAsConnected();
        assertMethodCalledOnAll( "markAsConnected" );
    }


    private function fillList():void
    {
        _linkedList.add( _circuitA );
        _linkedList.add( _circuitB );
        _linkedList.add( _circuitC );
        _classUnderTest.client = _linkedList;
    }


    private function assertMethodCalledOnAll( methodName:String ):void
    {
        for ( var node:ListNode = _linkedList.head; node; node = node.next )
        {
            assertThat( node.data, received().method( methodName ).once() );
        }
    }


}
}
