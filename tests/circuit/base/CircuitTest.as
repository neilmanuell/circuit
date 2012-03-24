package circuit.base
{
import circuit.api.Breaker;
import circuit.api.Circuit;
import circuit.signals.CircuitStateChangedSignal;

import flash.events.Event;

import mockolate.nice;
import mockolate.prepare;

import org.flexunit.async.Async;
import org.hamcrest.assertThat;
import org.hamcrest.object.instanceOf;
import org.hamcrest.object.isFalse;
import org.hamcrest.object.isTrue;

public class CircuitTest
{

    private var _classUnderTest:CircuitNode;
    private var _breakerA:Breaker;
    private var _received:Boolean;

    [Before(order=1, async, timeout=5000)]
    public function prepareMockolates():void
    {
        Async.proceedOnEvent( this,
                prepare( Breaker ),
                Event.COMPLETE );
    }

    [Before(order=2)]
    public function before():void
    {
        _classUnderTest = new CircuitNode("testCircuit");
        _breakerA = nice( Breaker )
    }


    [After]
    public function after():void
    {
        _classUnderTest = null;
        _breakerA = null;
    }


    [Test]
    public function isLive__by_default_is_false():void
    {
        assertThat( _classUnderTest.isLive, isFalse() );
    }


    [Test]
    public function markAsConnected_sets_isLive_true():void
    {
        makeLive()
        assertThat( _classUnderTest.isLive, isTrue() );
    }


    [Test]
    public function not_calling_markAsConnected_sets_isLive_false():void
    {
        makeDead();
        assertThat( _classUnderTest.isLive, isFalse() );
    }

    [Test]
    public function add_registers_breaker():void
    {
        _classUnderTest.add( _breakerA );
        assertThat( _classUnderTest.has( _breakerA ), isTrue() );
    }

    [Test]
    public function successful_add_returns_true():void
    {
        assertThat( _classUnderTest.add( _breakerA ), isTrue() );
    }

    [Test]
    public function duplicate_add_returns_false():void
    {
        _classUnderTest.add( _breakerA );
        assertThat( _classUnderTest.add( _breakerA ), isFalse() );
    }

    [Test]
    public function onStateChanged_returns_instanceOf_CircuitStateChangedSignal():void
    {
        assertThat( _classUnderTest.onStateChanged, instanceOf( CircuitStateChangedSignal ) );
    }

    [Test]
    public function onStateChanged_dispatches_on_isLive_change_true():void
    {
        _classUnderTest.onStateChanged.add( circuitListener );
        makeLive();

        assertThat( _received, isTrue() );
    }

    [Test]
    public function onStateChanged_dispatches_on_isLive_change_false():void
    {
        makeLive();
        _classUnderTest.onStateChanged.add( circuitListener );
        makeDead();

        assertThat( _received, isTrue() );
    }

    [Test]
    public function onStateChanged_does_not_dispatch_isLive_stays_true():void
    {
        makeLive()
        _classUnderTest.onStateChanged.add( circuitListener );
        makeLive()

        assertThat( _received, isFalse() );
    }

    [Test]
    public function onStateChanged_does_not_dispatch_isLive_stays_false():void
    {
        makeDead();
        _classUnderTest.onStateChanged.add( circuitListener );
        makeDead();

        assertThat( _received, isFalse() );
    }

    private function makeLive():void
    {
        _classUnderTest.invalidate();
        _classUnderTest.markAsConnected();
        _classUnderTest.validate();
    }

    private function makeDead():void
    {
        _classUnderTest.invalidate();
        _classUnderTest.validate();
    }


    private function circuitListener( circuit:Circuit ):void
    {
        _received = true;
    }
}
}
