package circuit.base
{
import circuit.api.Circuit;
import circuit.core.BreakerOperate;

import net.lists.LinkedList;
import net.lists.nodes.ListNode;

public class CircuitRetriever
{
    private var _clientCircuit:Circuit;

    public function CircuitRetriever( clientCircuit:Circuit )
    {
        _clientCircuit = clientCircuit;

    }

    public function getConnectedCircuits( breakers:LinkedList ):LinkedList
    {
        const list:LinkedList = new LinkedList();

        for ( var node:ListNode = breakers.head; node; node = node.next )
        {
            const breaker:BreakerOperate = node.data;
            if ( breaker.isClosed && !list.has( breaker ) )
                list.add( breaker.getOtherCircuit( _clientCircuit ) );
        }

        return list;
    }


}
}
