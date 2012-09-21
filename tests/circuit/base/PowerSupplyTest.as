package circuit.base
{
import circuit.api.Supply;
import circuit.core.CircuitNodeOperate;
import circuit.signals.PowerSupplyChangedSignal;

import org.hamcrest.assertThat;
import org.hamcrest.object.instanceOf;
import org.hamcrest.object.isFalse;
import org.hamcrest.object.isTrue;
import org.hamcrest.object.strictlyEqualTo;

public class PowerSupplyTest
{
    private var _received:Boolean = false;
    private var _classUnderTest:SimplePowerSupply;
    private var _id:String = "testPS";

    [Before]
    public function before():void
    {
        _classUnderTest = new SimplePowerSupply( _id );
    }


    [After]
    public function after():void
    {
        _classUnderTest = null;
    }


    [Test]
    public function isOn_by_default_false():void
    {
        assertThat( _classUnderTest.isOn, isFalse() )
    }

    [Test]
    public function switchOn_sets_isOn_true():void
    {
        _classUnderTest.switchOn()
        assertThat( _classUnderTest.isOn, isTrue() );
    }

    [Test]
    public function circuit__by_default_is_NULL_CIRCUIT():void
    {
        assertThat( _classUnderTest.circuit, strictlyEqualTo( NULL_NODE ) );
    }

    [Test]
    public function circuit_setter():void
    {
        const expected:CircuitNodeOperate = new SimpleCircuitNode( "testCircuit" );
        _classUnderTest.circuit = expected;
        assertThat( _classUnderTest.circuit, strictlyEqualTo( expected ) );
    }

    [Test]
    public function onStateChanged_returns_instanceOf_PowerSupplyChangedSignal():void
    {
        assertThat( _classUnderTest.onStateChanged, instanceOf( PowerSupplyChangedSignal ) );
    }

    [Test]
    public function onStateChanged_dispatches_when_switched_on():void
    {
        _classUnderTest.onStateChanged.add( powerSupplyListener );
        _classUnderTest.switchOn();
        assertThat( _received, isTrue() );
    }

    [Test]
    public function onStateChanged_dispatches_when_switched_off():void
    {
        _classUnderTest.switchOn();
        _classUnderTest.onStateChanged.add( powerSupplyListener );
        _classUnderTest.switchOff();
        assertThat( _received, isTrue() );
    }

    [Test]
    public function onStateChanged_does_not_dispatch_when_already_on():void
    {
        _classUnderTest.switchOn();
        _classUnderTest.onStateChanged.add( powerSupplyListener );
        _classUnderTest.switchOn();
        assertThat( _received, isFalse() );
    }

    [Test]
    public function onStateChanged_does_not_dispatch_when_already_off():void
    {
        _classUnderTest.onStateChanged.add( powerSupplyListener );
        _classUnderTest.switchOff();
        assertThat( _received, isFalse() );
    }


    private function powerSupplyListener( power:Supply ):void
    {
        _received = true;
    }


}
}
