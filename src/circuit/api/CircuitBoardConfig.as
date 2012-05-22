package circuit.api
{
public interface CircuitBoardConfig
{
    function getEdgeInstance( id:String ):Edge

    function getNodeInstance( id:String ):Node

    function getSupplyInstance( id:String ):Supply;
}
}
