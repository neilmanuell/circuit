package circuit.core
{
import circuit.api.*;

public interface CircuitBoard
{
    function addEdge( breaker:Edge ):Boolean

    function addNode( circuit:Node ):Boolean

    function addSupply( powerSupply:Supply ):Boolean;
}
}
