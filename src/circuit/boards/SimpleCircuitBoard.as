package circuit.boards
{
import circuit.api.Breaker;
import circuit.api.Circuit;
import circuit.api.CircuitBoard;
import circuit.api.PowerSupply;
import circuit.base.CircuitOperateList;
import circuit.pathfinding.CircuitPathFinder;

import net.lists.LinkedList;

public class SimpleCircuitBoard implements CircuitBoard
{
    private const _breakers:LinkedList = new LinkedList();
    private const _circuits:LinkedList = new LinkedList();
    private const _powerSupplies:LinkedList = new LinkedList();
    private const _circuitOperateList:CircuitOperateList = new CircuitOperateList();
    private const _pathfinder:CircuitPathFinder = new CircuitPathFinder();
    private var _hasChanged:Boolean = false;
    private var _isPathFinding:Boolean = false;

    private function onChildStateChanged( item:* ):void
    {
        if ( _isPathFinding )
            _hasChanged = true;
        else
        {
            do {
                pathfind();
            }
            while ( _hasChanged )

        }
    }

    public function activate():void
    {
        pathfind();
    }

    private function pathfind():void
    {
        _hasChanged = false;
        _isPathFinding = true;
        _circuitOperateList.client = _circuits;
        _circuitOperateList.invalidateAll();
        _pathfinder.findConnectionsFromPowerSupplies( _powerSupplies );
        _pathfinder.reset();
        _circuitOperateList.validateAll();
        _isPathFinding = false;

    }

    public function addBreaker( breaker:Breaker ):Boolean
    {
        if ( _breakers.has( breaker ) ) return false;
        breaker.onStateChanged.add( onChildStateChanged );
        _breakers.add( breaker );
        return true;
    }

    public function addCircuit( circuit:Circuit ):Boolean
    {
        if ( _circuits.has( circuit ) ) return false;
        _circuits.add( circuit );
        return true;
    }

    public function addPowerSupply( powerSupply:PowerSupply ):Boolean
    {
        if ( _powerSupplies.has( powerSupply ) ) return false;
        powerSupply.onStateChanged.add( onChildStateChanged );
        _powerSupplies.add( powerSupply );
        return true;
    }
}
}
