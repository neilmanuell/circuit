package circuit.boards
{
public class CircuitBoardTest_BothSuppliesOn_B extends BaseCircuitBoardTest
{
    [Test]
    public function test():void
    {
        configureCircuit()
        assertLiveCircuits( false, true, false, false, true );
    }

    protected function configureCircuit():void
    {
        configureOpenBreakers( true, false, false, true );
        assembleBoard();
        switchOnPowerSupplyOne();
        switchOnPowerSupplyTwo();
    }
}
}
