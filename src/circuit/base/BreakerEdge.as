package circuit.base
{
import circuit.api.Circuit;
import circuit.core.BreakerConfig;
import circuit.core.BreakerOperate;
import circuit.signals.BreakerStateChangedSignal;

public class BreakerEdge implements BreakerOperate, BreakerConfig
{
    private var _isClosed:Boolean = true;
    private var _circuitPair:CircuitPair;
    private const _onStateChanged:BreakerStateChangedSignal = new BreakerStateChangedSignal();

    public function BreakerEdge( a:Circuit = null, b:Circuit = null )
    {
        if( a != null && b != null )add( a, b );
    }

    public function get onStateChanged():BreakerStateChangedSignal
    {
        return _onStateChanged;
    }

    public function get isClosed():Boolean
    {
        return _isClosed;
    }

    public function add( a:Circuit, b:Circuit ):Boolean
    {
        if ( _circuitPair != null )return false;
        _circuitPair = new CircuitPair( a, b );
        return true;
    }

    public function has( circuit:Circuit ):Boolean
    {
        if ( _circuitPair == null )return false
        return _circuitPair.has( circuit );
    }

    public function open():void
    {
        if ( !_isClosed )return;
        _isClosed = false;
        _onStateChanged.dispatchBreaker( this );
    }

    public function close():void
    {
        if ( _isClosed )return;
        _isClosed = true;
        _onStateChanged.dispatchBreaker( this );
    }

    public function getOtherCircuit( thisCircuit:Circuit ):Circuit
    {
        if ( _circuitPair == null )return NULL_CIRCUIT;
        return _circuitPair.getOtherCircuit( thisCircuit );
    }
}
}
