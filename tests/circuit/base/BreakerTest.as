package circuit.base
{
import circuit.api.Edge;
import circuit.api.Node;
import circuit.signals.BreakerStateChangedSignal;

import flash.events.Event;

import mockolate.nice;
import mockolate.prepare;

import org.flexunit.async.Async;
import org.hamcrest.assertThat;
import org.hamcrest.object.instanceOf;
import org.hamcrest.object.isFalse;
import org.hamcrest.object.isTrue;
import org.hamcrest.object.strictlyEqualTo;

public class BreakerTest
{
    private var _circuitA:Node;
    private var _circuitB:Node;
    private var _circuitUnknown:Node;
    private var _classUnderTest:SimpleBreakerEdge;
    private var _received:Boolean;
    private var _id:String = "testBreaker";

    [Before(order=1, async, timeout=5000)]
    public function prepareMockolates():void
    {
        Async.proceedOnEvent( this,
                prepare( Node ),
                Event.COMPLETE );
    }

    [Before(order=2)]
    public function before():void
    {
        _circuitA = nice( Node );
        _circuitB = nice( Node );
        _circuitUnknown = nice( Node );
        _classUnderTest = new SimpleBreakerEdge( _id );
        _received = false;
    }

    [After]
    public function after():void
    {
        _circuitA = null;
        _circuitB = null;
        _circuitUnknown = null;
        _classUnderTest = null;
    }

    [Test]
    public function isClosed__by_default_is_true():void
    {
        assertThat( _classUnderTest.isClosed, isTrue() )
    }

    [Test]
    public function open__sets_isClosed_to_false():void
    {
        _classUnderTest.open();
        assertThat( _classUnderTest.isClosed, isFalse() );

    }

    [Test]
    public function close__sets_isClosed_to_true():void
    {
        _classUnderTest.open();
        _classUnderTest.close();
        assertThat( _classUnderTest.isClosed, isTrue() );

    }

    [Test]
    public function has__by_default_returns_false():void
    {
        assertThat( _classUnderTest.has( _circuitA ), isFalse() );
    }

    [Test]
    public function successful_add_returns_true():void
    {
        assertThat( _classUnderTest.add( _circuitA, _circuitB ), isTrue() );
    }

    [Test]
    public function add__registers_circuit():void
    {
        _classUnderTest.add( _circuitA, _circuitB );
        assertThat( _classUnderTest.has( _circuitA ), isTrue() );

    }

    [Test]
    public function add__multiple_calls_return_false():void
    {
        _classUnderTest.add( _circuitA, _circuitB );
        assertThat( _classUnderTest.add( _circuitA, _circuitB ), isFalse() );
    }

    [Test]
    public function add__sets_values_once_only():void
    {
        _classUnderTest.add( _circuitA, _circuitB );
        _classUnderTest.add( _circuitB, _circuitUnknown )
        assertThat( _classUnderTest.has( _circuitUnknown ), isFalse() );
    }

    [Test]
    public function getOtherCircuit_by_default_returns_NULL_CIRCUIT():void
    {
        assertThat( _classUnderTest.getOtherCircuit( _circuitUnknown ), strictlyEqualTo( NULL_NODE ) );
    }

    [Test]
    public function getOtherCircuit_give_A_returns_B():void
    {
        _classUnderTest.add( _circuitA, _circuitB );
        assertThat( _classUnderTest.getOtherCircuit( _circuitA ), strictlyEqualTo( _circuitB ) );
    }

    [Test]
    public function getOtherCircuit_give_B_returns_A():void
    {
        _classUnderTest.add( _circuitA, _circuitB );
        assertThat( _classUnderTest.getOtherCircuit( _circuitB ), strictlyEqualTo( _circuitA ) );
    }

    [Test]
    public function getOtherCircuit_give_unknown_returns_NULL_CIRCUIT():void
    {
        _classUnderTest.add( _circuitA, _circuitB );
        assertThat( _classUnderTest.getOtherCircuit( _circuitUnknown ), strictlyEqualTo( NULL_NODE ) );
    }

    [Test]
    public function onStateChanged_returns_instanceOf_BreakerStateChangedSignal():void
    {
        assertThat( _classUnderTest.onStateChanged, instanceOf( BreakerStateChangedSignal ) );
    }

    [Test]
    public function onStateChanged_dispatches_on_open():void
    {
        _classUnderTest.onStateChanged.add( breakerListener );
        _classUnderTest.open();
        assertThat( _received, isTrue() );
    }

    [Test]
    public function onStateChanged_dispatches_on_close():void
    {
        _classUnderTest.open();
        _classUnderTest.onStateChanged.add( breakerListener );
        _classUnderTest.close();
        assertThat( _received, isTrue() );
    }

    [Test]
    public function onStateChanged_does_not_dispatch_on_close_if_closed():void
    {
        _classUnderTest.onStateChanged.add( breakerListener );
        _classUnderTest.close();
        assertThat( _received, isFalse() );
    }

    [Test]
    public function onStateChanged_does_not_dispatch_on_open_if_open():void
    {
        _classUnderTest.open();
        _classUnderTest.onStateChanged.add( breakerListener );
        _classUnderTest.open();
        assertThat( _received, isFalse() );
    }

    private function breakerListener( breaker:Edge ):void
    {
        _received = true;
    }


}
}
