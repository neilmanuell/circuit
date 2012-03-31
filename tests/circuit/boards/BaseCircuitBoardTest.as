package circuit.boards
{
import circuit.base.*;

import org.hamcrest.assertThat;
import org.hamcrest.object.equalTo;

public class BaseCircuitBoardTest
{
    private var _powerOne:SimplePowerSupply;
    private var _powerTwo:SimplePowerSupply;

    protected var _circuitA:SimpleCircuitNode;
    protected var _circuitB:SimpleCircuitNode;
    protected var _circuitC:SimpleCircuitNode;
    protected var _circuitD:SimpleCircuitNode;
    protected var _circuitE:SimpleCircuitNode;

    protected var _breakerAB:SimpleBreakerEdge;
    protected var _breakerAC:SimpleBreakerEdge;
    protected var _breakerAD:SimpleBreakerEdge;
    protected var _breakerDE:SimpleBreakerEdge;

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
        _classUnderTest.addEdge( _breakerAB );
        _classUnderTest.addEdge( _breakerAC );
        _classUnderTest.addEdge( _breakerAD );
        _classUnderTest.addEdge( _breakerDE );

        _classUnderTest.addNode( _circuitA );
        _classUnderTest.addNode( _circuitB );
        _classUnderTest.addNode( _circuitC );
        _classUnderTest.addNode( _circuitD );
        _classUnderTest.addNode( _circuitE );

        _classUnderTest.addSupply( _powerOne );
        _classUnderTest.addSupply( _powerTwo );
        _classUnderTest.activate();
    }


    private function createData():void
    {
        _circuitA = new SimpleCircuitNode( "A" );
        _circuitB = new SimpleCircuitNode( "B" );
        _circuitC = new SimpleCircuitNode( "C" );
        _circuitD = new SimpleCircuitNode( "D" );
        _circuitE = new SimpleCircuitNode( "E" );

        _breakerAB = new SimpleBreakerEdge( "AB", _circuitA, _circuitB );
        _breakerAC = new SimpleBreakerEdge( "AC", _circuitA, _circuitC );
        _breakerAD = new SimpleBreakerEdge( "AD", _circuitA, _circuitD );
        _breakerDE = new SimpleBreakerEdge( "AE", _circuitD, _circuitE );

        _circuitA.add( _breakerAB );
        _circuitA.add( _breakerAC );
        _circuitA.add( _breakerAD );

        _circuitB.add( _breakerAB );
        _circuitC.add( _breakerAC );

        _circuitD.add( _breakerAD );
        _circuitD.add( _breakerDE );

        _circuitE.add( _breakerDE );

        _powerOne = new SimplePowerSupply( "PS1", _circuitB );
        _powerTwo = new SimplePowerSupply( "PS2", _circuitE );


    }


}
}
