package circuit.base
{
import circuit.core.*;

import net.lists.LinkedList;
import net.lists.nodes.ListNode;

public class CircuitOperateList
{
    private var _circuits:LinkedList;

    public function set client( circuits:LinkedList ):void
    {
        _circuits = circuits;
    }

    public function invalidateAll():void
    {
        for ( var node:ListNode = _circuits.head; node; node = node.next )
        {
            node.data.invalidate();
        }
    }

    public function validateAll():void
    {
        for ( var node:ListNode = _circuits.head; node; node = node.next )
        {
            node.data.validate();
        }
    }

    public function markAllAsConnected():void
    {
        for ( var node:ListNode = _circuits.head; node; node = node.next )
        {
            node.data.markAsConnected();
        }

    }


}
}
