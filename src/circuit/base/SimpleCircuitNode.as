package circuit.base
{
import circuit.api.Element;
import circuit.api.Node;
import circuit.core.*;
import circuit.signals.CircuitStateChangedSignal;

import net.lists.LinkedList;
import net.richardlord.ash.signals.Signal1;

public class SimpleCircuitNode implements Node, CircuitNodeConfig, CircuitNodeOperate
{
    private var _id:String;
    private var _isConnected:Boolean = false;
    private var _isLive:Boolean = false;
    private var _circuitRetreiver:CircuitRetriever;
    private const _breakers:LinkedList = new LinkedList();
    private const _onStateChange:CircuitStateChangedSignal = new CircuitStateChangedSignal();
    private var _dirty:Boolean;


    public function SimpleCircuitNode( id:String )
    {
        _id = id;
    }

    public function get onStateChanged():Signal1
    {
        return _onStateChange;
    }

    public function get isLive():Boolean
    {
        return _isLive;
    }

    public function add( element:Element ):Boolean
    {
        if ( has( element ) ) return false;
        _breakers.add( element );
        return true;
    }

    public function has( element:Element ):Boolean
    {
        return (_breakers.has( element ));
    }

    public function invalidate():void
    {
        _isConnected = false;
    }

    public function markAsConnected():void
    {
        _isConnected = true;
    }

    public function validate():void
    {
        if ( _isConnected && !_isLive )
        {
            _isLive = true;
            _dirty = true;

        }
        else if ( !_isConnected && _isLive )
        {
            _isLive = false;
            _dirty = true;
        }
        else
        {
            _dirty = false;
        }
    }

    public function dispatch():void
    {
        if ( !_dirty )return
        _dirty = false;
        _onStateChange.dispatchCircuit( this );
    }

    public function getConnectedCircuits():LinkedList
    {
        if ( _circuitRetreiver == null ) _circuitRetreiver = new CircuitRetriever( this );
        return _circuitRetreiver.getConnectedCircuits( _breakers );
    }

    public function get id():String
    {
        return _id;
    }
}
}
