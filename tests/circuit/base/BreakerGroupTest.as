package circuit.base
{
import circuit.api.Breaker;
import circuit.signals.BreakerStateChangedSignal;

import org.hamcrest.assertThat;
import org.hamcrest.object.instanceOf;
import org.hamcrest.object.isFalse;
import org.hamcrest.object.isTrue;
import org.hamcrest.object.strictlyEqualTo;

public class BreakerGroupTest
{
    private var _breakerA:Breaker;
    private var _breakerB:Breaker;
    private var _breakerC:Breaker;
    private var _receivedBreaker:Breaker;
    private var _classUnderTest:BreakerGroup;


    [Before]
    public function before():void
    {
        _breakerA = new BreakerEdge();
        _breakerB = new BreakerEdge();
        _breakerC = new BreakerEdge();
        _classUnderTest = new BreakerGroup();
    }

    [After]
    public function after():void
    {
        _breakerA = null;
        _breakerB = null;
        _breakerC = null;
        _classUnderTest = null;
    }

    [Test]
    public function has__by_default_returns_false():void
    {
        assertThat( _classUnderTest.has( _breakerA ), isFalse() );
    }

    [Test]
    public function add__registers_breaker():void
    {
        _classUnderTest.add( _breakerA );
        assertThat( _classUnderTest.has( _breakerA ), isTrue() );
    }

    [Test]
    public function successful_add__returns_true():void
    {
        assertThat( _classUnderTest.add( _breakerA ), isTrue() );
    }

    [Test]
    public function duplicate_add__returns_false():void
    {
        _classUnderTest.add( _breakerA );
        assertThat( _classUnderTest.add( _breakerA ), isFalse() );
    }

    [Test]
    public function onStateChanged_returns_instanceOf_BreakerStateChangedSignal():void
    {
        assertThat( _classUnderTest.onStateChanged, instanceOf( BreakerStateChangedSignal ) );
    }

    [Test]
    public function onStateChanged_dispatches_when_closed_child_opens():void
    {
        fillGroup();
        _classUnderTest.onStateChanged.add( breakerListener );
        _breakerB.open();
        assertThat( _receivedBreaker, strictlyEqualTo( _breakerB ) );
    }

    [Test]
    public function onStateChanged_dispatches_when_open_child_closes():void
    {
        fillGroup();
        _breakerC.open();
        _classUnderTest.onStateChanged.add( breakerListener );
        _breakerC.close();
        assertThat( _receivedBreaker, strictlyEqualTo( _breakerC ) );
    }

    private function breakerListener( breaker:Breaker ):void
    {
        _receivedBreaker = breaker;
    }

    private function fillGroup():void
    {
        _classUnderTest.add( _breakerA );
        _classUnderTest.add( _breakerB );
        _classUnderTest.add( _breakerC );
    }


}
}
