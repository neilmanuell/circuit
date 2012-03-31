package circuit.pathfinding
{
import circuit.base.*;
import circuit.core.CircuitNodeOperate;
import circuit.core.PowerSupplyConfig;

import net.lists.LinkedList;
import net.lists.nodes.ListNode;

public class CircuitPathFinder
{
    private const _circuitList:LinkedList = new LinkedList();
    private const _circuitOperateList:CircuitOperateList = new CircuitOperateList();

    public function reset():void
    {
        _circuitList.flush();
        _circuitOperateList.client = null;
    }

    public function findConnectionsFromPowerSupplies( powerSupplies:LinkedList ):void
    {
        _circuitOperateList.client = _circuitList;
        addPowerSupplyConnections( powerSupplies );
        seekAllConnections();
        _circuitOperateList.markAllAsConnected();
    }

    private function seekAllConnections():void
    {
        for ( var node:ListNode = _circuitList.head; node; node = node.next )
        {
            const circuit:CircuitNodeOperate = node.data;
            const connectedCircuits:LinkedList = circuit.getConnectedCircuits();
            addConnectedCircuits( connectedCircuits );
        }
    }

    private function addConnectedCircuits( connectedCircuits:LinkedList ):void
    {
        for ( var node:ListNode = connectedCircuits.head; node; node = node.next )
        {
            const circuit:CircuitNodeOperate = node.data;
            if ( !_circuitList.has( circuit ) )
                _circuitList.add( circuit );
        }

    }

    private function addPowerSupplyConnections( powerSupplies:LinkedList ):void
    {
        for ( var node:ListNode = powerSupplies.head; node; node = node.next )
        {
            const powerSupply:PowerSupplyConfig = node.data;
            if ( powerSupply.isOn && !_circuitList.has( powerSupply.circuit ) )
                _circuitList.add( powerSupply.circuit );


        }
    }

}
}
