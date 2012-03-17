package circuit.base
{
import org.hamcrest.assertThat;
import org.hamcrest.collection.array;
import org.hamcrest.collection.emptyArray;

public class CircuitRetrieverTest
{
    private var _received:Boolean = false;
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
        const received:Array = _classUnderTest.getConnectedCircuits( [_breakerAB, _breakerAC, _breakerAD] );

        assertThat( received, array( _circuitB, _circuitC ) );
    }

    [Test]
    public function one_breaker_closed():void
    {
        _breakerAB.open();
        _breakerAC.open();
        _breakerAD.close();
        const received:Array = _classUnderTest.getConnectedCircuits( [_breakerAB, _breakerAC, _breakerAD] );

        assertThat( received, array( _circuitD ) );
    }

    [Test]
    public function all_breakers_closed():void
    {
        _breakerAB.close();
        _breakerAC.close();
        _breakerAD.close();
        const received:Array = _classUnderTest.getConnectedCircuits( [_breakerAB, _breakerAC, _breakerAD] );

        assertThat( received, array( _circuitB, _circuitC, _circuitD ) );
    }
    [Test]
    public function all_breakers_opened():void
    {
        _breakerAB.open();
        _breakerAC.open();
        _breakerAD.open();
        const received:Array = _classUnderTest.getConnectedCircuits( [_breakerAB, _breakerAC, _breakerAD] );

        assertThat( received,  emptyArray()  );
    }


    private function configureCircuitBoard():void
    {
        _circuitA = new CircuitNode();
        _circuitB = new CircuitNode();
        _circuitC = new CircuitNode();
        _circuitD = new CircuitNode();

        _breakerAB = new BreakerEdge( _circuitA, _circuitB );
        _breakerAC = new BreakerEdge( _circuitA, _circuitC );
        _breakerAD = new BreakerEdge( _circuitA, _circuitD );

        _circuitA.add( _breakerAB );
        _circuitA.add( _breakerAC );
        _circuitA.add( _breakerAD );

        _circuitB.add( _breakerAB );
        _circuitC.add( _breakerAC );
        _circuitD.add( _breakerAD );


    }


}
}
