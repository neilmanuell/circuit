package circuit.boards
{
public class CircuitBoardTest_PS1_on_PS2_off extends BaseCircuitBoardTest
{
    [Test]
    public function test():void
    {
        configureCircuit()
        assertLiveCircuits( true, true, true, false, false );
    }

    protected function configureCircuit():void
    {
        configureOpenBreakers( false, false, true, true );
        assembleBoard();
        switchOnPowerSupplyOne();
    }
}
}
