package circuit.boards
{
import circuit.api.Breaker;
import circuit.api.Circuit;
import circuit.api.CircuitBoard;
import circuit.api.PowerSupply;
import circuit.base.*;
import circuit.core.CircuitOperate;
import circuit.pathfinding.CircuitPathFinder;

public class SimpleCircuitBoard implements CircuitBoard
{

    private const _breakers:BreakerGroup = new BreakerGroup();
    private const _circuits:CircuitOperateList = new CircuitOperateList();
    private const _powerSupplies:PowerSupplyGroup = new PowerSupplyGroup();
    private const _pathfinder:CircuitPathFinder = new CircuitPathFinder();

    public function SimpleCircuitBoard()
    {
        initiate();
    }

    private function initiate():void
    {
        _breakers.onStateChanged.add( onBreakerStateChanged );
        _powerSupplies.onStateChanged.add( onPowerSuppliesStateChanged )
    }

    private function onBreakerStateChanged( breaker:Breaker ):void
    {
        pathfind();
    }

    private function onPowerSuppliesStateChanged( breaker:Breaker ):void
    {
        pathfind();
    }

    private function pathfind():void
    {
        _circuits.invalidateAll();
        _pathfinder.findConnectionsFromPowerSupplies(_powerSupplies);
        _circuits.validateAll();
        _pathfinder.reset();

    }

    public function addBreaker( breaker:Breaker ):Boolean
    {
        return _breakers.add( breaker );
    }

    public function addCircuit( circuit:Circuit ):Boolean
    {
        return _circuits.add( circuit as CircuitOperate );
    }

    public function addPowerSupply( powerSupply:PowerSupply ):Boolean
    {
        return _powerSupplies.add( powerSupply );
    }
}
}
