package circuit.pathfinding
{
import circuit.base.*;
import circuit.core.CircuitOperate;
import circuit.core.PowerSupplyConfig;

public class CircuitPathFinder
{
    private const _circuitList:CircuitOperateList = new CircuitOperateList();

    public function reset():void
    {
        _circuitList.reset();
    }

    public function findConnectionsFromPowerSupplies( powerSupplies:Array ):void
    {
        for each( var powerSupply:PowerSupplyConfig in powerSupplies )
            if ( powerSupply.isOn )
                _circuitList.add( powerSupply.circuit );

        while ( _circuitList.hasNext )
        {
            const circuit:CircuitOperate = _circuitList.next();
            const connectedCircuits:Array = circuit.getConnectedCircuits();
            for each ( var c:CircuitOperate in connectedCircuits )
                _circuitList.add( c );
        }

        _circuitList.markAllAsConnected();
    }

}
}
