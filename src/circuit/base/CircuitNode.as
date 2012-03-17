package circuit.base
{
import circuit.api.Breaker;
import circuit.api.Circuit;
import circuit.core.*;
import circuit.signals.CircuitStateChangedSignal;

public class CircuitNode implements Circuit, CircuitConfig, CircuitOperate
{
    private var _connected:Boolean = false;
    private var _isLive:Boolean = false;
    private var _circuitRetreiver:CircuitRetriever;
    private const _breakers:Array = [];
    private const _onStateChange:CircuitStateChangedSignal = new CircuitStateChangedSignal();

    public function get onStateChanged():CircuitStateChangedSignal
    {
        return _onStateChange;
    }

    public function get isLive():Boolean
    {
        return _isLive;
    }

    public function add( breaker:Breaker ):Boolean
    {
        if ( has( breaker ) ) return false;
        _breakers.push( breaker );
        return true;
    }

    public function has( breaker:Breaker ):Boolean
    {
        return (_breakers.indexOf( breaker ) != -1);
    }

    public function invalidate():void
    {
        _connected = false;
    }

    public function markAsConnected():void
    {
        _connected = true;
    }

    public function validate():void
    {
        if ( _connected && !_isLive )
        {
            _isLive = true;
            _onStateChange.dispatchCircuit( this );
        }
        else if ( !_connected && _isLive )
        {
            _isLive = false;
            _onStateChange.dispatchCircuit( this );
        }
    }

    public function getConnectedCircuits():Array
    {
        if (_circuitRetreiver == null ) _circuitRetreiver = new CircuitRetriever( this );
        return _circuitRetreiver.getConnectedCircuits( _breakers );
    }
}
}
