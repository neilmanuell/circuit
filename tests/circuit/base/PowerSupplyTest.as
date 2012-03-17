package circuit.base
{
import circuit.api.PowerSupply;
import circuit.core.CircuitOperate;
import circuit.core.PowerSupplyConfig;
import circuit.signals.PowerSupplyChangedSignal;

import org.hamcrest.assertThat;
import org.hamcrest.object.instanceOf;
import org.hamcrest.object.isFalse;
import org.hamcrest.object.isTrue;
import org.hamcrest.object.strictlyEqualTo;

public class PowerSupplyTest implements PowerSupply, PowerSupplyConfig
{
    private var _received:Boolean = false;

    [Before]
    public function before():void
    {

    }


    [After]
    public function after():void
    {
    }


    [Test]
    public function isOn_by_default_false():void
    {
        assertThat( isOn, isFalse() )
    }

    [Test]
    public function switchOn_sets_isOn_true():void
    {
        switchOn()
        assertThat( isOn, isTrue() );
    }

    [Test]
    public function circuit__by_default_is_NULL_CIRCUIT():void
    {
        assertThat( circuit, strictlyEqualTo( NULL_CIRCUIT ) );
    }

    [Test]
    public function circuit_setter():void
    {
        const expected:CircuitOperate = new CircuitNode();
        circuit = expected;
        assertThat( circuit, strictlyEqualTo( expected ) );
    }

    [Test]
    public function onStateChanged_returns_instanceOf_PowerSupplyChangedSignal():void
    {
        assertThat( onStateChanged, instanceOf( PowerSupplyChangedSignal ) );
    }

    [Test]
    public function onStateChanged_dispatches_when_switched_on():void
    {
        onStateChanged.add( powerSupplyListener );
        switchOn();
        assertThat( _received, isTrue() );
    }

    [Test]
    public function onStateChanged_dispatches_when_switched_off():void
    {
        switchOn();
        onStateChanged.add( powerSupplyListener );
        switchOff();
        assertThat( _received, isTrue() );
    }

    [Test]
    public function onStateChanged_does_not_dispatch_when_already_on():void
    {
        switchOn();
        onStateChanged.add( powerSupplyListener );
        switchOn();
        assertThat( _received, isFalse() );
    }

    [Test]
    public function onStateChanged_does_not_dispatch_when_already_off():void
    {
        onStateChanged.add( powerSupplyListener );
        switchOff();
        assertThat( _received, isFalse() );
    }


    private function powerSupplyListener( power:PowerSupply ):void
    {
        _received = true;
    }


    private var _isOn:Boolean = false;
    private var _circuit:CircuitOperate = NULL_CIRCUIT;
    private const _onStateChanged:PowerSupplyChangedSignal = new PowerSupplyChangedSignal();

    public function get onStateChanged():PowerSupplyChangedSignal
    {
        return _onStateChanged;
    }

    public function get isOn():Boolean
    {
        return _isOn;
    }

    public function switchOn():void
    {
        if ( _isOn )return;
        _isOn = true;
        _onStateChanged.dispatchPowerSupply( this );
    }

    public function switchOff():void
    {
        if ( !_isOn )return;
        _isOn = false;
        _onStateChanged.dispatchPowerSupply( this );
    }

    public function set circuit( value:CircuitOperate ):void
    {
        _circuit = value;
    }

    public function get circuit():CircuitOperate
    {
        return _circuit;
    }


}
}
