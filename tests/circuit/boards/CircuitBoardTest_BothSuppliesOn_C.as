package circuit.boards
{
public class CircuitBoardTest_BothSuppliesOn_C extends BaseCircuitBoardTest
{
    [Test]
    public function test():void
    {
        configureCircuit()
        assertLiveCircuits( false, true, false, true, true );
    }

    protected function configureCircuit():void
    {
        configureOpenBreakers( true, true, true, false );
        switchOnPowerSupplyOne();
        switchOnPowerSupplyTwo();
    }
}
}
