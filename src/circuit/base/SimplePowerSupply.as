package circuit.base
{
import circuit.api.PowerSupply;
import circuit.core.CircuitOperate;
import circuit.core.PowerSupplyConfig;
import circuit.signals.PowerSupplyChangedSignal;

public class SimplePowerSupply implements  PowerSupplyConfig
{

    private var _isOn:Boolean = false;
    private var _circuit:CircuitOperate = NULL_CIRCUIT;
    private const _onStateChanged:PowerSupplyChangedSignal = new PowerSupplyChangedSignal();
    private var _id:String;

    public function SimplePowerSupply( id:String, circuit:CircuitOperate = null )
    {
        _id = id;
        if ( circuit != null ) _circuit = circuit;
    }

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


    public function get id():String
    {
        return _id;
    }
}
}
