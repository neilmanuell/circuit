package circuit.base
{
import circuit.api.Breaker;
import circuit.api.Circuit;
import circuit.api.CircuitBoard;
import circuit.api.PowerSupply;

public class SimpleCircuitBoard implements CircuitBoard
{

    private const _breakers:BreakerGroup = new BreakerGroup();
    private const _circuits:CircuitOperateList = new CircuitOperateList();

    public function SimpleCircuitBoard()
    {
    }

    public function addBreaker( breaker:Breaker ):Boolean
    {
        return _breakers.add( breaker );
    }

    public function addCircuit( circuit:Circuit ):Boolean
    {
        return _circuits.add( circuit );
    }

    public function addPowerSupply( powerSupply:PowerSupply ):Boolean
    {
        return false;
    }
}
}
