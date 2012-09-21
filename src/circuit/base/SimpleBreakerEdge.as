package circuit.base
{
import circuit.api.Node;
import circuit.core.BreakerEdgeConfig;
import circuit.core.BreakerEdgeOperate;
import circuit.signals.BreakerStateChangedSignal;

import net.richardlord.ash.signals.Signal1;

public class SimpleBreakerEdge implements BreakerEdgeOperate, BreakerEdgeConfig
{
    private var _isClosed:Boolean = true;
    private var _circuitPair:CircuitPair;
    private const _onStateChanged:BreakerStateChangedSignal = new BreakerStateChangedSignal();
    private var _id:String;

    public function SimpleBreakerEdge( id:String, a:Node = null, b:Node = null )
    {
        _id = id;
        if ( a != null && b != null )add( a, b );
    }

    public function get onStateChanged():Signal1
    {
        return _onStateChanged;
    }

    public function get isClosed():Boolean
    {
        return _isClosed;
    }

    public function add( a:Node, b:Node ):Boolean
    {
        if ( _circuitPair != null )return false;
        _circuitPair = new CircuitPair( a, b );
        return true;
    }

    public function has( circuit:Node ):Boolean
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

    public function getOtherCircuit( thisCircuit:Node ):Node
    {
        if ( _circuitPair == null )return NULL_NODE;
        return _circuitPair.getOtherCircuit( thisCircuit );
    }

    public function get id():String
    {
        return _id;
    }
}
}
