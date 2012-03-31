package circuit.pathfinding
{
import circuit.base.*;

import net.lists.LinkedList;

import org.hamcrest.assertThat;
import org.hamcrest.object.equalTo;

public class BaseCircuitPathFinderTest
{
    private var _powerOne:SimplePowerSupply;
    private var _powerTwo:SimplePowerSupply;

    private var _circuitA:SimpleCircuitNode;
    private var _circuitB:SimpleCircuitNode;
    private var _circuitC:SimpleCircuitNode;
    private var _circuitD:SimpleCircuitNode;
    private var _circuitE:SimpleCircuitNode;

    private var _breakerAB:SimpleBreakerEdge;
    private var _breakerAC:SimpleBreakerEdge;
    private var _breakerAD:SimpleBreakerEdge;
    private var _breakerDE:SimpleBreakerEdge;

    private var _circuitList:LinkedList;
    private var _circuitOperateList:CircuitOperateList;
    private var _classUnderTest:CircuitPathFinder;
    private var _powerSupplies:LinkedList;

    [Before]
    public final function before():void
    {
        _classUnderTest = new CircuitPathFinder();
        createData();
    }

    [After]
    public final function after():void
    {
        _classUnderTest = null;
        _powerSupplies = null;
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


    protected final function runPathfinding():void
    {
        configureCircuit();
        _circuitOperateList.client = _circuitList;
        _circuitOperateList.invalidateAll();
        _classUnderTest.findConnectionsFromPowerSupplies( _powerSupplies );
        _circuitOperateList.validateAll();
    }

    protected function configureCircuit():void
    {

    }

    protected final function switchOnPowerSupplyOne():void
    {
        _powerOne.switchOn();
    }

    protected final function switchOnPowerSupplyTwo():void
    {
        _powerTwo.switchOn();
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
        _breakerDE = new SimpleBreakerEdge( "DE", _circuitD, _circuitE );

        _circuitA.add( _breakerAB );
        _circuitA.add( _breakerAC );
        _circuitA.add( _breakerAD );

        _circuitB.add( _breakerAB );
        _circuitC.add( _breakerAC );

        _circuitD.add( _breakerAD );
        _circuitD.add( _breakerDE );

        _circuitE.add( _breakerDE );

        _powerOne = new SimplePowerSupply( "SP1", _circuitB );
        _powerTwo = new SimplePowerSupply( "SP2", _circuitE );

        _circuitList = new LinkedList();
        _circuitList.add( _circuitA );
        _circuitList.add( _circuitB );
        _circuitList.add( _circuitC );
        _circuitList.add( _circuitD );
        _circuitList.add( _circuitE );

        _powerSupplies = new LinkedList()
        _powerSupplies.add( _powerOne );
        _powerSupplies.add( _powerTwo );

        _circuitOperateList = new CircuitOperateList();

    }


}
}
