package circuit.boards
{
import circuit.api.Edge;
import circuit.api.Node;
import circuit.api.Supply;

import org.hamcrest.assertThat;
import org.hamcrest.object.instanceOf;
import org.hamcrest.object.isTrue;

public class CircuitBoardConfigTest
{
    private const TEST:String = "test";
    private var _classUnderTest:SimpleCircuitBoard;


    [Before]
    public final function before():void
    {
        _classUnderTest = new SimpleCircuitBoard();

    }

    [After]
    public final function after():void
    {
        _classUnderTest = null;
    }


    [Test]
    public function createNode_returns_instanceOf_Node():void
    {
        assertThat( _classUnderTest.createNode( TEST ), instanceOf( Node ) )
    }

    [Test]
    public function createNode_returns_Node_with_passed_ID():void
    {
        assertThat( _classUnderTest.createNode( TEST ).id, TEST );
    }

    [Test]
    public function createNode_registers_Node():void
    {
        const node:Node = _classUnderTest.createNode( TEST );
        assertThat( _classUnderTest.hasNode( node ), isTrue() );
    }

    [Test]
    public function createEdge_returns_instanceOf_Edge():void
    {
        assertThat( _classUnderTest.createEdge( TEST ), instanceOf( Edge ) )
    }

    [Test]
    public function createEdge_returns_Edge_with_passed_ID():void
    {
        assertThat( _classUnderTest.createEdge( TEST ).id, TEST );
    }

    [Test]
    public function createEdge_registers_Edge():void
    {
        const edge:Edge = _classUnderTest.createEdge( TEST );
        assertThat( _classUnderTest.hasEdge( edge ), isTrue() );
    }

    [Test]
    public function createSupply_returns_instanceOf_Supply():void
    {
        assertThat( _classUnderTest.createSupply( TEST ), instanceOf( Supply ) );
    }

    [Test]
    public function createSupply_returns_Supply_with_passed_ID():void
    {
        assertThat( _classUnderTest.createSupply( TEST ).id, TEST );
    }

    [Test]
    public function createSupply_registers_Supply():void
    {
        const supply:Supply = _classUnderTest.createSupply( TEST );
        assertThat( _classUnderTest.hasSupply( supply ), isTrue() );
    }
}
}

