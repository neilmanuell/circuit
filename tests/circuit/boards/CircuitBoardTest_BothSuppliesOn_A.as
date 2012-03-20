package circuit.boards
{
import circuit.pathfinding.*;

public class CircuitBoardTest_BothSuppliesOn_A extends BaseCircuitBoardTest
{


    [Test]
    public function test():void
    {
        configureCircuit()
        assertLiveCircuits( true, true, true, false, true );
    }

    protected function configureCircuit():void
    {
        configureOpenBreakers( false, false, true, true );
        assembleBoard();
        switchOnPowerSupplyOne();
        switchOnPowerSupplyTwo();
    }


}
}
