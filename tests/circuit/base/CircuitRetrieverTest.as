package circuit.base
{
import net.lists.LinkedList;
import net.lists.nodes.ListNode;

import org.hamcrest.assertThat;
import org.hamcrest.core.not;

public class CircuitRetrieverTest
{
    private var _breakerLinkedList:LinkedList
    private var _classUnderTest:CircuitRetriever;
    private var _circuitA:CircuitNode;
    private var _circuitB:CircuitNode;
    private var _circuitC:CircuitNode;
    private var _circuitD:CircuitNode;
    private var _breakerAB:BreakerEdge;
    private var _breakerAC:BreakerEdge;
    private var _breakerAD:BreakerEdge;


    [Before]
    public function before():void
    {
        configureCircuitBoard();
        _classUnderTest = new CircuitRetriever( _circuitA );
    }


    [After]
    public function after():void
    {
        _classUnderTest = null;
    }


    [Test]
    public function one_breaker_open():void
    {
        _breakerAB.close();
        _breakerAC.close();
        _breakerAD.open();

        const received:LinkedList = _classUnderTest.getConnectedCircuits( _breakerLinkedList );

        assertLinkList( received, [ _circuitB, _circuitC ] );
    }


    [Test]
    public function one_breaker_closed():void
    {
        _breakerAB.open();
        _breakerAC.open();
        _breakerAD.close();
        const received:LinkedList = _classUnderTest.getConnectedCircuits( _breakerLinkedList );

        assertLinkList( received, [ _circuitD ] );
    }


    [Test]
    public function all_breakers_closed():void
    {
        _breakerAB.close();
        _breakerAC.close();
        _breakerAD.close();
        const received:LinkedList = _classUnderTest.getConnectedCircuits( _breakerLinkedList );

        assertLinkList( received, [ _circuitB, _circuitC, _circuitD ] );
    }

    [Test]
    public function all_breakers_opened():void
    {
        _breakerAB.open();
        _breakerAC.open();
        _breakerAD.open();
        const received:LinkedList = _classUnderTest.getConnectedCircuits( _breakerLinkedList );

        assertLinkList( received, [  ] );
    }


    private function configureCircuitBoard():void
    {
        _circuitA = new CircuitNode("A");
        _circuitB = new CircuitNode("B");
        _circuitC = new CircuitNode("C");
        _circuitD = new CircuitNode("D");

        _breakerAB = new BreakerEdge( "AB", _circuitA, _circuitB );
        _breakerAC = new BreakerEdge( "AC",_circuitA, _circuitC );
        _breakerAD = new BreakerEdge( "AD",_circuitA, _circuitD );

        _circuitA.add( _breakerAB );
        _circuitA.add( _breakerAC );
        _circuitA.add( _breakerAD );

        _circuitB.add( _breakerAB );
        _circuitC.add( _breakerAC );
        _circuitD.add( _breakerAD );

        _breakerLinkedList = new LinkedList();
        _breakerLinkedList.add( _breakerAB );
        _breakerLinkedList.add( _breakerAC );
        _breakerLinkedList.add( _breakerAD )  ;
    }

    private function assertLinkList( received:LinkedList, toMatch:Array ):void
    {
        for ( var node:ListNode = received.head; node; node = node.next )
        {
            assertThat( toMatch.indexOf( node.data ), not( -1 ) );
        }
    }


}
}
