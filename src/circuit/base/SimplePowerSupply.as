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

public class SimplePowerSupply implements PowerSupply, PowerSupplyConfig
{
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
