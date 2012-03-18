package circuit.api
{
public interface CircuitBoard
{
    function addBreaker( breaker:Breaker ):Boolean

    function addCircuit( circuit:Circuit ):Boolean

    function addPowerSupply( powerSupply:PowerSupply ):Boolean;
}
}
