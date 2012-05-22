package circuit.boards
{
import circuit.api.Edge;
import circuit.api.Node;
import circuit.api.Supply;

import org.hamcrest.assertThat;
import org.hamcrest.core.not;
import org.hamcrest.object.instanceOf;
import org.hamcrest.object.isTrue;
import org.hamcrest.object.strictlyEqualTo;

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
    public function getNodeInstance_returns_instanceOf_Node():void
    {
        assertThat( _classUnderTest.getNodeInstance( TEST ), instanceOf( Node ) )
    }

    [Test]
    public function getNodeInstance_returns_Node_with_passed_ID():void
    {
        assertThat( _classUnderTest.getNodeInstance( TEST ).id, TEST );
    }

    [Test]
    public function getNodeInstance_registers_Node():void
    {
        const node:Node = _classUnderTest.getNodeInstance( TEST );
        assertThat( _classUnderTest.hasNode( node ), isTrue() );
    }

    [Test]
    public function getNodeInstance_returns_same_Node_inst():void
    {
        const node:Node = _classUnderTest.getNodeInstance( TEST );
        assertThat( node,  strictlyEqualTo( _classUnderTest.getNodeInstance( TEST ) ) );
    }

    [Test]
    public function getEdgeInstance_returns_instanceOf_Edge():void
    {
        assertThat( _classUnderTest.getEdgeInstance( TEST ), instanceOf( Edge ) )
    }

    [Test]
    public function getEdgeInstance_returns_Edge_with_passed_ID():void
    {
        assertThat( _classUnderTest.getEdgeInstance( TEST ).id, TEST );
    }

    [Test]
    public function getEdgeInstance_registers_Edge():void
    {
        const edge:Edge = _classUnderTest.getEdgeInstance( TEST );
        assertThat( _classUnderTest.hasEdge( edge ), isTrue() );
    }

    [Test]
    public function getEdgeInstance_returns_same_Edge_inst():void
    {
        const edge:Edge = _classUnderTest.getEdgeInstance( TEST );
        assertThat( edge,  strictlyEqualTo( _classUnderTest.getEdgeInstance( TEST ) ) );
    }

    [Test]
    public function getSupplyInstance_returns_instanceOf_Supply():void
    {
        assertThat( _classUnderTest.getSupplyInstance( TEST ), instanceOf( Supply ) );
    }

    [Test]
    public function getSupplyInstance_returns_Supply_with_passed_ID():void
    {
        assertThat( _classUnderTest.getSupplyInstance( TEST ).id, TEST );
    }

    [Test]
    public function getSupplyInstance_registers_Supply():void
    {
        const supply:Supply = _classUnderTest.getSupplyInstance( TEST );
        assertThat( _classUnderTest.hasSupply( supply ), isTrue() );
    }

    [Test]
    public function getSupplyInstance_returns_same_Supply_inst():void
    {
        const supply:Supply = _classUnderTest.getSupplyInstance( TEST );
        assertThat( supply,  strictlyEqualTo( _classUnderTest.getSupplyInstance( TEST ) ) );
    }

    [Test]
    public function Nodes_Edges_Supplies_are_mapped_with_different_namespaces():void
    {
        const node:Node = _classUnderTest.getNodeInstance( TEST );
        const edge:Edge = _classUnderTest.getEdgeInstance( TEST );
        const supply:Supply = _classUnderTest.getSupplyInstance( TEST );
        assertThat( node,  not( edge ) );
        assertThat( edge,  not( supply ) );
        assertThat( node,  not( supply ) );
    }
}
}

