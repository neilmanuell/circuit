package circuit.base
{
import circuit.api.Breaker;
import circuit.api.Circuit;
import circuit.core.*;
import circuit.signals.CircuitStateChangedSignal;

import net.lists.LinkedList;

public class CircuitNode implements Circuit, CircuitConfig, CircuitOperate
{
    private var _id:String;
    private var _isConnected:Boolean = false;
    private var _isLive:Boolean = false;
    private var _circuitRetreiver:CircuitRetriever;
    private const _breakers:LinkedList = new LinkedList();
    private const _onStateChange:CircuitStateChangedSignal = new CircuitStateChangedSignal();


    public function CircuitNode( id:String )
    {
        _id = id;
    }

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
        _breakers.add( breaker );
        return true;
    }

    public function has( breaker:Breaker ):Boolean
    {
        return (_breakers.has( breaker ));
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
            _onStateChange.dispatchCircuit( this );
        }
        else if ( !_isConnected && _isLive )
        {
            _isLive = false;
            _onStateChange.dispatchCircuit( this );
        }
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
