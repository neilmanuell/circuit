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

    public function getConnectedCircuits( elements:LinkedList ):LinkedList
    {
        const list:LinkedList = new LinkedList();

        for ( var node:ListNode = elements.head; node; node = node.next )
        {
            const breaker:BreakerEdgeOperate = node.data as BreakerEdgeOperate;
            if ( breaker != null && breaker.isClosed && !list.has( breaker ) )
                list.add( breaker.getOtherCircuit( _clientCircuit ) )
            else if ( node.data is Node )
                list.add( node.data );
        }

        return list;
    }


}
}
