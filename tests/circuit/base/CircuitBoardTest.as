package circuit.base
{
import circuit.api.Breaker;
import circuit.api.Circuit;
import circuit.api.CircuitBoard;
import circuit.api.PowerSupply;

public class CircuitBoardTest implements CircuitBoard
{

    [Before]
    public function before():void
    {
    }

    [After]
    public function after():void
    {
    }

    [Test]
    public function test():void
    {
    }

    public function addBreaker( breaker:Breaker ):Boolean
    {
        return false;
    }

    public function addCircuit( circuit:Circuit ):Boolean
    {
        return false;
    }

    public function addPowerSupply( powerSupply:PowerSupply ):Boolean
    {
        return false;
    }
}
}
