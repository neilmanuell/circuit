package circuit.base
{
import circuit.api.Node;

import flash.events.Event;

import mockolate.nice;
import mockolate.prepare;

import org.flexunit.async.Async;
import org.hamcrest.assertThat;
import org.hamcrest.object.isTrue;
import org.hamcrest.object.strictlyEqualTo;

public class CircuitPairTest
{
    private var _circuitA:Node;
    private var _circuitB:Node;
    private var _circuitUnknown:Node;
    private var _classUnderTest:CircuitPair;

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
        _classUnderTest = new CircuitPair( _circuitA, _circuitB );
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
    public function has__for_registered_circuit_returns_true():void
    {
        assertThat( _classUnderTest.has( _circuitA ), isTrue() );
    }

    [Test]
    public function has__for_unregistered_circuit_returns_false():void
    {
        assertThat( _classUnderTest.has( _circuitB ), isTrue() );
    }

    [Test]
    public function getOtherCircuit_give_A_returns_B():void
    {
        assertThat( _classUnderTest.getOtherCircuit( _circuitA ), strictlyEqualTo( _circuitB ) );
    }

    [Test]
    public function getOtherCircuit_give_B_returns_A():void
    {
        assertThat( _classUnderTest.getOtherCircuit( _circuitB ), strictlyEqualTo( _circuitA ) );
    }

    [Test]
    public function getOtherCircuit_give_unknown_returns_NULL_CIRCUIT():void
    {
        assertThat( _classUnderTest.getOtherCircuit( _circuitUnknown ), strictlyEqualTo( NULL_CIRCUIT ) );
    }


}
}
