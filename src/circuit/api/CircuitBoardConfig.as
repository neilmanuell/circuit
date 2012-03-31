package circuit.api
{
public interface CircuitBoardConfig
{
    function createEdge( id:String ):Edge

    function createNode( id:String ):Node

    function createSupply( id:String ):Supply;
}
}
