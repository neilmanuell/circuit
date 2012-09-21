package circuit.base
{
import net.lists.LinkedList;
import net.lists.nodes.ListNode;

import org.hamcrest.assertThat;
import org.hamcrest.core.not;
import org.hamcrest.object.equalTo;

public class CircuitRetrieverTest
{
    private var _breakerLinkedList:LinkedList
    private var _classUnderTest:CircuitRetriever;
    private var _circuitA:SimpleCircuitNode;
    private var _circuitB:SimpleCircuitNode;
    private var _circuitC:SimpleCircuitNode;
    private var _circuitD:SimpleCircuitNode;
    private var _circuitE:SimpleCircuitNode;
    private var _breakerAB:SimpleBreakerEdge;
    private var _breakerAC:SimpleBreakerEdge;
    private var _breakerAD:SimpleBreakerEdge;


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

        assertLinkList( received, [ _circuitB, _circuitC, _circuitE  ] );
    }


    [Test]
    public function one_breaker_closed():void
    {
        _breakerAB.open();
        _breakerAC.open();
        _breakerAD.close();
        const received:LinkedList = _classUnderTest.getConnectedCircuits( _breakerLinkedList );

        assertLinkList( received, [ _circuitD, _circuitE ] );
    }


    [Test]
    public function all_breakers_closed():void
    {
        _breakerAB.close();
        _breakerAC.close();
        _breakerAD.close();
        const received:LinkedList = _classUnderTest.getConnectedCircuits( _breakerLinkedList );

        assertLinkList( received, [ _circuitB, _circuitC, _circuitD, _circuitE ] );
    }

    [Test]
    public function all_breakers_opened():void
    {
        _breakerAB.open();
        _breakerAC.open();
        _breakerAD.open();
        const received:LinkedList = _classUnderTest.getConnectedCircuits( _breakerLinkedList );

        assertLinkList( received, [  _circuitE ] );
    }


    private function configureCircuitBoard():void
    {
        _circuitA = new SimpleCircuitNode( "A" );
        _circuitB = new SimpleCircuitNode( "B" );
        _circuitC = new SimpleCircuitNode( "C" );
        _circuitD = new SimpleCircuitNode( "D" );
        _circuitE = new SimpleCircuitNode( "E" );

        _breakerAB = new SimpleBreakerEdge( "AB", _circuitA, _circuitB );
        _breakerAC = new SimpleBreakerEdge( "AC", _circuitA, _circuitC );
        _breakerAD = new SimpleBreakerEdge( "AD", _circuitA, _circuitD );

        _breakerLinkedList = new LinkedList();
        _breakerLinkedList.add( _circuitE );
        _breakerLinkedList.add( _breakerAB );
        _breakerLinkedList.add( _breakerAC );
        _breakerLinkedList.add( _breakerAD );
    }

    private function assertLinkList( received:LinkedList, toMatch:Array ):void
    {
        var count:int = 0;

        for ( var node:ListNode = received.head; node; node = node.next )
        {
            count++;
            assertThat( toMatch.indexOf( node.data ), not( -1 ) );
        }

        assertThat( count, equalTo( toMatch.length ) )
    }


}
}
