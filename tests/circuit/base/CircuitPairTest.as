package circuit.base
{
import circuit.api.Circuit;

import flash.events.Event;

import mockolate.nice;
import mockolate.prepare;

import org.flexunit.async.Async;
import org.hamcrest.assertThat;
import org.hamcrest.object.isTrue;
import org.hamcrest.object.strictlyEqualTo;

public class CircuitPairTest
{
    private var _circuitA:Circuit;
    private var _circuitB:Circuit;
    private var _circuitUnknown:Circuit;
    private var _classUnderTest:CircuitPair;

    [Before(order=1, async, timeout=5000)]
    public function prepareMockolates():void
    {
        Async.proceedOnEvent( this,
                prepare( Circuit ),
                Event.COMPLETE );
    }

    [Before(order=2)]
    public function before():void
    {
        _circuitA = nice( Circuit );
        _circuitB = nice( Circuit );
        _circuitUnknown = nice( Circuit );
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
    public function getOtherCircuit_give_unknown_returns_unknown():void
    {
        assertThat( _classUnderTest.getOtherCircuit( _circuitUnknown ), strictlyEqualTo( _circuitUnknown ) );
    }


}
}
