package circuit.base
{
import circuit.core.*;
import circuit.base.CircuitOperateList;

import flash.events.Event;

import mockolate.nice;
import mockolate.prepare;
import mockolate.received;

import org.flexunit.async.Async;
import org.hamcrest.assertThat;
import org.hamcrest.collection.array;
import org.hamcrest.object.equalTo;
import org.hamcrest.object.isFalse;
import org.hamcrest.object.isTrue;
import org.hamcrest.object.nullValue;
import org.hamcrest.object.strictlyEqualTo;

public class CircuitOperateListTest
{
    private var _circuitA:CircuitOperate;
    private var _circuitB:CircuitOperate;
    private var _circuitC:CircuitOperate;
    private var _received:Array;
    private var _classUnderTest:CircuitOperateList;

    [Before(order=1, async, timeout=5000)]
    public function prepareMockolates():void
    {
        Async.proceedOnEvent( this,
                prepare( CircuitOperate ),
                Event.COMPLETE );
    }

    [Before(order=2)]
    public function before():void
    {
        _circuitA = nice( CircuitOperate );
        _circuitB = nice( CircuitOperate );
        _circuitC = nice( CircuitOperate );
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
    public function length_by_default_zero():void
    {
        assertThat( _classUnderTest.length, equalTo( 0 ) );

    }

    [Test]
    public function add_increases_length_by_one():void
    {
        _classUnderTest.add( _circuitA );
        assertThat( _classUnderTest.length, equalTo( 1 ) );

    }

    [Test]
    public function successful_add_returns_true():void
    {
        assertThat( _classUnderTest.add( _circuitA ), isTrue() );
    }

    [Test]
    public function duplicate_add_returns_false():void
    {
        _classUnderTest.add( _circuitA )
        assertThat( _classUnderTest.add( _circuitA ), isFalse() );
    }

    [Test]
    public function next__returns_successive_circuits():void
    {
        configureAndProceedToListEnd();
        assertThat( _received, array( strictlyEqualTo( _circuitA ), strictlyEqualTo( _circuitB ), strictlyEqualTo( _circuitC ) ) );
    }

    [Test]
    public function hasNext__by_default_returns_false():void
    {
        assertThat( _classUnderTest.hasNext, isFalse() );

    }

    [Test]
    public function hasNext_at_list_beginning_returns_true():void
    {
        _classUnderTest.add( _circuitA )
        assertThat( _classUnderTest.hasNext, isTrue() );

    }

    [Test]
    public function hasNext__at_list_end_returns_false():void
    {
        configureAndProceedToListEnd();
        assertThat( _classUnderTest.hasNext, isFalse() );

    }

    [Test]
    public function next__at_list_end_returns_null():void
    {
        configureAndProceedToListEnd();
        assertThat( _classUnderTest.next(), nullValue() );
    }

    [Test]
    public function reset__next_count_to_zero():void
    {
        configureProceedAndReset();
        assertThat( _received, array( strictlyEqualTo( _circuitA ), nullValue() ) );
    }

    [Test]
    public function reset__sets_length_to_zero():void
    {
        fillList();
        _classUnderTest.reset()
        assertThat( _classUnderTest.length, equalTo( 0 ) );
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

    private function configureAndProceedToListEnd():void
    {
        fillList();
        _received.push( _classUnderTest.next() );
        _received.push( _classUnderTest.next() );
        _received.push( _classUnderTest.next() );
    }

    private function configureProceedAndReset():void
    {
        fillList()
        _received.push( _classUnderTest.next() );
        _classUnderTest.reset();
        _received.push( _classUnderTest.next() );
    }

    private function fillList():void
    {
        _classUnderTest.add( _circuitA );
        _classUnderTest.add( _circuitB );
        _classUnderTest.add( _circuitC );
    }


    private function assertMethodCalledOnAll( methodName:String ):void
    {
        while ( _classUnderTest.hasNext )
        {
            assertThat( _classUnderTest.next(), received().method( methodName ).once() );
        }
    }


}
}
