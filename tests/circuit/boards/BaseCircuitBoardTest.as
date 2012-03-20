package circuit.boards
{
import circuit.base.*;

import org.hamcrest.assertThat;
import org.hamcrest.object.equalTo;

public class BaseCircuitBoardTest
{
    private var _powerOne:SimplePowerSupply;
    private var _powerTwo:SimplePowerSupply;

    protected var _circuitA:CircuitNode;
    protected var _circuitB:CircuitNode;
    protected var _circuitC:CircuitNode;
    protected var _circuitD:CircuitNode;
    protected var _circuitE:CircuitNode;

    protected var _breakerAB:BreakerEdge;
    protected var _breakerAC:BreakerEdge;
    protected var _breakerAD:BreakerEdge;
    protected var _breakerDE:BreakerEdge;

    private var _classUnderTest:SimpleCircuitBoard;


    [Before]
    public final function before():void
    {
        _classUnderTest = new SimpleCircuitBoard();
        createData();
    }

    [After]
    public final function after():void
    {
        _classUnderTest = null;
        _circuitA = null;
        _circuitB = null;
        _circuitC = null;
        _circuitD = null;
        _circuitE = null;

        _breakerAB = null;
        _breakerAC = null;
        _breakerAD = null;
        _breakerDE = null;

        _powerOne = null;
        _powerTwo = null;
    }

    protected final function switchOnPowerSupplyOne():void
    {
        _powerOne.switchOn();
    }

    protected final function switchOffPowerSupplyOne():void
    {
        _powerOne.switchOff();
    }

    protected final function switchOnPowerSupplyTwo():void
    {
        _powerTwo.switchOn();
    }

    protected final function switchOffPowerSupplyTwo():void
    {
        _powerTwo.switchOff();
    }


    protected final function configureOpenBreakers( AB:Boolean, AC:Boolean, AD:Boolean, DE:Boolean ):void
    {
        if ( AB )_breakerAB.open();
        if ( AC )_breakerAC.open();
        if ( AD )_breakerAD.open();
        if ( DE )_breakerDE.open();
    }

    protected final function assertLiveCircuits( A:Boolean, B:Boolean, C:Boolean, D:Boolean, E:Boolean ):void
    {
        assertThat( "circuitA", _circuitA.isLive, equalTo( A ) );
        assertThat( "circuitB", _circuitB.isLive, equalTo( B ) );
        assertThat( "circuitC", _circuitC.isLive, equalTo( C ) );
        assertThat( "circuitD", _circuitD.isLive, equalTo( D ) );
        assertThat( "circuitE", _circuitE.isLive, equalTo( E ) );
    }

    protected final function assembleBoard():void
    {
        _classUnderTest.addBreaker( _breakerAB );
        _classUnderTest.addBreaker( _breakerAC );
        _classUnderTest.addBreaker( _breakerAD );
        _classUnderTest.addBreaker( _breakerDE );

        _classUnderTest.addCircuit( _circuitA );
        _classUnderTest.addCircuit( _circuitB );
        _classUnderTest.addCircuit( _circuitC );
        _classUnderTest.addCircuit( _circuitD );
        _classUnderTest.addCircuit( _circuitE );

        _classUnderTest.addPowerSupply( _powerOne );
        _classUnderTest.addPowerSupply( _powerTwo );
        _classUnderTest.activate();
    }




    private function createData():void
    {
        _circuitA = new CircuitNode( "A" );
        _circuitB = new CircuitNode( "B" );
        _circuitC = new CircuitNode( "C" );
        _circuitD = new CircuitNode( "D" );
        _circuitE = new CircuitNode( "E" );

        _breakerAB = new BreakerEdge( _circuitA, _circuitB );
        _breakerAC = new BreakerEdge( _circuitA, _circuitC );
        _breakerAD = new BreakerEdge( _circuitA, _circuitD );
        _breakerDE = new BreakerEdge( _circuitD, _circuitE );

        _circuitA.add( _breakerAB );
        _circuitA.add( _breakerAC );
        _circuitA.add( _breakerAD );

        _circuitB.add( _breakerAB );
        _circuitC.add( _breakerAC );

        _circuitD.add( _breakerAD );
        _circuitD.add( _breakerDE );

        _circuitE.add( _breakerDE );

        _powerOne = new SimplePowerSupply( _circuitB );
        _powerTwo = new SimplePowerSupply( _circuitE );


    }


}
}
