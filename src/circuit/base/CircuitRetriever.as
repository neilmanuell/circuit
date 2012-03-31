package circuit.base
{
import circuit.api.Node;
import circuit.core.BreakerEdgeOperate;

import net.lists.LinkedList;
import net.lists.nodes.ListNode;

public class CircuitRetriever
{
    private var _clientCircuit:Node;

    public function CircuitRetriever( clientCircuit:Node )
    {
        _clientCircuit = clientCircuit;

    }

    public function getConnectedCircuits( breakers:LinkedList ):LinkedList
    {
        const list:LinkedList = new LinkedList();

        for ( var node:ListNode = breakers.head; node; node = node.next )
        {
            const breaker:BreakerEdgeOperate = node.data;
            if ( breaker.isClosed && !list.has( breaker ) )
                list.add( breaker.getOtherCircuit( _clientCircuit ) );
        }

        return list;
    }


}
}
